# Tutorial 03: Construir pdf-to-excel desde cero

Herramienta CLI que extrae tablas de un PDF y las guarda en Excel (.xlsx) o CSV.

---

## Objetivo

Crear una herramienta que:
1. Abre un PDF con `pdfplumber`
2. Extrae **todas las tablas** de **todas las páginas**
13. Limpia filas vacías
14. Guarda cada tabla como hoja separada en Excel (.xlsx) o como CSV
15. CLI simple + vista previa opcional

---

## 1. Estructura del paquete

```
tools/pdf-to-excel/
├── pyproject.toml
├── src/pdf_to_excel/
│   ├── __init__.py
│   ├── cli.py
│   ├── extractor.py
│   └── io.py
├── tests/
│   ├── test_extractor.py
│   └── test_cli.py
├── examples/
│   └── factura.pdf
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
name = "pdf-to-excel"
version = "1.0.0"
description = "Extrae tablas de PDF y guarda en Excel/CSV — CLI didáctico"
readme = "README.md"
license = {text = "MIT"}
authors = [{name = "Diego Alejandro Sáenz Falcón", email = "diegoalejandrosaenzfalcon@gmail.com"}]
requires-python = ">=3.10"
dependencies = [
    "pdfplumber>=0.11.0",
    "openpyxl>=3.1.0",
    "reportlab>=4.0.0",
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
pdf-to-excel = "pdf_to_excel.cli:main"

[tool.hatch.build.targets.wheel]
packages = ["src/pdf_to_excel"]
```

---

## 2. `src/pdf_to_excel/__init__.py`

```python
"""pdf-to-excel v1.0 — Extrae tablas de PDF a Excel/CSV.

Extrae tablas de un PDF y las guarda en Excel (.xlsx) o CSV.
Cada tabla detectada se guarda como hoja separada (Excel) o archivo CSV.

Uso:
    python -m pdf_to_excel factura.pdf --salida xlsx
    python -m pdf_to_excel factura.pdf --paginas 1,3 --salida csv
"""

from .cli import main

__version__ = "1.0.0"
__all__ = ["main"]
```

---

## 2. `src/pdf_to_excel/extractor.py` — Lógica de extracción

```python
"""Extracción de tablas de PDF con pdfplumber."""

import pdfplumber
from typing import List, Optional


def extraer_tablas(pdf_path: str, paginas: Optional[List[int]] = None) -> List[List[List[str]]]:
    """Extrae todas las tablas de un PDF.

    Args:
        pdf_path: Ruta al archivo PDF.
        paginas: Lista de números de página (1-indexed). None = todas.

    Returns:
        Lista de tablas; cada tabla es lista de filas (lista de celdas).
    """
    tablas = []

    with pdfplumber.open(pdf_path) as pdf:
        paginas_a_procesar = pdf.pages

        if paginas:
            # pdfplumber usa 0-index, usuario pasa 1-index
            paginas_a_procesar = [pdf.pages[i - 1] for i in paginas if 1 <= i <= len(pdf.pages)]

        for pagina in paginas_a_procesar:
            tablas_pagina = pagina.extract_tables()
            if tablas_pagina:
                for tabla in tablas_pagina:
                    if tabla:
                        # Limpia None -> ""
                        tabla_limpia = [[c if c is not None else "" for c in fila] for fila in tabla]
                        tablas.append(tabla_limpia)

    return tablas


def filtrar_vacios(tabla: list) -> list:
    """Quita filas completamente vacías."""
    return [fila for fila in tabla if any(c and str(c).strip() for c in fila)]
```

---

## 4. `src/pdf_to_excel/io.py` — Guardado

```python
"""Guardado de tablas en Excel o CSV."""

import csv
import os
import openpyxl
from typing import List


def guardar_excel(tablas: List[list], ruta_salida: str):
    """Guarda cada tabla como hoja separada en un .xlsx."""
    wb = openpyxl.Workbook()
    # Elimina la hoja por defecto
    wb.remove(wb.active)

    for i, tabla in enumerate(tablas, 1):
        ws = wb.create_sheet(title=f"Tabla_{i}")
        for fila in tabla:
            ws.append(fila)
    wb.save(ruta_salida)


def guardar_csv(tablas: List[list], base_path: str):
    """Guarda cada tabla como CSV separado."""
    base, _ = os.path.splitext(base_path)
    for i, tabla in enumerate(tablas, 1):
        salida = f"{base}_tabla_{i}.csv"
        with open(salida, "w", newline="", encoding="utf-8-sig") as f:
            writer = csv.writer(f, delimiter=";")
            writer.writerows(tabla)
        print(f"  Tabla {i} -> {salida}")
```

---

## 5. `src/pdf_to_excel/cli.py`

```python
"""CLI: extrae tablas de PDF → Excel/CSV."""

import argparse
import os
import sys
from .extractor import extraer_tablas, filtrar_vacios
from .io import guardar_excel, guardar_csv


def main():
    parser = argparse.ArgumentParser(description="Extrae tablas de PDF a Excel/CSV")
    parser.add_argument("archivo", help="Archivo .pdf")
    parser.add_argument("--salida", choices=["xlsx", "csv"], default="xlsx", help="Formato salida")
    parser.add_argument("--paginas", help="Páginas a extraer (ej: 1,3,5)")
    args = parser.parse_args()

    if not os.path.isfile(args.archivo):
        print(f"Error: no se encontro '{args.archivo}'")
        sys.exit(1)

    paginas = None
    if args.paginas:
        paginas = [int(p) for p in args.paginas.split(",") if p.strip().isdigit()]

    print(f"Leyendo PDF: {args.archivo}")
    tablas = extraer_tablas(args.archivo, paginas=paginas)

    if not tablas:
        print("No se encontraron tablas en el PDF.")
        sys.exit(0)

    print(f"Se encontraron {len(tablas)} tabla(s).")

    base = os.path.splitext(args.archivo)[0]

    if args.salida == "xlsx":
        salida = f"{os.path.splitext(args.archivo)[0]}.xlsx"
        # Filtra vacíos antes de guardar
        tablas_limpias = [filtrar_vacios(t) for t in tablas]
        import openpyxl
        wb = openpyxl.Workbook()
        wb.remove(wb.active)
        for i, tabla in enumerate(tablas, 1):
            tabla_limpia = [f for f in tabla if any(c and str(c).strip() for c in f)]
            ws = wb.create_sheet(title=f"Tabla_{i}")
            for fila in tabla_limpia:
                ws.append(fila)
        wb.save(args.archivo.replace(".pdf", ".xlsx"))
        print(f"Guardado: {args.archivo.replace('.pdf', '.xlsx')}")
    else:
        from .io import guardar_csv
        base = os.path.splitext(args.archivo)[0]
        for i, tabla in enumerate(tablas, 1):
            tabla_limpia = [f for f in tabla if any(c and str(c).strip() for c in f)]
            salida = f"{base}_tabla_{i}.csv"
            with open(salida, "w", newline="", encoding="utf-8-sig") as f:
                import csv
                csv.writer(f, delimiter=";").writerows(tabla_limpia)
            print(f"  Tabla {i} -> {salida}")


if __name__ == "__main__":
    main()
```

---

## 6. Tests (`tests/test_extractor.py`)

```python
"""Tests para extractor.py"""

import pytest
from pdf_to_excel.extractor import extraer_tablas, filtrar_vacios


def test_filtrar_vacios():
    tabla = [["a", "b"], ["", ""], ["x", "y"]]
    assert filtrar_vacios(tabla) == [["a", "b"], ["x", "y"]]


def test_filtrar_vacios_todo_vacio():
    tabla = [["", ""], ["", ""]]
    assert filtrar_vacios(tabla) == []


# Test de integración requiere PDF real - se omite en unit tests
# Se prueba en test de integración con PDF real
```

---

## 9. README.md del paquete

```markdown
# pdf-to-excel v1.0

Extrae tablas de PDF → Excel (.xlsx) o CSV.

## Instalación
```bash
pip install -e tools/pdf-to-excel
# o: make install-pdf
```

## Uso
```bash
# Extrae todas las tablas a Excel (una hoja por tabla)
python -m pdf_to_excel factura.pdf --salida xlsx

# Solo páginas 1 y 3
python -m pdf_to_excel factura.pdf --paginas 1,3 --salida xlsx

# Salida CSV (un archivo por tabla)
python -m pdf_to_excel factura.pdf --salida csv
```

## Qué hace
- Usa `pdfplumber` para detectar tablas (bordes, líneas, estructura)
- Cada tabla → hoja separada en Excel, o archivo CSV separado
- Filtra filas vacías automáticamente
- Opción `--paginas` para procesar solo páginas específicas

## Limitaciones
- Funciona mejor con tablas que tienen bordes/líneas visibles
- PDFs escaneados (imagen) requieren OCR previo (no incluido)
- Tablas muy complejas (celdas combinadas, múltiples líneas) pueden requerir ajuste manual

## Tests
```bash
make test-pdf
```