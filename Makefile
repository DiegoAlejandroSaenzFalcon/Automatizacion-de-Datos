# Makefile para data-tools-workshop
# Comandos comunes para desarrollo, testing, linting, docs y release

.PHONY: help install install-dev test test-unit test-integration lint format type-check check docs docs-serve build clean release

# Configuración
PYTHON := python
PIP := pip
RUFF := ruff
BLACK := black
MYPY := mypy
PYTEST := pytest
MKDOCS := mkdocs
PRE_COMMIT := pre-commit

# Directorios
TOOLS_DIR := tools
DOCS_DIR := docs
DOCS_SITE_DIR := docs-site

# Por defecto
.DEFAULT_GOAL := help

help: ## Muestra esta ayuda
	@echo "Comandos disponibles:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# ============================================================
# Instalación
# ============================================================

install: ## Instala dependencias de producción
	$(PIP) install -e .[data-processor,pdf-to-excel,file-converter,shared]

install-dev: ## Instala entorno de desarrollo completo
	$(PIP) install -e .[dev,data-processor,pdf-to-excel,file-converter,shared,docs]
	$(PRE_COMMIT) install
	$(PRE_COMMIT) install --hook-type commit-msg

# ============================================================
# Testing
# ============================================================

test: ## Ejecuta todos los tests
	$(PYTEST) --cov=tools --cov-report=term-missing --cov-report=xml

test-unit: ## Solo tests unitarios (rápidos)
	$(PYTEST) -m "not slow and not integration" --cov=tools --cov-report=term-missing

test-integration: ## Tests de integración (lentos)
	$(PYTEST) -m integration -v

test-watch: ## Tests en modo watch (requiere pytest-watch)
	$(PYTEST) --watch

# ============================================================
# Calidad de código
# ============================================================

lint: ## Lint con ruff (rápido, auto-fix)
	$(RUFF) check --fix .
	$(RUFF) format --check .

format: ## Formatea código con black y ruff
	$(RUFF) format .
	$(BLACK) .

type-check: ## Type-check con mypy (strict)
	$(MYPY) .

check: lint type-check test ## Ejecuta todo el pipeline de calidad (lint + types + tests)

# ============================================================
# Documentación
# ============================================================

docs: ## Construye la documentación (MkDocs)
	$(MKDOCS) build -f docs-site/mkdocs.yml --strict

docs-serve: ## Sirve la documentación localmente (live-reload)
	$(MKDOCS) serve -f docs-site/mkdocs.yml --dev-addr=0.0.0.0:8000

docs-deploy: ## Despliega docs a GitHub Pages (requiere gh-pages branch)
	$(MKDOCS) gh-deploy -f docs-site/mkdocs.yml --force

# ============================================================
# Build & Release
# ============================================================

build: clean ## Construye paquetes wheel/sdist
	hatch build

clean: ## Limpia artefactos de build
	rm -rf dist build *.egg-info .coverage htmlcov .coverage.* .pytest_cache .mypy_cache .ruff_cache
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true

release: check ## Ejecuta checks y crea release (tag + changelog)
	@echo "Preparando release..."
	cz bump --yes
	git push --follow-tags
	gh release create v$(shell cz version --project) --generate-notes

# ============================================================
# Utilidades
# ============================================================

pre-commit-run: ## Ejecuta pre-commit en todos los archivos
	$(PRE_COMMIT) run --all-files

update-deps: ## Actualiza dependencias a versiones compatibles
	$(PIP) install --upgrade $(PIP) list --outdated --format=freeze | grep -v '^\-e' | cut -d= -f1 | xargs -n1 pip install --upgrade

security-scan: ## Escaneo de seguridad básico
	pip-audit

# ============================================================
# Herramientas individuales (para desarrollo aislado)
# ============================================================

install-processor: ## Instala solo data-processor en modo editable
	$(PIP) install -e tools/data-processor[dev]

install-pdf: ## Instala solo pdf-to-excel en modo editable
	$(PIP) install -e tools/pdf-to-excel[dev]

install-converter: ## Instala solo file-converter en modo editable
	$(PIP) install -e tools/file-converter[dev]

install-shared: ## Instala solo shared en modo editable
	$(PIP) install -e tools/shared[dev]

test-processor: ## Tests solo de data-processor
	$(PYTEST) tools/data-processor/tests -v

test-pdf: ## Tests solo de pdf-to-excel
	$(PYTEST) tools/pdf-to-excel/tests -v

test-converter: ## Tests solo de file-converter
	$(PYTEST) tools/file-converter/tests -v

test-shared: ## Tests solo de shared
	$(PYTEST) tools/shared/tests -v