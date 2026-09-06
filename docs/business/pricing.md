# Pricing — Guía de precios para servicios de datos

---

## Filosofía

* **Empieza bajo** para conseguir reseñas → **sube progresivo** con evidencia.
* **Cobra por valor entregado**, no por horas.
* **Paquetes claros** evitan negociaciones interminables.

---

## Estructura de paquetes (modelo base)

| Paquete | Qué incluye | Precio inicio | Cuándo subir |
|---|---|---|---|
| **Básico** | 1 archivo ≤ 1.000 filas, limpieza básica, 1 formato | $10-15 | 5 reseñas 5★ |
| **Estándar** | Hasta 5.000 filas, multi-formato, normalización, resumen | $25-35 | 10 reseñas 5★ |
| **Premium** | Múltiples archivos, >5.000 filas, resumen ejecutivo, prioridad | $50-80 | 20 reseñas 5★ |
| **Enterprise** | Automatización recurrente, API, SLA, soporte prioritario | $200+/mes | Contrato anual |

---

## Factores de precio

| Factor | Impacto en precio |
|---|---|
| **Filas** | ≤1K: base | 1-10K: +50% | 10-50K: +100% | 50K+: cotizar |
| **Complejidad** | Limpieza simple: base | Multi-hoja: +30% | Fuzzy dedup: +50% | OCR/PDF: +100% |
| **Urgencia** | 48h+: base | 24h: +50% | 12h: +100% | 4h: +200% |
| **Formato extra** | 1 formato: base | +1 formato: +$5 | +2 formatos: +$10 |
| **Revisión extra** | 1 incluida | +1: +$10 | +2: +$20 |

---

## Fórmulas de cálculo

```python
precio_base = 15  # USD
multiplicador_filas = max(1, filas / 1000) ** 0.5  # raíz cuadrada
multiplicador_complejidad = 1 + (complejidad * 0.3)
multiplicador_urgencia = 1 + (urgencia_horas < 24) * 0.5 + (urgencia_horas < 12) * 0.5

precio_final = round(precio_base * multiplicador_filas * multiplicador_complejidad * multiplicador_urgencia)
```

---

## Ejemplos reales

| Caso | Filas | Complejidad | Urgencia | Precio calculado |
|---|---|---|---|---|
| Limpieza CSV simple | 500 | Baja | 48h | $15 |
| Limpieza Excel multi-hoja | 3.000 | Media | 24h | $35 |
| PDF → Excel + limpieza | 500 (PDF) | Alta | 24h | $45 |
| Automatización mensual | 10K/mes | Media | Recurrente | $200/mes |

---

## Cómo presentar precios al cliente

1. **Siempre 3 opciones** (Básico/Estándar/Premium) — el cerebro elige el medio.
2. **Destaca el Estándar** como "Más popular".
3. **Incluye lo que NO haces** (evita scope creep).
4. **Ofrece garantía**: "Si no quedas conforme, revisión gratis / devolución parcial".

---

## Plantilla de propuesta (copia y adapta)

```
Hola [Nombre],

Gracias por contactar. He revisado tu archivo de muestra y esto es lo que puedo hacer:

**Servicio:** Limpieza y organización de datos Excel/CSV
**Tu archivo:** ~3.000 filas, 5 columnas, Excel con 2 hojas
**Entregable:** Archivo limpio (xlsx + csv) + resumen de cambios

**Opciones:**
🟢 **Básico** — $20 — Limpieza básica (vacíos, duplicados exactos), 1 formato, 48h
🔵 **Estándar (Recomendado)** — $30 — Limpieza completa (vacíos, duplicados insensibles a mayúsculas/acentos, normalización), 2 formatos (xlsx+csv), resumen de cambios, 24h
🟣 **Premium** — $55 — Todo lo anterior + prioridad, revisión ilimitada, formato extra (JSON), 12h

¿Te parece bien el **Estándar**? Si te parece bien, confirmo y empecemos hoy mismo.

Saludos,
[Tu nombre]
```

---

## Reglas de oro

1. **Nunca des precio sin ver el archivo** — pide muestra primero.
2. **No compitas por precio** — compite por calidad, velocidad, comunicación.
3. **Sube precios cada 5-10 reseñas 5★** — es tu métrica de valor.
4. **No bajes precio por miedo** — si el cliente regatea, explica el valor o deja ir.
5. **Registra todo** — hoja de cálculo con: cliente, servicio, precio, tiempo real, reseña.

---

## Plantilla de seguimiento (Google Sheets / Excel)

| Fecha | Cliente | Plataforma | Servicio | Filas | Complejidad | Urgencia | Precio | Tiempo real | Reseña |
|---|---|---|---|---|---|---|---|---|---|
| 2025-01-15 | Cliente A | Fiverr | Limpieza Excel | 2,500 | Media | 24h | $30 | 1.5h | ⭐⭐⭐⭐⭐ |
| 2025-01-18 | Cliente B | Workana | PDF→Excel | 500 (PDF) | Alta | 24h | $45 | 2h | ⭐⭐⭐⭐⭐ |

---

> **Regla de oro:** Tu tiempo vale. Si tardas 30 min en un trabajo de $15, tu hora vale $30. Si tardas 2h, tu hora vale $7.5. Optimiza procesos, no bajes precios.