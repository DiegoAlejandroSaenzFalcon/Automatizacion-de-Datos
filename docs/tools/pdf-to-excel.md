# pdf-to-excel — Referencia técnica

Herramienta CLI que extrae tablas de PDF y las guarda en Excel (.xlsx) o CSV.

---

## Instalación

```bash
pip install -e tools/pdf-to-excel
# o desde la raíz
make install-pdf
```

---

## Uso rápido

```bash
# Extrae todas las tablas a Excel (una hoja por tabla)
python -m pdf_to_excel factura.pdf --salida xlsx

# Solo páginas 1 y 3
python -m pdf_to_excel factura.pdf --paginas 1,3 --salida xlsx

# Salida CSV (un archivo por tabla)
python -m pdf_to_excel factura.pdf --salida csv
```

---

## Qué hace (y qué no)

| ✅ Hace | ❌ No hace |
|---|---|
| Extrae tablas con `pdfplumber` (bordes/líneas) | No hace OCR (PDFs escaneados) |
| Cada tabla → hoja separada (Excel) | No une/mergea tablas de páginas distintas |
| Filtra filas vacías automáticamente | No reconstruye tablas sin bordes |
| Exporta a **xlsx** (hojas) o **csv** (archivos separados) | No exporta a JSON todavía |
| Opción `--paginas` para páginas específicas | No procesa carpetas enteras |

---

## Arquitectura interna

```
src/pdf_to_excel/
├── cli.py        # argparse
├── extractor.py  # extraer_tablas(), filtrar_vacios()
└── io.py         # guardar_excel(), guardar_csv()
```

### Flujo

```
extraer_tablas(pdf) → filtrar_vacios() → guardar_excel() / guardar_csv()
```

### Funciones clave

| Función | Qué hace |
|---|---|
| `extraer_tablas(pdf, paginas)` | `pdfplumber.open()` → `page.extract_tables()` |
| `filtrar_vacios()` | Quita filas donde todas las celdas son vacías |
| `guardar_excel()` | Un .xlsx, una hoja por tabla |
| `guardar_csv()` | Un .csv por tabla |

---

## CLI Reference

```
usage: pdf_to_excel [-h] [--salida {xlsx,csv}] [--paginas PAGINAS] archivo

positional:
  archivo              Archivo .pdf

options:
  --salida {xlsx,csv}     Formato salida (default: xlsx)
  --paginas PAGINAS       Páginas a extraer (ej: 1,3,5)
  -h, --help              Muestra ayuda
```

### Ejemplos

```bash
# Extrae todas las tablas a Excel
python -m pdf_to_excel factura.pdf --salida xlsx

# Solo páginas 1 y 3
python -m pdf_to_excel factura.pdf --paginas 1,3 --salida xlsx

# Salida CSV (un archivo por tabla)
python -m pdf_to_excel factura.pdf --salida csv
```

---

## Ejemplos de uso real

```bash
# Factura PDF → Excel
python -m pdf_to_excel factura.pdf --salida xlsx

# Reporte PDF páginas 1-3 → CSV
python -m pdf_to_excel reporte.pdf --paginas 1,2,3 --salida csv

# Catálogo PDF → Excel
python -m pdf_to_excel catalogo.pdf --salida xlsx
```

---

## Tests

```bash
make test-pdf
# o directo
pytest tools/pdf-to-excel/tests -v
```

---

## Limitaciones conocidas

1. **No hace OCR** — PDFs escaneados (imagen) requieren OCR previo
2. **Tablas sin bordes** — `pdfplumber` detecta mejor tablas con bordes/líneas
3. **Celdas combinadas** — Pueden salir desalineadas
3. **No une tablas** — Cada tabla = hoja/archivo separado
4. **No procesa carpetas** — Un PDF a la vez

---

## Roadmap (v1.1+)

- [ ] OCR opcional con Tesseract (`--ocr`)
- [ ] Detectar tablas sin bordes (heurísticas)
- [ ] Unir tablas de páginas consecutivas (`--unir`)
- [ ] Exportar a JSON
- [ ] Procesar carpeta completa (`--carpeta`)
- [ ] Config YAML para áreas de extracción fijas

---

## Contribuir

Ver `CONTRIBUTING.md` en la raíz del monorepo.