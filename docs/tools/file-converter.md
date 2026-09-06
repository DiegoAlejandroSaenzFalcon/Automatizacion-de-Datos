# file-converter — Referencia técnica

Herramienta CLI que convierte entre CSV, Excel (.xlsx) y JSON.

---

## Instalación

```bash
pip install -e tools/file-converter
# o desde la raíz
make install-converter
```

---

## Uso rápido

```bash
python -m file_converter archivo.csv --a xlsx
python -m file_converter archivo.xlsx --a csv
python -m file_converter datos.csv --a json
```

---

## Qué hace (y qué no)

| ✅ Hace | ❌ No hace |
|---|---|
| Lee CSV, Excel (.xlsx), JSON | No lee .ods, .xls antiguo |
| Convierte entre los 3 formatos | No une/mergea archivos |
| CSV con separador `;` (estándar español) | No valida emails/teléfonos |
| JSON → lista de objetos `{columna: valor}` | No infiere tipos complejos |
| Excel: primera hoja | No procesa múltiples hojas |

---

## Arquitectura interna

```
src/file_converter/
├── cli.py        # argparse
├── converter.py  # leer_*, guardar_*, leer(), guardar()
└── io.py         # (integrado en converter.py)
```

### Flujo

```
leer() → convertir → guardar()
```

### Funciones clave

| Función | Qué hace |
|---|---|
| `leer_csv()` | `csv.reader` con encoding utf-8-sig |
| `leer_xlsx()` | `openpyxl` read_only, data_only |
| `leer_json()` | Lista de objetos → filas (cabecera + valores) |
| `leer()` | Detecta extensión y delega |
| `guardar_csv()` | `csv.writer(delimiter=";")` |
| `guardar_xlsx()` | `openpyxl.Workbook` + `append()` |
| `guardar_json()` | Lista de dicts `{columna: valor}` |

---

## CLI Reference

```
usage: file_converter [-h] --a {csv,xlsx,json} archivo

positional:
  archivo              Archivo de entrada (.csv, .xlsx, .json)

required:
  --a {csv,xlsx,json}   Formato de salida
```

### Ejemplos

```bash
# CSV → Excel
python -m file_converter archivo.csv --a xlsx

# Excel → CSV
python -m file_converter archivo.xlsx --a csv

# CSV → JSON
python -m file_converter datos.csv --a json

# JSON → Excel
python -m file_converter datos.json --a xlsx

# Excel → JSON
python -m file_converter datos.xlsx --a json
```

---

## Formatos soportados

| De \ A | CSV | XLSX | JSON |
|---|---|---|---|
| **CSV** | — | ✅ | ✅ |
| **XLSX** | ✅ | — | ✅ |
| **JSON** | ✅ | ✅ | — |

> JSON de entrada: lista de objetos `[{"a":1,"b":2}, ...]` o lista de listas `[[...], ...]`
> JSON de salida: lista de objetos `[{"columna": valor}, ...]`

---

## Ejemplos de uso real

```bash
# CSV → Excel para cliente
python -m file_converter clientes.csv --a xlsx

# Excel → CSV para importar en otro sistema
python -m file_converter reporte.xlsx --a csv

# CSV → JSON para API
python -m file_converter datos.csv --a json

# JSON de API → Excel para reporte
python -m file_converter respuesta_api.json --a xlsx
```

---

## Tests

```bash
make test-converter
# o directo
pytest tools/file-converter/tests -v
```

---

## Limitaciones conocidas

1. **Solo primera hoja** de Excel (no procesa multi-hoja)
2. **CSV separador `;`** fijo (estándar español)
3. **JSON entrada**: lista de objetos con mismas claves, o lista de listas
4. **No valida** tipos de datos complejos (fechas, emails)
5. **No une archivos** — un archivo a la vez
6. **No procesa carpetas** — un archivo a la vez

---

## Roadmap (v1.1+)

- [ ] Soporte multi-hoja Excel (`--hoja`)
- [ ] Auto-detección de separador CSV
- [ ] Validación de esquemas JSON
- [ ] Exportar a Parquet
- [ ] Procesar carpeta completa (`--carpeta`)
- [ ] Streaming para archivos grandes (>100MB)

---

## Contribuir

Ver `CONTRIBUTING.md` en la raíz del monorepo.