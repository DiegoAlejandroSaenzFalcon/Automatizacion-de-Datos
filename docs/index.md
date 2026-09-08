# Automatizacion de Datos: Herramientas

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python](https://img.shields.io/badge/Python-3.11+-blue.svg)](https://www.python.org/downloads/)
[![Status](https://img.shields.io/badge/Status-Active-brightgreen.svg)]
[![GitHub Pages](https://img.shields.io/badge/Docs-GitHub%20Pages-brightgreen.svg)](https://diegoalejandrosaenzfalcon.github.io/Automatizacion-de-Datos/)
[![CI/CD](https://img.shields.io/badge/CI-GitHub%20Actions-blue.svg)](https://github.com/features/actions)
[![Autor](https://img.shields.io/badge/Autor-Diego%20Alejandro%20Saenz%20Falcon-blue.svg)](https://github.com/DiegoAlejandroSaenzFalcon)

**Herramientas Profesionales de datos para automatización, limpieza y conversión.**
Código didáctico, testeado, documentado y listo para producción.

---

## Qué es esto

Un **monorepositorio profesional** que agrupa tres herramientas de datos reales, listas para vender como servicio y diseñadas para que **cualquiera pueda aprender a construirlas leyendo el código y la documentación**.

| Herramienta | Qué hace | Estado |
|---|---|---|
| **data-processor** | Limpia CSV/Excel: elimina vacíos, duplicados (incluso con mayúsculas/acentos), normaliza espacios, exporta xlsx/csv/json | ✅ v2.0 |
| **pdf-to-excel** | Extrae tablas de PDF y las guarda en Excel/CSV | ✅ v1.0 |
| **file-converter** | Convierte entre CSV, Excel (.xlsx) y JSON | ✅ v1.0 |

> **Filosofía:** Código que enseña. Cada función tiene docstring explicando **qué hace, por qué y cómo**. La documentación técnica (`docs/`) y los tutoriales (`docs/tutorials/`) guían paso a paso desde cero hasta tener un servicio vendible.

---

## Inicio rápido

```bash
# 1. Clona el repositorio
git clone https://github.com/DiegoAlejandroSaenzFalcon/Automatizacion-de-Datos.git
cd Automatizacion-de-Datos

# 2. Instala entorno de desarrollo completo
make install-dev

# 3. Verifica que todo funciona
make check
```

### Uso rápido de cada herramienta

```bash
# data-processor: limpia CSV/Excel
python -m data_processor datos.csv --vista-previa
python -m data_processor datos.xlsx --salida json

# pdf-to-excel: extrae tablas de PDF
python -m pdf_to_excel factura.pdf --salida xlsx

# file-converter: convierte entre formatos
python -m file_converter datos.csv --a xlsx
python -m file_converter datos.xlsx --a json
```

---

## Arquitectura del monorepositorio

```
Automatizacion-de-Datos/
├── tools/                    # Herramientas como paquetes independientes
│   ├── data-processor/       # Limpieza CSV/Excel (v2.0)
│   ├── pdf-to-excel/         # PDF → Excel/CSV
│   ├── file-converter/       # CSV ↔ Excel ↔ JSON
│   └── shared/               # Código común (CLI, exceptions, utils, logging, config)
├── examples/                 # Datos de prueba reales
├── scripts/                  # Utilidades de desarrollo
├── docs/                     # Documentación técnica + pedagógica (Markdown)
├── docs-site/                # MkDocs config para GitHub Pages
├── .github/workflows/        # CI/CD (lint, types, tests, docs, release)
├── pyproject.toml            # Configuración raíz + workspaces
├── Makefile                  # Comandos comunes (make test, make lint, make docs...)
├── .pre-commit-config.yaml   # Hooks de calidad automáticos
└── CHANGELOG.md              # Historial de versiones
```

---

## Pila tecnológica (estándar 2024)

| Capa | Herramienta | Por qué |
|---|---|---|
| **Empaquetado** | `pyproject.toml` + `hatch` | Workspaces, lockfile, build moderno |
| **Lint/Format** | `ruff` + `black` | Unificado, rápido, auto-fix |
| **Type-check** | `mypy` (strict) | Código robusto, autodocumentado |
| **Tests** | `pytest` + `pytest-cov` | Fixtures, parametrize, coverage |
| **Docs** | `MkDocs` + `mkdocstrings` + Material | API docs auto-generadas, GitHub Pages gratis |
| **CI/CD** | GitHub Actions | Matrix testing, deploy docs, release automático |
| **Versionado** | `commitizen` + `changelog` | SemVer automático, changelog generado |
| **Pre-commit** | `ruff` + `black` + `mypy` + `commitizen` | Bloquea confirmaciones sucias |

---

## Comandos útiles (Makefile)

```bash
make install-dev      # Entorno de desarrollo completo
make check            # lint + type-check + tests (pipeline completo)
make test             # Solo tests
make lint             # Lint + format check
make type-check       # mypy strict
make test-unit        # Tests rápidos (sin integración)
make docs-serve       # Sirve docs localmente (live-reload)
make docs             # Construye docs estáticas
make build            # Construye wheel/sdist
make release          # Check + bump version + tag + changelog + push
make clean            # Limpia artefactos
```

---

## Testing

```bash
# Todos los tests con coverage
make test

# Solo unitarios (rápidos)
make test-unit

# Solo de una herramienta
make test-processor
make test-pdf
make test-converter
make test-shared
```

---

## Documentación

La documentación vive en `docs/` y se publica automáticamente en **GitHub Pages**:

- **Tutoriales paso a paso**: `docs/tutorials/`
  - `01-desde-cero.md` — Entorno, Git, Python, primer script
  - `02-procesador-datos.md` — Construir data-processor desde cero
  - `03-pdf-a-excel.md` — Construir pdf-to-excel desde cero
  - `04-convertidor-archivos.md` — Construir file-converter desde cero
  - `04-de-codigo-a-servicio.md` — De código a servicio vendible
- **Arquitectura**: `docs/architecture/`
- **Referencia de herramientas**: `docs/tools/`
- **Negocio**: `docs/business/` (precios, búsqueda-clientes, entrega)

### Ver docs localmente

```bash
make docs-serve
# Abre http://localhost:8000
```

---

## CI/CD (GitHub Actions)

| Workflow | Qué hace | Cuándo |
|---|---|---|
| `ci.yml` | lint (ruff) + type-check (mypy) + tests (pytest + coverage) | Push/PR a main |
| `docs.yml` | Construye MkDocs + deploy a GitHub Pages | Push a main / manual |
| `release.yml` | Semantic release (cz bump, tag, changelog, GitHub Release) | Tag `v*` / manual |

---

## Versionado y Releases

Usamos **Semantic Versioning** (SemVer) + **Conventional Commits**:

```bash
# Formato commit: tipo(scope): descripción
feat(processor): añade deduplicación difusa
fix(pdf): corrige extracción en PDF sin bordes
docs(readme): actualiza instrucciones de uso
chore(deps): actualiza dependencias
```

### Crear release

```bash
make release
# Equivale a: check + cz bump + tag + push + gh release create
```

El historial de cambios (`CHANGELOG.md`) se genera automáticamente.

---

## Contribuir

1. Lee `CONTRIBUTING.md`
2. Fork + branch `feat/tu-mejora`
3. Confirmaciones convencionales (`feat:`, `fix:`, `docs:`, `chore:`)
4. `make check` pasa
5. Pull Request con descripción clara

Ver `CONTRIBUTING.md` y `CODE_OF_CONDUCT.md` para detalles.

---

## Licencia

MIT — libre para usar, modificar, distribuir. Ver `LICENSE`.

---

## Autor

**Diego Alejandro Sáenz Falcón**  
`diegoalejandrosaenzfalcon@gmail.com`  
GitHub: [@DiegoAlejandroSaenzFalcon](https://github.com/DiegoAlejandroSaenzFalcon)

> *Construido en público, aprendiendo en público, entregando en serio.*