# Tutorial 04: Construir file-converter desde cero

Herramienta CLI que convierte entre CSV, Excel (.xlsx) y JSON.

---

## Objetivo

Crear una herramienta CLI que:
1. Lee CSV, Excel (.xlsx), JSON
2. Convierte entre los tres formatos
3. CSV con separador `;` (estándar español)
4. JSON como lista de objetos `{columna: valor}`
4. CLI simple: `python -m file_converter archivo.csv --a xlsx`

---

## 1. Estructura del paquete

```
tools/file-converter/
├── pyproject.toml
├── src/file_converter/
│   ├── __init__.py
│   ├── cli.py
│   ├── converter.py
│   └── io.py
├── tests/
│   ├── test_converter.py
│   └── test_cli.py
├── examples/
│   └── ejemplo.csv
├── README.md
└── pyproject.toml
```

---

## 2. pyproject.toml

```toml
[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[project]
name = "file-converter"
version = "1.0.0"
description = "Convierte entre CSV, Excel y JSON — CLI didáctico"
readme = "README.md"
license = {text = "MIT"}
authors = [{name = "Diego Alejandro Sáenz Falcón", email = "diegoalejandrosaenzfalcon@gmail.com"}]
requires-python = ">=3.10"
dependencies = [
    "openpyxl>=3.1.0",
]
classifiers = [
    "Development Status :: 4 - Beta",
    "Intended Audience :: Developers",
    "License :: OSI Approved :: MIT License",
    "Programming Language :: Python :: 3",
    "Topic :: Office/Business :: Financial :: Spreadsheet",
]

[project.optional-dependencies]
dev = ["pytest>=8.0", "pytest-cov>=4.0", "ruff>=0.5", "black>=24.0", "mypy>=1.10"]

[project.scripts]
file-converter = "file_converter.cli:main"

[tool.hatch.build.targets.wheel]
packages = ["src/file_converter"]
```

---

## 2. `src/file_converter/__init__.py`

```python
"""file-converter v1.0 — Convierte entre CSV, Excel y JSON.

Convierte entre los tres formatos de datos más usados en oficina:
CSV, Excel (.xlsx) y JSON.

Uso:
    python -m file_converter archivo.csv --a xlsx
    python -m file_converter archivo.xlsx --a json
    python -m file_converter datos.json --a csv
"""

from .cli import main

__version__ = "1.0.0"
__all__ = ["main"]
```

---

## 2. `src/file_converter/converter.py` — Lógica de conversión

```python
"""Lógica de conversión entre CSV, Excel y JSON."""

import csv
import json
import os
from typing import List, Dict, Any

import openpyxl


def leer_csv(ruta: str) -> List[List[str]]:
    with open(ruta, newline="", encoding="utf-8-sig") as f:
        return [fila for fila in csv.reader(f)]


def leer_xlsx(ruta: str) -> List[List[Any]]:
    import openpyxl
    wb = openpyxl.load_workbook(ruta, read_only=True, data_only=True)
    ws = wb.active
    filas = [[c if c is not None else "" for c in fila] for fila in ws.iter_rows(values_only=True)]
    wb.close()
    return filas


def leer_json(ruta: str) -> List[List[Any]]:
    with open(ruta, encoding="utf-8") as f:
        datos = json.load(f)
    if not datos:
        return []
    if isinstance(datos, list) and datos and isinstance(datos[0], dict):
        cabeceras = list(datos[0].keys())
        filas = [list(datos[0].keys())]
        for reg in datos:
            filas.append([reg.get(c, "") for c in datos[0].keys()])
        return filas
    return datos  # asume lista de listas


def leer(ruta: str) -> List[List[Any]]:
    ext = os.path.splitext(ruta)[1].lower()
    if ext == ".csv":
        return leer_csv(ruta)
    if ext in (".xlsx", ".xlsm"):
        return leer_xlsx(ruta)
    if ext == ".json":
        return leer_json(ruta)
    raise ValueError(f"Formato no soportado: {ext}")


def guardar_csv(ruta: str, filas: list):
    with open(ruta, "w", newline="", encoding="utf-8-sig") as f:
        csv.writer(f, delimiter=";").writerows(filas)


def guardar_xlsx(ruta: str, filas: list):
    import openpyxl
    wb = openpyxl.Workbook()
    ws = wb.active
    for fila in filas:
        ws.append(fila)
    wb.save(ruta)


def guardar_json(ruta: str, filas: list):
    if not filas:
        with open(ruta, "w", encoding="utf-8") as f:
            json.dump([], f)
        return
    cabeceras = filas[0]
    regs = []
    for fila in filas[1:]:
        regs.append({cabeceras[i]: fila[i] if i < len(fila) else "" for i in range(len(cabeceras))})
    with open(ruta, "w", encoding="utf-8") as f:
        json.dump(filas, f, ensure_ascii=False, indent=2)


def guardar(ruta: str, filas: list, formato: str):
    if formato == "csv":
        guardar_csv(ruta, filas)
    elif formato == "xlsx":
        guardar_xlsx(ruta, filas)
    elif formato == "json":
        guardar_json(ruta, filas)
    else:
        raise ValueError(f"Formato no soportado: {formato}")
```

---

## 5. `src/file_converter/cli.py`

```python
"""CLI: convierte entre CSV, Excel y JSON."""

import argparse
import os
import sys
from .converter import leer, guardar


def main():
    parser = argparse.ArgumentParser(description="Convierte entre CSV, Excel y JSON")
    parser.add_argument("archivo", help="Archivo de entrada (.csv, .xlsx, .json)")
    parser.add_argument("--a", dest="formato", required=True, choices=["csv", "xlsx", "json"], help="Formato de salida")
    args = parser.parse_args()

    if not os.path.isfile(args.archivo):
        print(f"Error: no se encontro '{args.archivo}'")
        sys.exit(1)

    filas = leer(args.archivo)
    base = os.path.splitext(args.archivo)[0]
    salida = f"{base}.{args.formato}"

    guardar(salida, filas, args.formato)
    print(f"Convertido: {args.archivo} -> {salida}")


if __name__ == "__main__":
    main()
```

---

## 6. Tests (`tests/test_converter.py`)

```python
"""Tests para converter.py"""

import pytest
from file_converter.converter import leer_csv, leer_xlsx, leer_json, leer, guardar_csv, guardar_xlsx, guardar_json


def test_leer_csv():
    import csv
    import tempfile
    with tempfile.NamedTemporaryFile(mode="w", suffix=".csv", delete=False, newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["a", "b"])
        w.writerow(["1", "2"])
        ruta = f.name
    filas = leer_csv(ruta)
    assert filas == [["a", "b"], ["1", "2"]]


def test_leer_json():
    import tempfile
    import json
    datos = [{"a": "1", "b": "2"}, {"a": "3", "b": "4"}]
    with tempfile.NamedTemporaryFile(mode="w", suffix=".json", delete=False, encoding="utf-8") as f:
        json.dump(datos, f)
        ruta = f.name
    filas = leer_json(ruta)
    assert filas[0] == ["a", "b"]
    assert filas[1] == ["1", "2"]
    assert filas[2] == ["3", "4"]
```

---

## 9. README.md del paquete

```markdown
# file-converter v1.0

Convierte entre CSV, Excel (.xlsx) y JSON.

## Instalación
```bash
pip install -e tools/file-converter
# o: make install-converter
```

## Uso
```bash
python -m file_converter archivo.csv --a xlsx
python -m file_converter archivo.xlsx --a csv
python -m file_converter datos.csv --a json
```

## Formatos soportados
| De | A | Soporta |
|---|---|---|
| CSV | xlsx, json | sí |
| XLSX | csv, json | sí |
| JSON | csv, xlsx | sí (lista de objetos) |

## Limitaciones
- CSV usa separador `;` (estándar español)
- Solo primera hoja de Excel
- JSON debe ser lista de objetos con misma estructura
- Herramienta base, no producto comercial completo
```

---

## 10. Instalar y probar

```bash
make install-converter
python -m file_converter examples/ejemplo.csv --a xlsx
python -m file_converter examples/ejemplo.xlsx --a json
```