# Tutorial 01: Primeros pasos

Este tutorial le guía desde **nada** hasta tener su entorno funcionando, entender la arquitectura y realizar su primer confirmación.

---

## Objetivo

Al final tendrá:
- Entorno de desarrollo funcionando (`make check` pasa)
- Entendimiento de la arquitectura del monorepositorio
- Su primer confirmación con mensaje convencional
- Conocimiento de cómo ejecutar tests, lint y docs

---

## 1. Requisitos previos

| Herramienta | Versión mínima | Cómo verificar |
|---|---|---|
| Python | 3.10 | `python --version` |
| Git | 2.30+ | `git --version` |
| GitHub CLI (`gh`) | 2.0+ | `gh --version` (opcional) |
| Make | 4.0+ | `make --version` |

> **Windows:** Use [Scoop](https://scoop.sh/) o [Chocolatey](https://chocolatey.org/) para instalar `make`, `git`, `gh`.

```bash
scoop install python git gh make
# o
choco install python git gh make
```

---

## 2. Clone el repositorio

```bash
git clone https://github.com/DiegoAlejandroSaenzFalcon/Automatizacion-de-Datos.git
cd Automatizacion-de-Datos
```

---

## 3. Instale el entorno de desarrollo

```bash
make install-dev
```

### Qué hace este comando

| Paso | Qué hace |
|---|---|
| `python -m venv .venv` | Crea entorno virtual aislado |
| `pip install -e .[dev,...]` | Instala el monorepositorio en modo editable con todas las dependencias de desarrollo |
| `pre-commit install` | Instala hooks de git (se ejecutan antes de cada confirmación) |
| `pre-commit install --hook-type commit-msg` | Valida mensajes de confirmación convencionales |

> **Nota:** Si ve errores de permisos en Windows, ejecute PowerShell como administrador o use `python -m pip install --user ...`.

---

## 4. Verifique la instalación

```bash
make check
```

Debería ver:

```
ruff check --fix .
ruff format --check .
mypy .
pytest --cov=tools --cov-report=term-missing --cov-report=xml
...
✅ All CI checks passed
```

Si algo falla:
1. Lea el error completo
2. Corrección sugerida: `make lint` (auto-fix), `make format`, `make type-check`
3. Si persiste, abra un issue

---

## 5. Explore la estructura

```bash
tree -L 3 -I "__pycache__|.venv|.git|htmlcov|.mypy_cache|.ruff_cache|build|dist"
```

Debería ver:

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

## 6. Pruebe cada herramienta

```bash
# data-processor: limpia CSV/Excel
python -m data_processor examples/ejemplo_datos.csv --vista-previa
python -m data_processor examples/ejemplo_datos.xlsx --salida json

# pdf-to-excel: extrae tablas de PDF
python -m pdf_to_excel examples/factura.pdf --salida xlsx

# file-converter: convierte entre formatos
python -m file_converter examples/datos.csv --a xlsx
python -m file_converter examples/datos.xlsx --a json
```

---

## 7. Ejecute tests

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

## 7. Documentación local

```bash
make docs-serve
# Abre http://localhost:8000
```

---

## 8. Su primer confirmación

```bash
# 1. Cree una rama para su cambio
git checkout main
git pull
git checkout -b feat/mi-primer-cambio

# 2. Haga un cambio pequeño (ej: corrige typo en README)
# Edite README.md

# 3. Stage y confirmación (commitizen le guiará)
git add .
git commit
# Seleccione: docs(readme): corrige typo en instalación
# Escriba: Corrige typo en instrucciones de instalación

# 4. Push y PR
git push origin feat/mi-primer-cambio
# Abra PR en GitHub
```

### Mensajes de confirmación convencionales

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

Navegue por:
- **Tutoriales** → `01-desde-cero` (este tutorial)
- **Herramientas** → referencia de cada herramienta
- **Tutoriales** → paso a paso de cada herramienta

---

## 9. Siguientes pasos

1. **Lea** `docs/tutorials/02-procesador-datos.md` — construye data-processor desde cero
2. **Lea** `docs/tutorials/03-pdf-a-excel.md` — construye pdf-to-excel
3. **Lea** `docs/tutorials/04-convertidor-archivos.md` — construye file-converter
4. **Lea** `docs/tutorials/04-de-codigo-a-servicio.md` — de código a servicio vendible
5. Explore `docs/tools/` para referencia técnica de cada herramienta
6. Lea `docs/business/` para precios, búsqueda-clientes, entrega

---

## 9. Problemas comunes

| Problema | Solución |
|---|---|
| `make: command not found` | Instale `make` (scoop/choco/apt/brew) |
| `python: command not found` | Instale Python 3.10+ y añada al PATH |
| `pre-commit: command not found` | `pip install pre-commit && pre-commit install` |
| `mypy: error: ...` | Ejecute `make type-check` para ver detalles |
| `ruff: error: ...` | Ejecute `make lint` (auto-fix) |
| `pytest: no tests found` | Verifique que esté en la raíz del repositorio |

---

## 10. Siguientes pasos recomendados

1. **Lea** `docs/tutorials/02-procesador-datos.md` — construye data-processor desde cero
2. **Lea** `docs/tutorials/03-pdf-a-excel.md` — construye pdf-to-excel
3. **Lea** `docs/tutorials/04-convertidor-archivos.md` — construye file-converter
4. **Lea** `docs/tutorials/04-de-codigo-a-servicio.md` — de código a servicio vendible
5. Explore `docs/tools/` para referencia técnica de cada herramienta
6. Lea `docs/business/` para precios, búsqueda-clientes, entrega

---

¿Dudas? Abra un [issue](https://github.com/DiegoAlejandroSaenzFalcon/Automatizacion-de-Datos/issues) o escriba a `diegoalejandrosaenzfalcon@gmail.com`.