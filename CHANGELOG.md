# Historial de cambios

Todos los cambios notables de este proyecto se documentan en este archivo.

El formato sigue [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/lang/es/).

---

## [Sin liberar]

### Añadido
- Andamiaje completo del monorepositorio profesional (`data-tools-workshop`)
- `pyproject.toml` raíz con workspaces (hatch) y dependencias opcionales por herramienta
- `Makefile` con comandos unificados (`check`, `test`, `lint`, `format`, `type-check`, `docs`, `release`)
- `.pre-commit-config.yaml` con hooks: ruff, black, mypy, commitizen, detect-secrets
- CI/CD GitHub Actions: `ci.yml` (lint+types+tests), `docs.yml` (MkDocs deploy), `release.yml` (semantic release)
- Documentación MkDocs + GitHub Pages deploy automático
- `CODE_OF_CONDUCT.md`, `CONTRIBUTING.md`, `CHANGELOG.md`, `LICENSE` (MIT)
- Andamiaje de monorepositorio: `tools/`, `docs/`, `docs-site/`, `.github/workflows/`, `examples/`, `scripts/`

### Cambiado
- Migración de repositorios individuales a monorepositorio unificado `data-tools-workshop`

### Corregido
- N/A

---

## [0.2.0] - 2025-09-05

### Añadido - data-processor v2.0
- Auto-detección de encoding (utf-8-sig, latin-1, cp1252) — nunca falla al leer
- Deduplicación **insensible a mayúsculas/acentos** (`normalizar_texto` con NFD + unicodedata)
- Procesa **todas las hojas** de un Excel o una específica (`--hoja`)
- Modo `--vista-previa`: muestra filas vacías, duplicados exactos y resumen antes de guardar
- Exporta a **xlsx (números reales)**, **csv (punto y coma)**, **json**
- Menú interactivo (`python procesador.py` sin args) — guía paso a paso al usuario
- `README.md` didáctico explicando cada función (qué, por qué, cómo, ejemplo)

### Cambiado - data-processor v2.0
- Refactor completo: funciones pequeñas, docstrings Google, type hints, sin código espagueti
- `guardar_limpio`: exporta a xlsx (números reales int/float), csv (punto y coma), json
- `calcular_vista_previa`: fórmula exacta de duplicados (excluye cabecera)

### Corregido - data-processor v2.0
- Corrección fórmula de conteo de duplicados (excluye cabecera correctamente)
- Lectura CSV con auto-encoding (nunca falla por acentos rotos)
- Deduplicación insensible a mayúsculas/acentos verificada con pruebas reales

---

## [0.1.0] - 2025-09-04

### Añadido - Proyectos iniciales (repositorios individuales pre-monorepositorio)
- **Procesador de Datos v1.0**: Limpieza básica CSV/Excel (vacíos, duplicados exactos, espacios)
- **PDF a Excel**: Extracción de tablas con `pdfplumber` → Excel/CSV
- **Convertidor de Archivos**: CSV ↔ Excel ↔ JSON
- **Curriculum-Vitae**: CV honesto en GitHub Pages
- **Soporte-TI-Portafolio**: Guías técnicas (Google IT Support, redes, Linux, seguridad)
- **Materiales de oferta**: Fiverr/Workana templates, imágenes Gig, PDF ejemplo

### Infraestructura
- Repositorios individuales publicados en GitHub
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
- [ ] Documentación business (precios, búsqueda-clientes, entrega)
- [ ] Release automation (semantic-release + changelog auto)

### [1.0.0] - Primera versión estable
- [ ] Monorepositorio completo, documentado, testeado, deployado
- [ ] Tres herramientas listas para vender + docs para aprender
- [ ] Portafolio unificado profesional

---

## Próximas versiones planificadas

### [0.5.0] — "CI/CD & Release Automation"

**Objetivo:** Pipeline completo automatizado.

| Pipeline | Qué hace |
|---|---|
| `ci.yml` | lint (ruff) + type-check (mypy strict) + tests (pytest + coverage) en matrix 3.10/3.11/3.12 |
| `docs.yml` | MkDocs build + deploy a GitHub Pages |
| `release.yml` | Tag `v*` → cz bump → changelog → tag → GitHub Release → (opcional) PyPI |

**Criterio de done:** Push tag `v0.5.0` → release automático en GitHub + docs actualizadas en Pages.

### [0.6.0] — "Tooling v2.0" (Mejoras funcionales)

| Herramienta | Mejoras |
|---|---|
| **data-processor** | `--carpeta` (procesa carpeta completa), dedup difuso (similitud >85%), auto-detección fechas/emails, barra de progreso, export Parquet/SQLite, config YAML |
| **pdf-to-excel** | OCR opcional (Tesseract), unir tablas consecutivas, áreas de extracción fijas (config YAML), procesar carpeta |
| **file-converter** | Multi-hoja Excel (`--hoja`), auto-separador CSV, validación JSON schema, Parquet, streaming >100MB |
| **shared** | CLI base (Click/Rich), logging estructurado (loguru), config pydantic-settings, exceptions jerárquicas |

### [1.0.0] — "First Stable Release"

**Criterios de release:**
- Monorepositorio completo, testeado, documentado
- 3 herramientas v1.0+ instalables independientemente
- CI/CD verde en matrix 3.10/3.11/3.12
- Docs en GitHub Pages actualizadas
- Release automation funcionando
- 3 herramientas listas para vender + docs para aprender
- Portafolio unificado profesional

---

## Post-1.0 — Ideas para 1.x

| Área | Ideas |
|---|---|
| **Nuevas herramientas** | `data-validator` (schema validation), `data-merger` (merge CSV/Excel), `api-client` (genérico REST/GraphQL) |
| **Integraciones** | Google Sheets API, Airtable, Notion, SQL databases |
| **IA/ML** | `data-profiler` (perfilado automático), `anomaly-detector` (outliers) |
| **Producto** | CLI → TUI (Textual), Web UI opcional (FastAPI + HTMX) |
| **Negocio** | Plantillas de contratos, facturación automática, CRM ligero |

---

## Cómo proponer cambios a la hoja de ruta

1. Abre un **issue** con label `hoja-de-ruta`
2. Describe: qué, por qué, esfuerzo estimado, impacto
3. Discusión en el issue → decisión → se añade al milestone correspondiente