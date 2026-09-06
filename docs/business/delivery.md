# Entrega — Entrega profesional y gestión de cliente

---

## 1. Flujo de entrega estándar

```
1. Cliente envía archivo + requisitos
       ↓
2. Usted envía VISTA PREVIA gratis (5-10 filas procesadas)
       ↓
3. Cliente aprueba / pide ajustes
       ↓
4. Procesa archivo COMPLETO
       ↓
5. Entrega: archivo(s) + resumen + instrucciones
       ↓
6. Cliente revisa → Revisión (si pide) → Cierre
       ↓
7. Pide reseña → Archiva proyecto
```

---

## 2. Checklist de entrega (copie y use)

### Antes de enviar
- [ ] Archivo procesado completo (sin filas de prueba)
- [ ] Formato correcto (xlsx/csv/json según pedido)
- [ ] Resumen de cambios incluido
- [ ] Archivo original intacto (no modificó el del cliente)
- [ ] Sin datos sensibles expuestos (si los había, anonimizados)
- [ ] Formato de entrega correcto (adjunto en plataforma, no link externo)

### Archivos a entregar
| Archivo | Qué contiene |
|---|---|
| `archivo_limpio.xlsx` | Datos limpios, números reales, listo para usar |
| `resumen_cambios.txt` | Qué se hizo: vacíos eliminados, duplicados, normalizaciones |
| `instrucciones.txt` | Cómo usar el archivo, contactar para dudas |

---

## 3. Plantilla de resumen de cambios (copie y rellene)

```
RESUMEN DE CAMBIOS — [Nombre archivo original]
Fecha: [Fecha]
Cliente: [Nombre]

ARCHIVO ORIGINAL:
- Filas totales: [X]
- Columnas: [X]
- Hojas (si Excel): [Nombres]

CAMBIOS REALIZADOS:
- Filas vacías eliminadas: [X]
- Filas duplicadas eliminadas: [X] (insensible a mayúsculas/acentos)
- Espacios normalizados: [Sí/No]
- Números convertidos a real: [Sí/No]
- Conversión de formato: [Original] → [Entregado]

RESULTADO FINAL:
- Filas finales: [X]
- Columnas: [X]
- Formato entregado: [xlsx/csv/json]

NOTAS:
[Observaciones especiales, ej: "Columna 'Fecha' tenía formatos mixtos, se estandarizó a DD/MM/AAAA"]

---
Entregado por: [Su nombre]
Fecha: [Fecha]
Contacto: [Email/Fiverr/Workana]
```

---

## 4. Gestión de revisiones

| Escenario | Qué hacer |
|---|---|
| Cliente pide ajuste menor (formato, columna extra) | Incluido en 1 revisión gratis → hágalo y reenvíe |
| Cliente pide cambio de alcance (nueva columna, otro archivo) | "Eso está fuera del alcance original. Puedo hacerlo por $X adicional" |
| Cliente no responde tras entrega | Espera 48h → mensaje de seguimiento → cierra a los 5 días |
| Cliente insatisfecho | "¿Qué exactamente no cumple? Lo corrijo gratis si es error mío" |
| Cliente pide reembolso | Si es error suyo → reembolso parcial. Si es cambio de opinión → no reembolso, ofrece revisión |

---

## 5. Comunicación profesional

### Plantillas de mensajes

**Al entregar:**
```
Hola [Nombre],

Adjunto su archivo procesado:
- `archivo_limpio.xlsx` — datos limpios listos para usar
- `resumen_cambios.txt` — detalle de qué se limpió
- `instrucciones.txt` — cómo usar el archivo

Resumen rápido: se eliminaron [X] filas vacías y [Y] duplicados, se normalizaron espacios y se convirtieron números a formato real.

Cualquier duda o ajuste menor, me avisa. Incluye 1 revisión gratis.

Saludos,
[Su nombre]
```

**Seguimiento (48h sin respuesta):**
```
Hola [Nombre],

Quería confirmar que recibiste el archivo y todo está bien. Si necesita algún ajuste, avísame y lo hacemos sin cargo (incluye 1 revisión).

Saludos,
[Su nombre]
```

**Pidiendo reseña (tras confirmación):**
```
Hola [Nombre],

Me alegra que todo esté bien. Si tiene un minuto, una reseña de 5 estrellas en [Fiverr/Workana] me ayuda muchísimo a seguir creciendo. Es opcional, pero se agradece infinitamente.

¡Gracias y a disposición para lo que necesite!

[Su nombre]
```

---

## 6. Archivo del proyecto (organización)

```
proyectos/
├── 2025-01-15_cliente-A_fiverr/
│   ├── original/           # Archivo que mandó el cliente (NO TOCAR)
│   ├── procesado/          # Archivos generados por usted
│   ├── entregado/          # Lo que subió a la plataforma
│   ├── comunicacion/       # Capturas de chat, emails
│   └── factura/            # Captura de pago, factura si aplica
├── 2025-01-18_cliente_B_workana/
│   └── ...
```

> **Regla:** Nunca borre la carpeta `original/`. Es su evidencia si hay disputa.

---

## 8. Métricas de calidad de entrega

| Métrica | Objetivo | Cómo medir |
|---|---|---|
| **Tiempo de respuesta** | < 2h (horario laboral) | Timestamp primer mensaje → su respuesta |
| **Tiempo de entrega** | ≤ 24h estándar | Timestamp aprobación vista previa → entrega |
| **Tasa de revisión** | < 10% de pedidos | # revisiones / # entregas |
| **Satisfacción** | 100% 5★ | Reseñas en plataforma |
| **Reclamaciones** | 0% | Disputas abiertas / total pedidos |

---

## 9. Automatización de delivery (futuro)

| Qué automatizar | Herramienta |
|---|---|
| Email de entrega + resumen | Plantilla + script Python |
| Recordatorio de reseña | Zapier / Make / n8n |
| Backup de entregados | Google Drive / OneDrive sync |
| Facturación | FacturaScripts / Holded / Excel |

---

## 8. Checklist final antes de cerrar proyecto

- [ ] Archivo(s) entregado(s) en plataforma
- [ ] Resumen de cambios enviado
- [ ] Cliente confirmó que todo OK
- [ ] Reseña solicitada (si cliente contento)
- [ ] Proyecto archivado en `proyectos/`
- [ ] Factura/pago confirmado
- [ ] Próximo seguimiento agendado (si cliente recurrente)

---

> **Regla de oro:** La entrega no termina cuando sube el archivo. Termina cuando el cliente confirma que todo está perfecto Y usted tiene todo archivado para referencia futura.