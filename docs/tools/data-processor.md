# data-processor — Referencia técnica

Herramienta CLI para limpieza y conversión de CSV/Excel.

---

## Instalación

```bash
pip install -e tools/data-processor
# o desde la raíz
make install-processor
```

---

## Uso rápido

```bash
# Modo interactivo (recomendado)
python -m data_processor

# Directo
python -m data_processor datos.csv --vista-previa
python -m data_processor datos.xlsx --salida json
python -m data_processor datos.xlsx --hoja Ventas --salida csv
```

---

## Qué hace (y qué no)

| ✅ Hace | ❌ No hace |
|---|---|
| Auto-detecta encoding (utf-8, latin-1, cp1252) | No lee .ods, .xls antiguo |
| Elimina filas vacías | No "adivina" filas casi vacías |
| Elimina duplicados **insensible a mayúsculas/acentos** | No fuzzy matching semántico |
| Procesa **todas las hojas** de Excel o una (`--hoja`) | No une/mergea hojas |
| Normaliza espacios (trim + colapsa internos) | No corrige ortografía |
| Convierte números a `int`/`float` reales en Excel | No infiere fechas complejas |
| Exporta **xlsx, csv (;), json** | No exporta parquet, sql, xml |
| Modo `--vista-previa` | No edita en sitio |
| Menú interactivo (`python -m data_processor`) | No tiene GUI |

---

## Arquitectura interna

```
src/data_processor/
├── cli.py        # argparse + menú interactivo
├── core.py       # limpieza (espacios, vacíos, dedup)
├── io.py         # lectura/escritura (CSV, Excel, JSON)
├── utils.py      # normalizar_texto, convertir_a_numero
└── cli.py        # entry point
```

### Flujo de datos

```
leer_archivo() → limpiar_espacios() → quitar_filas_vacias() → deduplicar() → guardar_filas()
```

### Funciones clave

| Función | Qué hace |
|---|---|
| `detectar_encoding()` | Prueba utf-8-sig → latin-1 → cp1252 |
| `normalizar_texto()` | NFD + quitar combinantes + lower + colapsa espacios |
| `deduplicar()` | `set()` de tuplas normalizadas (insensible a mayúsculas/acentos) |
| `convertir_a_numero()` | `"1500"` → `1500` (int), `"45.000"` → `45000.0` (float) |
| `guardar_filas()` | xlsx (números reales), csv (;), json |

---

## CLI Reference

```
usage: data_processor [-h] [--salida {xlsx,csv,json}] [--hoja HOJA] [--vista-previa] archivo

positional:
  archivo              Archivo .csv o .xlsx

options:
  --salida {xlsx,csv,json}   Formato salida (default: xlsx)
  --hoja HOJA                Hoja Excel a procesar (solo si multi-hoja)
  --vista-previa             Solo muestra qué haría, sin guardar
  -h, --help                 Muestra ayuda
```

### Ejemplos

```bash
# Vista previa
python -m data_processor datos.csv --vista-previa

# CSV → Excel (por defecto)
python -m data_processor datos.csv

# Excel → JSON
python -m data_processor datos.xlsx --salida json

# Solo hoja "Ventas" → CSV
python -m data_processor datos.xlsx --hoja Ventas --salida csv

# Modo interactivo
python -m data_processor
```

---

## Ejemplos de uso real

```bash
# Limpia CSV sucio
python -m data_processor datos_sucios.csv --salida xlsx

# Procesa Excel multi-hoja → JSON (una hoja = un archivo)
python -m data_processor reporte.xlsx --salida json

# Solo hoja "Ventas" → CSV
python -m data_processor reporte.xlsx --hoja Ventas --salida csv
```

---

## Tests

```bash
# Desde la raíz del monorepositorio
make test-processor

# O directo
pytest tools/data-processor/tests -v
```

---

## Limitaciones conocidas

1. **No une archivos** (merge) — procesa uno a uno
2. **No valida emails/teléfonos/fechas** — solo limpieza estructural
3. **No une filas "casi iguales"** ("Juan Perez" vs "Juan Pérez" sí; "Juan" vs "Juan Carlos" no)
4. **No procesa carpetas enteras** — un archivo a la vez
5. **No tiene GUI** — solo terminal + menú interactivo
6. **No guarda log** — solo vista previa por pantalla

---

## Hoja de ruta (v2.1+)

- [ ] Procesar carpeta completa (`--carpeta`)
- [ ] Deduplicación difusa (similitud > 85%)
- [ ] Detección automática de fechas/emails/teléfonos
- [ ] Exportar a Parquet, SQLite
- [ ] Barra de progreso para archivos grandes
- [ ] Archivo de config YAML para no repetir flags

---

## Contribuir

Ver `CONTRIBUTING.md` en la raíz del monorepositorio.