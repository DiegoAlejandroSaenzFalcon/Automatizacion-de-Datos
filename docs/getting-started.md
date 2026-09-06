# Primeros pasos

Esta guía te lleva de cero a tener el entorno funcionando y entendiendo la estructura del proyecto.

---

## 1. Requisitos previos

- **Python 3.10+** (recomendado 3.12)
- **Git** configurado
- **GitHub CLI** (`gh`) opcional pero recomendado
- **Editor** (VS Code recomendado con extensiones: Python, Ruff, MyPy, Pylance)

---

## 2. Clonar y configurar

```bash
# 1. Clona el repo
git clone https://github.com/DiegoAlejandroSaenzFalcon/data-tools-workshop.git
cd data-tools-workshop

# 2. Instala entorno de desarrollo completo
make install-dev

# Verifica que todo funciona
make check
```

### Qué hace `make install-dev`

1. Crea entorno virtual (`.venv/`)
2. Instala el monorepo en modo editable con todas las dependencias opcionales
3. Instala `pre-commit` hooks (ruff, black, mypy, commitizen)
4. Instala `commitizen` para commits convencionales

---

## 3. Verifica que todo funciona

```bash
# Ejecuta todo el pipeline de calidad
make check

# Debería mostrar: ✅ All CI checks passed
```

Si algo falla, lee el error y corrige antes de continuar.

---

## 4. Entiende la estructura

```
data-tools-workshop/
├── tools/
│   ├── data-processor/       # Paquete: limpieza CSV/Excel
│   ├── pdf-to-excel/         # Paquete: PDF → Excel/CSV
│   ├── file-converter/       # Paquete: CSV ↔ Excel ↔ JSON
│   └── shared/               # Código común (CLI, exceptions, utils)
├── examples/                 # Datos de prueba
├── docs/                     # Documentación fuente
├── docs-site/                # MkDocs config
├── .github/workflows/        # CI/CD
├── pyproject.toml            # Config raíz + workspaces
└── Makefile                  # Comandos unificados
```

---

## 4. Prueba cada herramienta

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

## 5. Ejecuta los tests

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

## 6. Primer commit

```bash
git add .
git commit
# commitizen te guiará:
# feat(scope): descripción breve
# Ej: feat(docs): añade guía de inicio rápido
```

---

## Siguientes pasos

1. Lee `CONTRIBUTING.md` para la guía completa de contribución
2. Explora `docs/tutorials/01-desde-cero.md` para el tutorial desde cero
3. Revisa `docs/tools/` para la referencia de cada herramienta
4. Abre un issue si encuentras algo que mejorar

---

¿Problemas? Abre un [issue](https://github.com/DiegoAlejandroSaenzFalcon/data-tools-workshop/issues) o escribe a `diegoalejandrosaenzfalcon@gmail.com`.