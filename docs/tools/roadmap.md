# Hoja de ruta — data-tools-workshop

Plan de evolución del monorepositorio. Cada versión sigue SemVer.

---

## Versión actual: 0.2.0 (actual)

**Estado:** Monorepositorio funcional con 3 herramientas v2.0/v1.0, CI/CD, docs, tests.

| Herramienta | Versión | Estado |
|---|---|---|
| data-processor | 2.0.0 | Completo |
| pdf-to-excel | 1.0.0 | Completo |
| file-converter | 1.0.0 | Completo |

---

## 0.3.0 — "Shared Foundation" (Próxima)

**Objetivo:** Extraer código común a `tools/shared/` y migrar herramientas a paquetes instalables.

| Tarea | Detalle |
|---|---|
| `tools/shared/` | CLI base (Click/Rich), exceptions, logging, config (pydantic-settings), utils |
| Migrar data-processor | Paquete instalable `src/data_processor/`, tests, pyproject.toml propio |
| Migrar pdf-to-excel | Paquete instalable, tests, pyproject.toml propio |
| Migrar file-converter | Paquete instalable, tests, pyproject.toml propio |
| `tools/shared/tests` | Tests de utilidades compartidas |
| READMEs actualizados | Cada paquete con su README, instalable independiente |

**Criterio de done:** `pip install -e tools/data-processor` funciona, `make test-processor` pasa.

---

## 0.4.0 — "Documentation & Tutorials"

**Objetivo:** Documentación completa para aprender y usar.

| Entregable | Detalle |
|---|---|
| MkDocs + GitHub Pages | Deploy automático en push a main |
| Tutorial 01 | `01-desde-cero.md` — entorno, Git, primer commit |
| Tutorial 02 | `02-procesador-datos.md` — construir data-processor desde cero |
| Tutorial 03 | `03-pdf-a-excel.md` — construir pdf-to-excel |
| Tutorial 04 | `04-convertidor-archivos.md` — construir file-converter |
| Tutorial 05 | `04-de-codigo-a-servicio.md` — de código a servicio vendible |
| Referencia tools | `docs/tools/*.md` para cada herramienta |
| Arquitectura | `docs/architecture/overview.md` + ADRs en `decisions/` |
| Business docs | `docs/business/` (precios, búsqueda-clientes, entrega) |

---

## 0.5.0 — "CI/CD & Release Automation"

**Objetivo:** Pipeline completo automatizado.

| Pipeline | Qué hace |
|---|---|
| `ci.yml` | lint (ruff) + type-check (mypy strict) + tests (pytest + coverage) en matrix 3.10/3.11/3.12 |
| `docs.yml` | MkDocs build + deploy a GitHub Pages |
| `release.yml` | Tag `v*` → cz bump → changelog → tag → GitHub Release → (opcional) PyPI |

**Criterio de done:** Push tag `v0.5.0` → release automático en GitHub + docs actualizadas en Pages.

---

## 0.6.0 — "Tooling v2.0" (Mejoras funcionales)

| Herramienta | Mejoras |
|---|---|
| **data-processor** | `--carpeta` (procesa carpeta completa), dedup difuso (similitud >85%), auto-detección fechas/emails, barra de progreso, export Parquet/SQLite, config YAML |
| **pdf-to-excel** | OCR opcional (Tesseract), unir tablas consecutivas, áreas de extracción fijas (config YAML), procesar carpeta |
| **file-converter** | Multi-hoja Excel (`--hoja`), auto-separador CSV, validación JSON schema, Parquet, streaming >100MB |
| **shared** | CLI base (Click/Rich), logging estructurado (loguru), config pydantic-settings, exceptions jerárquicas |

---

## 1.0.0 — "First Stable Release"

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

1. Abra un **issue** con label `hoja-de-ruta`
2. Describa: qué, por qué, esfuerzo estimado, impacto
3. Discusión en el issue → decisión → se añade al milestone correspondiente