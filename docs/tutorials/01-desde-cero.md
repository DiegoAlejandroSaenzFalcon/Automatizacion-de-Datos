# Tutorial 01: Desde cero

Este tutorial te guía desde **nada** hasta tener tu entorno funcionando, entender la arquitectura y hacer tu primer commit.

---

## Objetivo

Al final tendrás:
- Entorno de desarrollo funcionando (`make check` pasa)
- Entendimiento de la arquitectura del monorepo
- Tu primer commit con mensaje convencional
- Conocimiento de cómo ejecutar tests, lint y docs

---

## 1. Requisitos previos

| Herramienta | Versión mínima | Cómo verificar |
|---|---|---|
| Python | 3.10 | `python --version` |
| Git | 2.30+ | `git --version` |
| GitHub CLI (`gh`) | 2.0+ | `gh --version` (opcional) |
| Make | 4.0+ | `make --version` |

> **Windows:** Usa [Scoop](https://scoop.sh/) o [Chocolatey](https://chocolatey.org/) para instalar `make`, `git`, `gh`.

```bash
scoop install python git gh make
# o
choco install python git gh make
```

---

## 2. Clona el repositorio

```bash
git clone https://github.com/DiegoAlejandroSaenzFalcon/data-tools-workshop.git
cd data-tools-workshop
```

---

## 3. Instala el entorno de desarrollo

```bash
make install-dev
```

### Qué hace este comando

| Paso | Qué hace |
|---|---|
| `python -m venv .venv` | Crea entorno virtual aislado |
| `pip install -e .[dev,...]` | Instala el monorepo en modo editable con todas las dependencias de desarrollo |
| `pre-commit install` | Instala hooks de git (se ejecutan antes de cada commit) |
| `pre-commit install --hook-type commit-msg` | Valida mensajes de commit convencionales |

> **Nota:** Si ves errores de permisos en Windows, ejecuta PowerShell como administrador o usa `python -m pip install --user ...`.

---

## 4. Verifica la instalación

```bash
make check
```

Deberías ver:

```
ruff check --fix .
ruff format --check .
mypy .
pytest --cov=tools --cov-report=term-missing --cov-report=xml
...
✅ All CI checks passed
```

Si algo falla:
1. Lee el error completo
2. Corrección sugerida: `make lint` (auto-fix), `make format`, `make type-check`
3. Si persiste, abre un issue

---

## 5. Explora la estructura

```bash
tree -L 3 -I "__pycache__|.venv|.git|htmlcov|.mypy_cache|.ruff_cache|build|dist"
```

Deberías ver:

```
.
├── tools/
│   ├── data-processor/
│   ├── pdf-to-excel/
│   ├── file-converter/
│   └── shared/
├── examples/
├── docs/
├── docs-site/
├── .github/workflows/
├── pyproject.toml
├── Makefile
└── README.md
```

---

## 6. Prueba cada herramienta

```bash
# data-processor: limpia CSV/Excel
python -m data_processor examples/ejemplo_datos.csv --preview
python -m data_processor examples/ejemplo_datos.xlsx --salida json

# pdf-to-excel: extrae tablas de PDF
python -m pdf_to_excel examples/factura.pdf --salida xlsx

# file-converter: convierte entre formatos
python -m file_converter examples/datos.csv --a xlsx
python -m file_converter examples/datos.xlsx --a json
```

---

## 6. Ejecuta tests

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

## 6. Documentación local

```bash
make docs-serve
# Abre http://localhost:8000
```

---

## 7. Tu primer commit

```bash
# 1. Crea una rama para tu cambio
git checkout main
git pull
git checkout -b feat/mi-primer-cambio

# 2. Haz un cambio pequeño (ej: corrige typo en README)
# Edita README.md

# 3. Stage y commit (commitizen te guiará)
git add .
git commit
# Selecciona: docs(readme): corrige typo en instalación
# Escribe: Corrige typo en instrucciones de instalación

# 4. Push y PR
git push origin feat/mi-primer-cambio
# Abre PR en GitHub
```

### Mensajes de commit convencionales

```
tipo(scope): descripción breve

feat(scope): nueva funcionalidad
fix(scope): corrección de bug
docs(scope): documentación
chore(scope): mantenimiento
refactor(scope): refactor sin cambio de comportamiento
test(scope): tests
perf(scope): performance
```

---

## 8. Documentación local (MkDocs)

```bash
make docs-serve
# Abre http://localhost:8000
```

Navega por:
- **Tutoriales** → `01-desde-cero` (este tutorial)
- **Herramientas** → referencia de cada herramienta
- **Tutoriales** → paso a paso de cada herramienta

---

## 9. Siguientes pasos

1. Lee `docs/tutorials/02-procesador-datos.md` — construye data-processor desde cero
2. Lee `docs/tutorials/03-pdf-a-excel.md` — construye pdf-to-excel
3. Lee `docs/tutorials/04-convertidor-archivos.md` — construye file-converter
4. Lee `docs/tutorials/04-de-codigo-a-servicio.md` — de código a servicio vendible
5. Explora `docs/tools/` para referencia técnica de cada herramienta
6. Lee `docs/business/` para pricing, finding-clients, delivery

---

## 9. Problemas comunes

| Problema | Solución |
|---|---|
| `make: command not found` | Instala `make` (scoop/choco/apt/brew) |
| `python: command not found` | Instala Python 3.10+ y añade al PATH |
| `pre-commit: command not found` | `pip install pre-commit && pre-commit install` |
| `mypy: error: ...` | Ejecuta `make type-check` para ver detalles |
| `ruff: error: ...` | Ejecuta `make lint` (auto-fix) |
| `pytest: no tests found` | Verifica que estés en la raíz del repo |

---

## 9. Siguientes pasos recomendados

1. **Lee** `docs/tutorials/02-procesador-datos.md` — construye data-processor desde cero
2. **Lee** `docs/tutorials/03-pdf-a-excel.md` — construye pdf-to-excel
3. **Lee** `docs/tutorials/04-convertidor-archivos.md` — construye file-converter
4. **Lee** `docs/tutorials/04-de-codigo-a-servicio.md` — de código a servicio vendible
4. Explora `docs/tools/` para referencia técnica
5. Lee `docs/business/` para pricing, finding-clients, delivery

---

¿Dudas? Abre un [issue](https://github.com/DiegoAlejandroSaenzFalcon/data-tools-workshop/issues) o escribe a `diegoalejandrosaenzfalcon@gmail.com`.