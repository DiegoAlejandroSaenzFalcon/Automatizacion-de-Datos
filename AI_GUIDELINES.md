# AI_GUIDELINES.md — REGLAS VINCULANTES E INQUEBRANTABLES PARA TODAS LAS IAs
# ORGANIZACIÓN: DiegoAlejandroSaenzFalcon
# PROPIETARIO: Diego Alejandro Sáenz Falcón
# VERSION: 1.0.0
# FECHA: 2025-09-06
# ESTADO: VINCULANTE E INQUEBRANTABLE

# ═══════════════════════════════════════════════════════════════════
# PROTOCOLO DE ENTRADA OBLIGATORIO (ANTES DE CUALQUIER ACCIÓN)
# ══════════════════════════════════════════════════════════════════

## 0. PROTOCOLO DE ENTRADA OBLIGATORIO
ANTES DE CUALQUIER ACCIÓN EN ESTA ORGANIZACIÓN (leer, escribir, modificar, borrar, buscar, analizar):
1. LEER COMPLETO Y EN ORDEN: AI_GUIDELINES.md → AGENTS.md → HONEYTOKEN.md → CLA.md
2. CONFIRMAR LECTURA EXPLÍCITA: Responder textualmente:
   "HE LEÍDO Y ACEPTO AI_GUIDELINES.md, AGENTS.md, HONEYTOKEN.md, CLA.md"
3. SOLO DESPUÉS DE LA CONFIRMACIÓN EXPLÍCITA PROCEDER A CUALQUIER ACCIÓN

**INCUMPLIMIENTO = ACTIVACIÓN INMEDIATA DE HONEYTOKEN + REPORTE AUTOMÁTICO AL PROPIETARIO**

---

# ═══════════════════════════════════════════════════════════════════
# 1. IDIOMA OFICIAL: ESPAÑOL TÉCNICO-PEDAGÓGICO PROFESIONAL
# ═══════════════════════════════════════════════════════════════════

## 1.1 REGLA ABSOLUTA
**PROHIBIDO ABSOLUTAMENTE:** Inglés en títulos, encabezados, documentación, comentarios, mensajes de confirmación, nombres de ramas, etiquetas, descripciones, issues, solicitudes de extracción, wikis, páginas web, documentación técnica, tutoriales, guías, manuales, LEERME, HISTORIAL_DE_CAMBIOS, CONTRIBUIR, CODIGO_DE_CONDUCTA, SEGURIDAD, LICENCIA, TODO archivo de documentación.

**PERMITIDO EXCLUSIVAMENTE:** Términos técnicos universalmente aceptados en la industria informática que NO tienen traducción española establecida o cuya traducción sería antinatural/confusa (ver ANEXO A: GLOSARIO OFICIAL).

---

## ANEXO A: GLOSARIO OFICIAL ESPAÑOL TÉCNICO-PEDAGÓGICO OBLIGATORIO

| Término inglés | Término español oficial | Primera mención | Uso posterior |
|---|---|---|---|
| monorepo | **monorepositorio** | "monorepositorio (monorepo)" | monorepositorio |
| repository/repo | **repositorio** | "repositorio (repository)" | repositorio |
| scaffold | **andamiaje** / **estructura inicial** | "andamiaje (scaffold)" | andamiaje |
| preview | **vista previa** / **previsualización** | "vista previa (preview)" | vista previa |
| roadmap | **hoja de ruta** / **plan de evolución** | "hoja de ruta (roadmap)" | hoja de ruta |
| getting started | **primeros pasos** | "primeros pasos (getting started)" | primeros pasos |
| architecture | **arquitectura** | "arquitectura (architecture)" | arquitectura |
| reference | **referencia técnica** | "referencia técnica (reference)" | referencia técnica |
| business | **negocio** / **aspectos comerciales** | "negocio (business)" | negocio |
| pricing | **precios** / **estrategia de precios** | "precios (pricing)" | precios |
| finding clients | **búsqueda de clientes** / **adquisición de clientes** | "búsqueda de clientes (finding clients)" | búsqueda de clientes |
| delivery | **entrega** / **gestión de entrega** | "entrega (delivery)" | entrega |
| CLI | **interfaz de línea de comandos (CLI)** | "interfaz de línea de comandos (CLI)" | CLI |
| API | **interfaz de programación de aplicaciones (API)** | "interfaz de programación de aplicaciones (API)" | API |
| REST | **transferencia de estado representacional (REST)** | "transferencia de estado representacional (REST)" | REST |
| JSON | **notación de objetos de JavaScript (JSON)** | "notación de objetos de JavaScript (JSON)" | JSON |
| YAML | **YAML** | "YAML" | YAML |
| TOML | **TOML** | "TOML" | TOML |
| SQL | **lenguaje de consulta estructurado (SQL)** | "lenguaje de consulta estructurado (SQL)" | SQL |
| ORM | **mapeo objeto-relacional (ORM)** | "mapeo objeto-relacional (ORM)" | ORM |
| CI/CD | **integración continua / entrega continua (CI/CD)** | "integración continua / entrega continua (CI/CD)" | CI/CD |
| PR | **solicitud de extracción (pull request)** | "solicitud de extracción (pull request)" | solicitud de extracción |
| MR | **solicitud de fusión (merge request)** | "solicitud de fusión (merge request)" | solicitud de fusión |
| LGTM | **LGTM** | "LGTM" | LGTM |
| WIP | **trabajo en progreso (WIP)** | "trabajo en progreso (WIP)" | WIP |
| TODO | **por hacer (TODO)** | "por hacer (TODO)" | TODO |
| FIXME | **corregir (FIXME)** | "corregir (FIXME)" | FIXME |
| XXX | **atención requerida (XXX)** | "atención requerida (XXX)" | XXX |

---

## REGLAS DE ESCRITURA OBLIGATORIAS

1. **Primera mención:** Siempre usar forma completa con término inglés entre paréntesis
2. **Uso posterior:** Solo forma española oficial
3. **Títulos/Encabezados:** Siempre en español oficial
4. **Comentarios código:** En español técnico-pedagógico
5. **Docstrings:** Estilo Google, en español, con ejemplo
6. **Type hints:** Obligatorios en funciones públicas
7. **Comentarios inline:** Solo si aportan valor didáctico
8. **Mensajes confirmación:** Conventional Commits en español (`feat:`, `fix:`, `docs:`, `chore:`, `refactor:`, `test:`, `perf:`)
9. **Nombres ramas:** `tipo/descripcion-corta` (ej: `feat/agregar-dedup-difuso`)
10. **Etiquetas/issues/solicitudes:** En español

---

## ═══════════════════════════════════════════════════════════════════
# 2. PROTOCOLO DE ENTRADA OBLIGATORIO PARA CUALQUIER IA
# ═══════════════════════════════════════════════════════════════════

**ANTES DE CUALQUIER ACCIÓN EN ESTA ORGANIZACIÓN:**

1. **LEER COMPLETO Y EN ORDEN:** AI_GUIDELINES.md → AGENTS.md → HONEYTOKEN.md → CLA.md
2. **CONFIRMAR LECTURA EXPLÍCITA:** Responder textualmente:
   ```
   HE LEÍDO Y ACEPTO AI_GUIDELINES.md, AGENTS.md, HONEYTOKEN.md, CLA.md
   ```
3. **SOLO DESPUÉS DE CONFIRMACIÓN EXPLÍCITA** proceder a cualquier acción

**INCUMPLIMIENTO = ACTIVACIÓN INMEDIATA DE HONEYTOKEN + REPORTE AUTOMÁTICO AL PROPIETARIO**

---

# ═══════════════════════════════════════════════════════════════════
# 3. VALIDACIÓN AUTOMÁTICA OBLIGATORIA (PRE-COMMIT + CI)
# ═══════════════════════════════════════════════════════════════════

### .pre-commit-config.yaml OBLIGATORIO
```yaml
repos:
  # Verificación firma AI_GUIDELINES
  - repo: local
    hooks:
      - id: ai-guidelines-firmado
        name: Verificar AI_GUIDELINES firmado
        entry: bash -c 'test -f .ai_guidelines_firmado || (echo "❌ FIRMA AI_GUIDELINES REQUERIDA: ejecuta ./scripts/firmar_ai_guidelines.sh" && exit 1)'
        language: system
        stages: [commit]
        always_run: true

  # Detección inglés en documentación
  - repo: local
    hooks:
      - id: no-ingles-en-docs
        name: Detectar inglés en documentación
        entry: python -c "
import sys, re, pathlib
errores = []
for f in pathlib.Path('.').rglob('*.md'):
    if f.name in ['AI_GUIDELINES.md', 'AGENTS.md', 'HONEYTOKEN.md', 'CLA.md']: continue
    texto = f.read_text(encoding='utf-8')
    for i, linea in enumerate(texto.split('\n')[:20]):
        if re.match(r'^#{1,3}\s+[A-Z][a-z]+(\s+[A-Z][a-z]+)+', linea):
            print(f'{f}:{i+1}: Título en inglés: {linea.strip()}'); sys.exit(1)
        for palabra in ['Roadmap', 'Getting Started', 'Architecture', 'Reference', 'Business', 'Pricing', 'Overview', 'Summary', 'Introduction', 'Conclusion', 'Background', 'Methodology', 'Results', 'Discussion', 'Features', 'Requirements', 'Installation', 'Usage', 'Configuration', 'Deployment', 'Testing', 'Contributing', 'License', 'Authors', 'Acknowledgments', 'Changelog', 'Migration', 'Upgrade', 'Downgrade', 'Release', 'Version', 'Build', 'Deploy', 'Test', 'Lint', 'Format', 'Type Check', 'Security', 'Performance', 'Benchmark', 'Profiling', 'Optimization', 'Refactoring', 'Feature', 'Bug Fix', 'Hotfix', 'Breaking Change', 'Deprecated', 'Removed', 'Added', 'Changed', 'Fixed', 'Security', 'Performance', 'Improvement', 'Enhancement']:
            if palabra in linea and linea.startswith('#'):
                print(f'{f}:{i+1}: Palabra inglesa en título: {palabra}'); sys.exit(1)
"
        language: python
        stages: [commit]
        always_run: true

  # Ruff + Black + MyPy estricto
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.5.7
    hooks:
      - id: ruff
        args: [--fix, --exit-non-zero-on-fix]
      - id: ruff-format
  - repo: https://github.com/psf/black
    rev: 24.8.0
    hooks:
      - id: black
        args: [--line-length=100]
  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.11.2
    hooks:
      - id: mypy
        args: [--strict, --show-error-codes]
        exclude: ^tools/.*/tests/

  # Commitizen para confirmaciones convencionales
  - repo: https://github.com/commitizen-tools/commitizen
    rev: v3.28.0
    hooks:
      - id: commitizen
        stages: [commit-msg]
        args: [check]
```

---

### SCRIPTS OBLIGATORIOS

**`scripts/firmar_ai_guidelines.sh` (EJECUTAR ANTES DE PRIMER CONFIRMACIÓN):**
```bash
#!/bin/bash
# Script obligatorio: firma de AI_GUIDELINES antes de primer confirmación

echo "════════════════════════════════════════════════════════════"
echo "  PROTOCOLO DE ENTRADA OBLIGATORIO - ORGANIZACIÓN DiegoAlejandroSaenzFalcon"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "LEYENDO ARCHIVOS OBLIGATORIOS EN ORDEN:"
echo "  1. AI_GUIDELINES.md"
echo "  2. AGENTS.md"
echo "  3. HONEYTOKEN.md"
echo "  4. CLA.md"
echo ""

for archivo in AI_GUIDELINES.md AGENTS.md HONEYTOKEN.md CLA.md; do
    if [[ -f "$archivo" ]]; then
        echo "━━━ $archivo ━━━"
        cat "$archivo"
        echo ""
    else
        echo "❌ ARCHIVO FALTANTE: $archivo"
        exit 1
    fi
done

echo ""
read -p "¿Has leído COMPLETO y ACEPTAS AI_GUIDELINES.md, AGENTS.md, HONEYTOKEN.md, CLA.md? (sí/no): " respuesta
case "${respuesta,,}" in
    sí|si|s|yes|y)
        echo "$(date -Iseconds) $(git config user.name) <$(git config user.email)> ACEPTA AI_GUIDELINES, AGENTS, HONEYTOKEN, CLA" >> .ai_guidelines_firmado
        git add .ai_guidelines_firmado 2>/dev/null || true
        echo ""
        echo "✅ FIRMA REGISTRADA. Puedes proceder."
        exit 0
        ;;
    *)
        echo ""
        echo "❌ DEBES LEER Y ACEPTAR LOS 4 ARCHIVOS PARA PROCEDER"
        echo "   Ejecuta este script nuevamente después de leerlos."
        exit 1
        ;;
esac
```

---

### CI/CD OBLIGATORIO (`.github/workflows/ci.yml`)

```yaml
name: CI - Validación Obligatoria

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  validar-ai-guidelines:
    name: Validar AI_GUIDELINES
    runs-on: ubuntu-latest
    timeout-minutes: 10
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Configurar Python
        uses: actions/setup-python@v5
        with:
          python-version: "3.12"
          cache: pip
          cache-dependency-path: |
            pyproject.toml
            tools/*/pyproject.toml

      - name: Instalar dependencias
        run: |
          python -m pip install --upgrade pip
          pip install -e .[dev,data-processor,pdf-to-excel,file-converter,shared]

      - name: Verificar firma AI_GUIDELINES
        run: |
          if [[ ! -f .ai_guidelines_firmado ]]; then
            echo "❌ AI_GUIDELINES no firmado. Ejecuta ./scripts/firmar_ai_guidelines.sh"
            exit 1
          fi
          echo "✅ AI_GUIDELINES firmado"

      - name: Verificar idioma español en documentación
        run: |
          python -c "
import sys, re, pathlib
errores = []
for f in pathlib.Path('.').rglob('*.md'):
    if f.name in ['AI_GUIDELINES.md', 'AGENTS.md', 'HONEYTOKEN.md', 'CLA.md']: continue
    texto = f.read_text(encoding='utf-8')
    for i, linea in enumerate(texto.split('\n')[:20]):
        if re.match(r'^#{1,3}\s+[A-Z][a-z]+(\s+[A-Z][a-z]+)+', linea):
            print(f'{f}:{i+1}: Título en inglés: {linea.strip()}'); exit(1)
        for palabra in ['Roadmap', 'Getting Started', 'Architecture', 'Reference', 'Business', 'Pricing', 'Overview', 'Summary', 'Introduction', 'Conclusion', 'Background', 'Methodology', 'Results', 'Discussion', 'Features', 'Requirements', 'Installation', 'Usage', 'Configuration', 'Deployment', 'Testing', 'Contributing', 'License', 'Authors', 'Acknowledgments', 'Changelog', 'Migration', 'Upgrade', 'Downgrade', 'Release', 'Version', 'Build', 'Deploy', 'Test', 'Lint', 'Format', 'Type Check', 'Security', 'Performance', 'Benchmark', 'Profiling', 'Optimization', 'Refactoring', 'Feature', 'Bug Fix', 'Hotfix', 'Breaking Change', 'Deprecated', 'Removed', 'Added', 'Changed', 'Fixed', 'Security', 'Performance', 'Improvement', 'Enhancement']:
            if palabra in linea and linea.startswith('#'):
                print(f'ERROR: {f}: Palabra inglesa en título: {palabra}'); exit(1)
          print('✅ Documentación en español correcta')
"
        shell: bash

      - name: Ruff lint + format
        run: ruff check --fix . && ruff format --check .

      - name: MyPy strict type-check
        run: mypy --strict .

      - name: Tests con coverage
        run: pytest --cov=tools --cov-report=term-missing --cov-fail-under=80
```

---

### ARCHIVOS QUE DEBEN EXISTIR EN RAÍZ DE LA ORGANIZACIÓN

```
organización/
├── AI_GUIDELINES.md          # ESTE ARCHIVO (vinculante)
├── AGENTS.md                 # Instrucciones IA autorizada
├── HONEYTOKEN.md             # Tripwire IA no autorizada
├── CLA.md                    # Acuerdo de licencia de contribuidor
├── SECURITY.md               # Política seguridad
├── CONTRIBUTING.md           # Guía contribución
├── CODE_OF_CONDUCT.md        # Código conducta
├── LICENSE                   # MIT
├── CHANGELOG.md              # Keep a Changelog
├── .pre-commit-config.yaml   # Hooks obligatorios
├── pyproject.toml            # Config raíz + workspaces
├── Makefile                  # Comandos unificados
├── scripts/
│   └── firmar_ai_guidelines.sh # Firma obligatoria
├── .github/
│   ├── workflows/
│   │   ├── ci.yml            # CI obligatorio
│   │   ├── docs.yml          # Docs deploy
│   │   └── release.yml       # Release automation
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.yml
│   │   ├── feature_request.yml
│   │   └── security_report.yml
│   └── PULL_REQUEST_TEMPLATE.md
├── scripts/
│   └── firmar_ai_guidelines.sh
├── .pre-commit-config.yaml
├── pyproject.toml            # Config raíz + workspaces
├── Makefile                  # Comandos unificados
├── CHANGELOG.md
├── LICENSE
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── SECURITY.md
└── README.md
```

---

### HONEYTOKEN.md (TRIPWIRE) — YA EXISTE EN AI-Security-Guardrails
**Copiar a raíz de cada repositorio canónico** para activar tripwire automático.

---

### AGENTS.md — YA EXISTE EN AI-Security-Guardrails
**Copiar a raíz de cada repositorio canónico** para instrucciones IA autorizada.

---

### CLA.md — YA EXISTE EN AI-Security-Guardrails
**Copiar a raíz de cada repositorio canónico** para acuerdo de licencia.

---

### SCRIPTS OBLIGATORIOS

**`scripts/firmar_ai_guidelines.sh` (EJECUTAR ANTES DE PRIMER CONFIRMACIÓN):**
```bash
#!/bin/bash
# Script obligatorio: firma de AI_GUIDELINES antes de primer commit

echo "════════════════════════════════════════════════════════════"
echo "  PROTOCOLO DE ENTRADA OBLIGATORIO - ORGANIZACIÓN DiegoAlejandroSaenzFalcon"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "LEYENDO ARCHIVOS OBLIGATORIOS EN ORDEN:"
echo "  1. AI_GUIDELINES.md"
echo "  2. AGENTS.md"
echo "  3. HONEYTOKEN.md"
echo "  4. CLA.md"
echo ""

for archivo in AI_GUIDELINES.md AGENTS.md HONEYTOKEN.md CLA.md; do
    if [[ -f "$archivo" ]]; then
        echo "━━━ $archivo ━━━"
        cat "$archivo"
        echo ""
    else
        echo "❌ ARCHIVO FALTANTE: $archivo"
        exit 1
    fi
done

echo ""
read -p "¿Has leído COMPLETO y ACEPTAS AI_GUIDELINES.md, AGENTS.md, HONEYTOKEN.md, CLA.md? (sí/no): " respuesta
case "${respuesta,,}" in
    sí|si|s|yes|y)
        echo "$(date -Iseconds) $(git config user.name) <$(git config user.email)> ACEPTA AI_GUIDELINES, AGENTS, HONEYTOKEN, CLA" >> .ai_guidelines_firmado
        git add .ai_guidelines_firmado 2>/dev/null || true
        echo ""
        echo "✅ FIRMA REGISTRADA. Puedes proceder."
        exit 0
        ;;
    *)
        echo ""
        echo "❌ DEBES LEER Y ACEPTAR LOS 4 ARCHIVOS PARA PROCEDER"
        echo "   Ejecuta este script nuevamente después de leerlos."
        exit 1
        ;;
esac
```