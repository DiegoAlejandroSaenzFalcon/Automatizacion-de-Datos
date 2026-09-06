# Pull Request Template

## Qué cambia
Descripción clara de los cambios (qué y por qué).

## Tipo de cambio
- [ ] Bug fix (fix)
- [ ] Nueva funcionalidad (feat)
- [ ] Documentación (docs)
- [ ] Refactor (refactor)
- [ ] Tests (test)
- [ ] Performance (perf)
- [ ] Chore / CI / Dependencias (chore/ci/deps)

## Cómo probar
Pasos para verificar que los cambios funcionan:

```bash
# Ejemplo:
make test-processor
python -m data_processor examples/test.csv --preview
```

## Checklist
- [ ] `make check` pasa sin errores
- [ ] Tests añadidos/actualizados para el código nuevo
- [ ] Documentación actualizada (README del paquete, docs/, docstrings)
- [ ] Commits convencionales (`feat:`, `fix:`, `docs:`, etc.)
- [ ] Sin código comentado / debug / prints innecesarios
- [ ] Sin secrets / API keys / credenciales en el código
- [ ] Type hints y docstrings en funciones públicas nuevas

## Contexto adicional
Screenshots, logs, referencias a issues relacionados, etc.

## Issues relacionados
Fixes #123
Closes #456