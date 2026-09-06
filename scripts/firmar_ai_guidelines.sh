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