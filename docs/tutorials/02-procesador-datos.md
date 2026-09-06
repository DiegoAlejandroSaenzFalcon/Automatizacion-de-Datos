# Tutorial 02: Construir data-processor desde cero

Este tutorial le guía paso a paso para construir **data-processor v2.0** desde cero, entendiendo cada decisión de diseño.

---

## Objetivo

Construir una herramienta CLI que:
1. Lee CSV/Excel con auto-detección de encoding
2. Limpia: filas vacías, duplicados (insensible a mayúsculas/acentos), espacios
3. Exporta a XLSX (números reales), CSV (punto y coma), JSON
4. Tiene menú interactivo y modo vista previa

---

## 1. Estructura del paquete

```
tools/data-processor/
├── pyproject.toml
├── src/data_processor/
│   ├── __init__.py
│   ├── cli.py
│   ├── core.py
24: │   ├── io.py
25: │   └── utils.py
25: ├── tests/
26: │   ├── test_core.py
27: │   ├── test_io.py
28: │   └── test_cli.py
29: ├── examples/
30: │   └── ejemplo.csv
31: ├── README.md
32: └── pyproject.toml
33: ```

---

## 2. pyproject.toml del paquete

```toml
[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[project]
name = "data-processor"
version = "2.0.0"
description = "Limpieza y conversión de datos CSV/Excel — CLI interactivo y didáctico"
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
data-processor = "data_processor.cli:main"

[tool.hatch.build.targets.wheel]
packages = ["src/data_processor"]
```

---

## 3. `src/data_processor/__init__.py`

```python
"""data-processor v2.0 — Limpieza y conversión de datos CSV/Excel.

Herramienta CLI didáctica para limpiar archivos CSV/Excel:
- Auto-detección de encoding (utf-8, latin-1, cp1252)
- Deduplicación insensible a mayúsculas/acentos
- Procesa múltiples hojas de Excel
- Vista previa antes de guardar
- Exporta a xlsx (números reales), csv (;), json

Uso:
    python -m data_processor archivo.csv --vista-previa
    python -m data_processor datos.xlsx --salida json
"""

from .cli import main

__version__ = "2.0.0"
__all__ = ["main"]
```

---

## 3. `src/data_processor/utils.py` — Utilidades base

```python
"""Utilidades base: normalización de texto, conversión de tipos."""

import re
import unicodedata
from typing import Any


def normalizar_texto(texto: str) -> str:
    """Normaliza texto para comparación insensible a mayúsculas/acentos.

    Pasos (orden importante):
      1. NFD + quitar combinantes → quita acentos (á → a)
      2. lower() → minúsculas
      3. re.sub(r"\s+", " ", ...) → colapsa espacios múltiples

    Args:
        texto: Cadena a normalizar.

    Returns:
        Texto normalizado (minúsculas, sin acentos, espacios simples).

    Example:
        >>> normalizar_texto("  María Gómez  ")
        'maria gomez'
    """
    if not isinstance(texto, str):
        return str(texto)

    # NFD descompone: "á" → "a" + tilde combinante
    sin_acentos = unicodedata.normalize("NFD", texto)
    sin_acentos = "".join(c for c in sin_acentos if not unicodedata.combining(c))
    minusculas = sin_acentos.lower()
    return re.sub(r"\s+", " ", minusculas.strip())


def convertir_a_numero(valor: Any) -> Any:
    """Intenta convertir una cadena a número (int o float).

    En Excel los números deben ser int/float, no strings,
    para poder sumar, filtrar, hacer pivot tables.

    Args:
        valor: Valor a convertir (cualquier tipo).

    Returns:
        int, float, o el valor original si no es convertible.
    """
    if not isinstance(valor, str):
        return valor

    texto = valor.strip()
    if not texto:
        return valor

    if texto.isdigit():
        return int(texto)

    # Acepta "45.000" o "45,000" como float
    try:
        return float(valor.replace(",", "."))
    except ValueError:
        return valor
```

---

## 4. `src/data_processor/io.py` — Lectura y escritura

```python
"""Lectura y escritura de archivos CSV, Excel, JSON."""

import csv
import json
import os
from typing import Any, Dict, List

import openpyxl


def detectar_encoding(ruta_archivo: str) -> str:
    """Detecta el encoding correcto de un archivo de texto.

    Prueba en orden: utf-8-sig, latin-1, cp1252.
    latin-1 nunca falla (lee cualquier byte), así que nunca falla la lectura.

    Args:
        ruta_archivo: Ruta al archivo.

    Returns:
        Encoding detectado (str).
    """
    candidatos = ["utf-8-sig", "latin-1", "cp1252"]
    for encoding in candidatos:
        try:
            with open(ruta_archivo, encoding=encoding) as f:
                f.read()
            return encoding
        except UnicodeDecodeError:
            continue
    return "latin-1"


def leer_csv(ruta_archivo: str) -> List[List[str]]:
    """Lee CSV con encoding detectado automáticamente."""
    encoding = detectar_encoding(ruta_archivo)
    with open(ruta_archivo, newline="", encoding=encoding) as f:
        return [fila for fila in csv.reader(f)]


def leer_excel(ruta_archivo: str, hoja: str | None = None):
    """Lee Excel: una hoja (lista de listas) o todas (dict {hoja: filas})."""
    libro = openpyxl.load_workbook(ruta_archivo, read_only=True, data_only=True)

    if hoja:
        if hoja not in openpyxl.load_workbook(ruta_archivo).sheetnames:
            raise ValueError(f"Hoja '{hoja}' no existe")
        hoja_obj = openpyxl.load_workbook(ruta_archivo, read_only=True, data_only=True)[hoja]
        filas = [[c if c is not None else "" for c in fila] for fila in hoja_obj.iter_rows(values_only=True)]
        libro.close()
        return filas

    resultado = {}
    for nombre in openpyxl.load_workbook(ruta_archivo).sheetnames:
        h = openpyxl.load_workbook(ruta_archivo, read_only=True, data_only=True)[nombre]
        filas = [[c if c is not None else "" for c in fila] for fila in h.iter_rows(values_only=True)]
        resultado[nombre] = filas
    return resultado


def leer_archivo(ruta_archivo: str, hoja: str | None = None):
    """Detecta tipo y llama al lector correspondiente."""
    ext = os.path.splitext(ruta_archivo)[1].lower()

    if ext == ".csv":
        return leer_csv(ruta_archivo)
    if ext in (".xlsx", ".xlsm"):
        return leer_excel(ruta_archivo, hoja=hoja)
    raise ValueError(f"Formato no soportado: {ext}")


def convertir_a_numero(valor):
    """Convierte strings numéricos a int/float para Excel real."""
    if not isinstance(valor, str):
        return valor
    texto = str(valor).strip()
    if not texto:
        return valor
    if texto.isdigit():
        return int(texto)
    try:
        return float(str(valor).replace(",", "."))
    except ValueError:
        return valor


def guardar_filas(ruta_salida: str, filas: list):
    """Guarda filas según extensión: .xlsx, .csv (;), .json."""
    import os
    ext = os.path.splitext(ruta_salida)[1].lower()

    # Convierte strings numéricos a números reales para Excel/JSON
    def convertir(valor):
        if not isinstance(valor, str):
            return valor
        texto = valor.strip()
        if texto.isdigit():
            return int(texto)
        try:
            return float(texto.replace(",", "."))
        except ValueError:
            return valor

    filas_convertidas = [[convertir(celda) for celda in fila] for fila in filas]

    if ext == ".xlsx":
        import openpyxl
        salida = f"{os.path.splitext(ruta_salida)[0]}_limpio.xlsx"
        libro = openpyxl.Workbook()
        hoja = libro.active
        for fila in filas_convertidas:
            hoja.append(fila)
        libro.save(salida)
        return salida

    if ext == ".csv":
        import csv
        salida = f"{os.path.splitext(ruta_salida)[0]}_limpio.csv"
        with open(salida, "w", newline="", encoding="utf-8-sig") as f:
            csv.writer(f, delimiter=";").writerows(filas)
        return salida

    if ext == ".json":
        import json
        salida = f"{os.path.splitext(ruta_salida)[0]}_limpio.json"
        if not filas:
            with open(salida, "w", encoding="utf-8") as f:
                json.dump([], f)
            return
        cabeceras = filas[0]
        registros = []
        for fila in filas[1:]:
            registros.append({cabeceras[i]: fila[i] if i < len(fila) else "" for i in range(len(cabeceras))})
        with open(salida, "w", encoding="utf-8") as f:
            json.dump(registros, f, ensure_ascii=False, indent=2)
        return salida

    raise ValueError(f"Formato no soportado: {ext}")
```

---

## 4. `src/data_processor/core.py` — Lógica de limpieza

```python
"""Lógica principal de limpieza: espacios, vacíos, duplicados."""

import re
from typing import List
from .utils import normalizar_texto


def limpiar_espacios(filas: list) -> list:
    """Normaliza espacios en cada celda: trim + colapsa internos."""
    def norm(v):
        if not isinstance(v, str):
            return v
        return re.sub(r"\s+", " ", v.strip())
    return [[norm(c) for c in fila] for fila in filas]


def quitar_filas_vacias(filas: list) -> list:
    """Elimina filas donde todas las celdas son vacías/espacios."""
    return [f for f in filas if any(str(c).strip() for c in f)]


def deduplicar(filas: list) -> list:
    """Elimina duplicados usando normalización (insensible a mayúsculas/acentos).

    La primera fila (cabecera) se respeta y no se deduplica.
    """
    if not filas:
        return filas

    cabecera = filas[0]
    cuerpo = filas[1:]

    vistos = set()
    resultado = [cabecera]

    for fila in cuerpo:
        # Clave normalizada para comparar insensible a mayúsculas/acentos
        clave = tuple(normalizar_texto(str(c)) for c in fila)
        if clave not in vistos:
            vistos.add(clave)
            resultado.append(fila)

    return resultado


def limpiar_filas(filas: list) -> list:
    """Pipeline completo: espacios → vacías → deduplicar."""
    filas = limpiar_espacios(filas)
    filas = quitar_filas_vacias(filas)
    filas = deduplicar(filas)
    return filas


def calcular_vista_previa(filas_originales: list, filas_limpias: list) -> list:
    """Genera líneas de vista previa comparando original vs limpio."""
    vacias = sum(1 for f in filas_originales if not any(str(c).strip() for c in f))
    total_orig = len(filas)
    total_limp = len(filas_limpias)

    datos_orig = max(0, total_orig - 1 - sum(1 for f in filas if not any(str(c).strip() for c in f)))
    datos_final = max(0, len(filas) - 1)
    duplicados = max(0, datos_orig - (len(filas_limpias) - 1))

    return [
        f"Filas totales en el original: {total_orig}",
        f"Filas vacías encontradas: {sum(1 for f in filas if not any(str(c).strip() for c in f))}",
        f"Duplicados eliminados: {max(0, (len(filas) - 1 - sum(1 for f in filas if not any(str(c).strip() for c in f))) - (len(filas_limpias) - 1))}",
        f"Filas finales (con cabecera): {len(filas_limpias)}",
        f"Filas de datos finales: {len(filas_limpias) - 1}",
    ]
```

---

## 5. `src/data_processor/cli.py` — CLI + Menú interactivo

```python
"""CLI principal: argparse + menú interactivo."""

import argparse
import os
import sys
import re
from .io import leer_archivo
from .core import limpiar_filas, calcular_vista_previa, mostrar_resumen
from .io import guardar_filas


def preguntar(mensaje: str, opciones: list) -> str:
    while True:
        r = input(f"{mensaje} ").strip().lower()
        if r in opciones:
            return r
        print(f"  Opciones: {', '.join(opciones)}")


def menu_interactivo():
    """Guía al usuario paso a paso sin necesidad de saber terminal."""
    print("=" * 60)
    print("PROCESADOR DE DATOS v2.0")
    print("=" * 60)
    print("Limpia CSV/Excel: vacíos, duplicados (insensible a mayúsculas/acentos), espacios")
    print("Exporta: xlsx (números reales), csv (;), json")
    print("")

    # 1. Pide la ruta
    while True:
        ruta = input("Ruta del archivo (arrastre aquí): ").strip().strip('"').strip("'")
        if os.path.isfile(ruta):
            break
        print(f"  No existe: {ruta}")

    # 2. Pregunta si es Excel y tiene varias hojas
    extension = os.path.splitext(ruta)[1].lower()
    hoja = None
    if extension in (".xlsx", ".xlsm"):
        import openpyxl
        libro = openpyxl.load_workbook(ruta, read_only=True)
        hojas = libro.sheetnames
        libro.close()
        if len(hojas) > 1:
            print("")
            print(f"El Excel tiene {len(hojas)} hojas: {', '.join(hojas)}")
            print("Deje vacío para procesar TODAS, o escriba el nombre de una hoja.")
            eleccion = input("Hoja a procesar (o Enter para todas): ").strip()
            hoja = eleccion if eleccion else None

    # 3. Mostrar preview
    print("")
    print("Leyendo archivo...")
    datos = leer_archivo(ruta, hoja=hoja)

    if hoja:
        datos = {hoja: datos} if hoja else datos
        # normalizar a dict
        datos = {hoja: datos[hoja]} if hoja else {hoja: datos for hoja, datos in datos.items()}

    # Si es CSV, lo envolvemos en dict con una sola "hoja"
    if extension == ".csv":
        filas_originales = datos
        filas_limpias = limpiar_filas(filas_originales)
        print("")
        for linea in calcular_vista_previa(filas_originales, filas_limpias):
            print(f"  {linea}")
        ver_preview = preguntar("¿Mostrar las primeras filas limpias? (s/n)", ["s", "n"])
        if ver_preview == "s":
            mostrar_resumen(filas_limpias)

        # 4. Formato de salida
        formato = preguntar("¿En qué formato guardo? (xlsx/csv/json)", ["xlsx", "csv", "json"])
        base = os.path.splitext(ruta)[0]
        salida = f"{base}_limpio.{formato}"
        guardar_filas(salida, filas_limpias)
        print("")
        print(f"LISTO. Archivo guardado en: {salida}")
        return

    # Para Excel, procesar todas las hojas
    base = os.path.splitext(ruta)[0]
    formato = preguntar("¿En qué formato guardo? (xlsx/csv/json)", ["xlsx", "csv", "json"])

    for nombre, filas in datos.items():
        filas_limpias = limpiar_filas(filas)
        nombre_seguro = re.sub(r"[^\w\- ]", "", nombre).strip().replace(" ", "_")
        salida = f"{base}_{nombre_seguro}_limpio.{formato}"
        guardar_filas(salida, filas_limpias)
        print(f"  Hoja '{nombre}' -> {salida}")

    print("")
    print("LISTO. Archivos guardados.")


def main():
    if len(sys.argv) == 1:
        menu_interactivo()
        return

    parser = argparse.ArgumentParser(description="Limpia archivos CSV o Excel eliminando vacíos y duplicados.")
    parser.add_argument("archivo", help="Ruta al archivo .csv o .xlsx")
    parser.add_argument("--salida", choices=["xlsx", "csv", "json"], default="xlsx", help="Formato de salida (xlsx o csv)")
    parser.add_argument("--hoja", help="Nombre de la hoja a procesar (solo Excel)")
    parser.add_argument("--vista-previa", action="store_true", help="Solo mostrar qué haría, sin guardar")
    args = parser.parse_args()

    if not os.path.isfile(args.archivo):
        print(f"Error: no se encontro el archivo '{args.archivo}'")
        sys.exit(1)

    print(f"Leyendo archivo: {args.archivo}")
    datos = leer_archivo(args.archivo, hoja=args.hoja)

    # Normaliza datos a dict {hoja: filas} para unificar el flujo
    if isinstance(datos, list):
        datos = {"hoja1": datos}

    # Preview: solo mostrar, no guardar
    if args.vista_previa:
        for nombre, filas in datos.items():
            limpias = limpiar_filas(filas)
            print("")
            print(f"--- Vista previa '{nombre}' ---")
            for linea in calcular_vista_previa(filas, limpias):
                print(f"  {linea}")
        return

    # Procesar y guardar
    base = os.path.splitext(args.archivo)[0]
    for nombre, filas in datos.items():
        limpias = limpiar_filas(filas)
        nombre_seguro = re.sub(r"[^\w\- ]", "", nombre).strip().replace(" ", "_")
        salida = f"{base}_{nombre_seguro}_limpio.{args.salida}" if len(datos) > 1 else f"{base}_limpio.{args.salida}"
        guardar_filas(salida, limpias)
        print(f"Archivo limpio guardado en: {salida}")


if __name__ == "__main__":
    import sys
    main()
```

---

## 6. Tests (`tests/test_core.py`)

```python
"""Tests para core.py"""

import pytest
from data_processor.core import normalizar_texto, limpiar_filas, deduplicar, quitar_filas_vacias


@pytest.mark.parametrize("entrada,esperado", [
    ("María Gómez", "maria gomez"),
    ("MARIA GOMEZ", "maria gomez"),
    ("  Pedro   López  ", "pedro lopez"),
    ("", ""),
    ("  ", ""),
    (123, "123"),
])
def test_normalizar_texto(entrada, esperado):
    assert normalizar_texto(entrada) == esperado


def test_quitar_filas_vacias():
    filas = [["a", "b"], ["", ""], ["x", "y"], ["", " "]]
    assert quitar_filas_vacias(filas) == [["a", "b"], ["x", "y"]]


def test_deduplicar_insensible():
    filas = [
        ["Nombre", "Ciudad"],
        ["María", "Bogotá"],
        ["MARIA", "Bogota"],   # dup
        ["Pedro", "Cali"],
        ["PEDRO", "CALI"],      # dup
        ["Ana", "Medellín"],
    ]
    limpias = deduplicar(filas)
    assert len(limpias) == 3  # cabecera + 2 únicas
    assert limpias[1][0] == "María"
    assert limpias[2][0] == "Pedro"


def test_limpiar_filas_pipeline():
    filas = [
        ["Nombre", "Ciudad"],
        ["María", "Bogotá"],
        ["", ""],
        ["MARIA", "BOGOTA"],    # dup
        ["  Pedro  ", "  Cali  "],
    ]
    limpias = limpiar_filas(filas)
    assert len(limpias) == 3  # cabecera + María + Pedro
    assert limpias[2][0] == "Pedro"
    assert limpias[2][1] == "Cali"
```

---

## 9. README.md del paquete

```markdown
# data-processor v2.0

Limpieza y conversión de CSV/Excel — CLI interactivo, auto-encoding, dedup insensible a mayúsculas/acentos.

## Instalación
```bash
pip install -e tools/data-processor
# o desde la raíz del monorepositorio
make install-processor
```

## Uso
```bash
# Modo interactivo (recomendado)
python -m data_processor

# Directo
python -m data_processor datos.csv --vista-previa
python -m data_processor datos.xlsx --salida json
```

## Qué hace
- Auto-detecta encoding (utf-8, latin-1, cp1252)
- Quita filas vacías
- Elimina duplicados (insensible a mayúsculas/acentos)
- Normaliza espacios
- Exporta: xlsx (números reales), csv (;), json

## Tests
```bash
make test-processor
```
```

---

## 10. Instalar y probar

```bash
# Desde la raíz del monorepositorio
make install-processor

# Prueba
python -m data_processor examples/ejemplo.csv --vista-previa
python -m data_processor examples/ejemplo.xlsx --salida json
```

---

## Próximos pasos

1. Lea `docs/tutorials/03-pdf-a-excel.md` — construye pdf-to-excel
2. Lea `docs/tutorials/04-convertidor-archivos.md` — construye file-converter
3. Lea `docs/tutorials/04-de-codigo-a-servicio.md` — de código a servicio vendible