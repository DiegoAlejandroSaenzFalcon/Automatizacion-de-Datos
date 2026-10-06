# Comandos del repositorio documental

.PHONY: help docs docs-serve check clean

MKDOCS := mkdocs

.DEFAULT_GOAL := help

help:
	@echo "Comandos disponibles:"
	@echo "  make docs       Construye la documentación"
	@echo "  make docs-serve Sirve la documentación localmente"
	@echo "  make check      Ejecuta la validación documental"
	@echo "  make clean      Limpia la salida de documentación"

docs:
	$(MKDOCS) build --strict

docs-serve:
	$(MKDOCS) serve --dev-addr=127.0.0.1:8000

check:
	$(MKDOCS) build --strict

clean:
	rm -rf site
