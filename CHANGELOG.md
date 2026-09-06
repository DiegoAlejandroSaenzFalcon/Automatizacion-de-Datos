# Changelog

Todos los cambios notables de este proyecto se documentan en este archivo.

El formato sigue [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/lang/es/).

---

## [Unreleased]

### Added
- Scaffold completo del monorepo profesional (`data-tools-workshop`)
- `pyproject.toml` raíz con workspaces (hatch) y dependencias opcionales por herramienta
- `Makefile` con comandos unificados (`check`, `test`, `lint`, `format`, `type-check`, `docs`, `release`)
* `.pre-commit-config.yaml` con hooks: ruff, black, mypy, commitizen, detect-secrets
* CI/CD GitHub Actions: `ci.yml` (lint+types+tests), `docs.yml` (MkDocs deploy), `release.yml` (semantic release)
* Documentación MkDocs + GitHub Pages deploy automático
* `CODE_OF_CONDUCT.md`, `CONTRIBUTING.md`, `CHANGELOG.md`, `LICENSE` (MIT)
* Scaffold de monorepo: `tools/`, `docs/`, `docs-site/`, `.github/workflows/`, `examples/`, `scripts/`

### Changed
- Migración de repos individuales a monorepo unificado `data-tools-workshop`

### Fixed
- N/A

---

## [0.2.0] - 2025-09-05

### Added - data-processor v2.0
- Auto-detección de encoding (utf-8-sig, latin-1, cp1252) — nunca falla al leer
- Deduplicación **insensible a mayúsculas/acentos** (`normalizar_texto` con NFD + unicodedata)
- Procesa **todas las hojas** de un Excel o una específica (`--hoja`)
- Modo `--preview`: muestra filas vacías, duplicados exactos y resumen antes de guardar
- Exporta a **xlsx (números reales)**, **csv (punto y coma)**, **json**
- Menú interactivo (`python procesador.py` sin args) — guía paso a paso al usuario
* `README.md` didáctico explicando cada función (qué, por qué, cómo, ejemplo)

### Changed - data-processor v2.0
- Refactor completo: funciones pequeñas, docstrings Google, type hints, sin código espagueti
- `guardar_limpio`: exporta a xlsx (números reales int/float), csv (punto y coma), json
* `calcular_preview`: fórmula exacta de duplicados (excluye cabecera)

### Fixed - data-processor v2.0
- Corrección fórmula de conteo de duplicados (excluye cabecera correctamente)
- Lectura CSV con auto-encoding (nunca falla por acentos rotos)
- Deduplicación insensible a mayúsculas/acentos verificada con pruebas reales

---

## [0.1.0] - 2025-09-04

### Added - Proyectos iniciales (repos individuales pre-monorepo)
- **Procesador de Datos v1.0**: Limpieza básica CSV/Excel (vacíos, duplicados exactos, espacios)
- **PDF a Excel**: Extracción de tablas con `pdfplumber` → Excel/CSV
- **Convertidor de Archivos**: CSV ↔ Excel ↔ JSON
- **Curriculum-Vitae**: CV honesto en GitHub Pages
- **Soporte-TI-Portafolio**: Guías técnicas (Google IT Support, redes, Linux, seguridad)
- **Materiales de oferta**: Fiverr/Workana templates, imágenes Gig, PDF ejemplo

### Infrastructure
- Repos individuales publicados en GitHub
- `gh` autenticado, `git` configurado
- Entorno: Python 3.12, VS Code, git, gh, winget, Node.js

---

## Próximas versiones planificadas

### [0.3.0] - Próxima
- [ ] `shared/` paquete común (CLI base, exceptions, logging, config, utils)
- [ ] `pdf-to-excel` migrado a paquete instalable con tests
- [ ] `file-converter` migrado a paquete instalable con tests
- [ ] MkDocs + GitHub Pages deploy automático
- [ ] Tutoriales 01-04 en `docs/tutorials/`
- [ ] CI/CD completo (lint + types + tests + docs deploy + release automation)

### [0.4.0]
- [ ] Tutoriales paso a paso (01-desde-cero, 02-procesador, 03-pdf, 04-convertidor, 04-negocio)
- [ ] Documentación business (pricing, finding-clients, delivery)
- [ ] Release automation (semantic-release + changelog auto)

### [1.0.0] - Primera versión estable
- [ ] Monorepo completo, documentado, testeado, deployado
- [ ] Tres herramientas listas para vender + docs para aprender
- [ ] Portafolio unificado profesional