# Arquitectura — Visión general

---

## Principios de diseño

1. **Monorepo modular** — Herramientas independientes, código compartido en `shared/`
2. **Paquetes instalables** — Cada herramienta es un paquete Python instalable (`pip install -e tools/x`)
3. **Código didáctico** — Docstrings explicativos, type hints, tests, README pedagógico
4. **Calidad automatizada** — Ruff, Black, MyPy strict, pytest, pre-commit, CI/CD
5. **Documentación viva** — MkDocs + MkDocstrings → GitHub Pages auto-deploy

---

## Estructura de alto nivel

```
data-tools-workshop/
├── tools/                    # Herramientas (paquetes independientes)
│   ├── data-processor/       # Limpieza CSV/Excel
│   ├── pdf-to-excel/         # PDF → Excel/CSV
│   ├── file-converter/       # CSV ↔ Excel ↔ JSON
│   └── shared/               # Código común (CLI, exceptions, logging, config, utils)
├── examples/                 # Datos de prueba
├── docs/                     # Documentación fuente (Markdown)
├── docs-site/                # MkDocs config + overrides
├── scripts/                  # Utilidades de desarrollo
├── .github/workflows/        # CI/CD
├── pyproject.toml            # Config raíz + workspaces (hatch)
├── Makefile                  # Comandos unificados
├── .pre-commit-config.yaml   # Hooks de calidad
└── CHANGELOG.md              # Historial de versiones
```

---

## Flujo de datos genérico

```
Entrada (CSV/Excel/PDF/JSON)
        ↓
Lectura (auto-encoding, multi-hoja)
        ↓
Limpieza (vacíos, duplicados, normalización)
        ↓
Conversión (números reales, tipos)
        ↓
Exportación (XLSX/CSV/JSON)
        ↓
Salida (archivo + resumen)
```

---

## Decisiones de arquitectura (ADR)

Ver `docs/architecture/decisions/` para decisiones documentadas.

| ADR | Título | Estado |
|---|---|---|
| 0001 | Monorepo vs Multi-repo | Aceptado |
| 0002 | Hatch vs Poetry vs PDM | Aceptado (Hatch) |
| 0003 | Ruff + Black vs Flake8 + Black | Aceptado (Ruff) |
| 0004 | MyPy strict mode | Aceptado |
| 0005 | MkDocs + Material vs Sphinx | Aceptado (MkDocs) |
| 0006 | Click vs Typer vs argparse | Aceptado (argparse + Click en shared) |
| 0007 | Pydantic vs dataclasses | Aceptado (Pydantic v2 para config) |
| 0008 | Logging: stdlib vs loguru | Aceptado (loguru en shared) |

---

## Patrones de código

### 1. Funciones puras + pipeline

```python
def pipeline(datos):
    return (leer(datos)
            |> limpiar_espacios
            |> quitar_vacias
            |> deduplicar
            |> convertir_tipos
            |> guardar)
```

### 2. Type hints obligatorios

```python
def normalizar_texto(texto: str) -> str:
    ...

def leer_csv(ruta: str) -> list[list[str]]:
    ...
```

### 3. Docstrings Google style

```python
def normalizar_texto(texto: str) -> str:
    """Normaliza texto para comparación insensible a mayúsculas/acentos.

    Pasos (orden importante):
      1. NFD + quitar combinantes → quita acentos
      2. lower() → minúsculas
      3. re.sub(r"\s+", " ", ...) → colapsa espacios

    Args:
        texto: Cadena a normalizar.

    Returns:
        Texto normalizado (minúsculas, sin acentos, espacios simples).

    Example:
        >>> normalizar_texto("  María Gómez  ")
        'maria gomez'
    """
```

### 4. Errores tipados

```python
class DataToolsError(Exception):
    """Excepción base del proyecto."""
    pass

class EncodingError(DataToolsError):
    """Error de detección/lectura de encoding."""
    pass

class ValidationError(DataToolsError):
    """Error de validación de datos."""
    pass
```

---

## Convenciones de código

| Aspecto | Estándar |
|---|---|
| **Line length** | 100 chars (ruff/black) |
| **Quotes** | Dobles (black) |
| **Imports** | Absolutos, agrupados (stdlib, third-party, local) |
| **Type hints** | Obligatorios en funciones públicas (mypy strict) |
| **Docstrings** | Google style, en español, con ejemplo |
| **Tests** | pytest, parametrize, fixtures en `conftest.py` |
| **Commits** | Conventional Commits (`feat:`, `fix:`, `docs:`, `chore:`) |
| **Versionado** | SemVer + Commitizen (`cz bump`) |

---

## Testing strategy

| Nivel | Herramienta | Cobertura objetivo |
|---|---|---|
| Unit | pytest + parametrize | 80%+ código nuevo |
| Integración | pytest + fixtures reales | Rutas críticas |
| E2E | Scripts manuales + CI | Flujos críticos |

### Estructura de tests

```
tools/*/tests/
├── conftest.py          # Fixtures compartidas
├── test_core.py         # Lógica de negocio
├── test_io.py           # Lectura/escritura
└── test_cli.py          # CLI (subprocess o CliRunner)
```

---

## CI/CD Pipeline

```
Push/PR → main
    │
    ├─► lint (ruff)
    │
    ├─► type-check (mypy strict)
    │
    ├─► test (pytest matrix 3.10/3.11/3.12)
    │
    └─► check-results (aggregator)
```

### Deploy Docs
```
Push main → docs/** → mkdocs build → GitHub Pages
```

### Release
```
Tag v* → cz bump → changelog → tag → GitHub Release → (opcional) PyPI
```

---

## Seguridad

- **Cero secretos en código** — `.pre-commit-config.yaml` con detect-secrets
- **Dependencias auditadas** — `pip-audit` en CI
- **Sin eval/exec** — Prohibido en código
- **Validación de entrada** — Pydantic en shared/config

---

## Extensibilidad

### Añadir nueva herramienta

1. `tools/nueva-herramienta/` con estructura estándar
2. `pyproject.toml` propio + entry point
3. Tests en `tests/`
3. README didáctico
4. Añadir a `pyproject.toml` root `[project.optional-dependencies]`
4. Tests en CI matrix
5. Documentación en `docs/tools/`

### Añadir formato de salida

1. Función `guardar_formato()` en `shared/io.py`
2. Registrar en `converter.py` / `io.py` de cada herramienta
3. Test + docstring
3. Actualizar CLI `--salida` choices
4. README + CHANGELOG

---

## Referencias

- [Hatch docs](https://hatch.pypa.io/)
- [Ruff docs](https://docs.astral.sh/ruff/)
- [MyPy docs](https://mypy.readthedocs.io/)
- [MkDocs Material](https://squidfunk.github.io/mkdocs-material/)
- [Commitizen](https://commitizen-tools.github.io/commitizen/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Keep a Changelog](https://keepachangelog.com/)
- [Semantic Versioning](https://semver.org/)