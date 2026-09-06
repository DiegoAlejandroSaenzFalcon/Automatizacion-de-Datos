# Guía de Contribución

¡Gracias por considerar contribuir a **data-tools-workshop**! Este documento te guiará para que tu contribución sea fluida, útil y alineada con los estándares del proyecto.

---

## Antes de empezar

1. **Lee este documento completo**.
2. Revisa los **issues abiertos** — tu idea puede ya estar en desarrollo o planificada.
3. Si es una **nueva funcionalidad grande**, abre un **issue** primero para discutir el diseño antes de codear.
4. Asegúrate de tener **Python 3.10+** instalado.

---

## Cómo contribuir (paso a paso)

### 1. Fork y clonar

```bash
# 1. Fork en GitHub (botón Fork arriba a la derecha)
# 2. Clona tu fork
git clone https://github.com/TU_USUARIO/data-tools-workshop.git
cd data-tools-workshop

# 3. Añade el repo original como upstream
git remote add upstream https://github.com/DiegoAlejandroSaenzFalcon/data-tools-workshop.git
```

### 2. Crea tu rama

```bash
git checkout main
git pull upstream main
git checkout -b feat/tu-mejora-descriptiva
# Usa prefijos: feat/, fix/, docs/, chore/, refactor/, test/, perf/
```

### 3. Instala el entorno de desarrollo

```bash
make install-dev
# Esto instala: dependencias, pre-commit hooks, commitizen
```

### 4. Haz tus cambios

* **Una sola responsabilidad por commit** (cada commit = una cosa).
* Escribe **tests** para tu código (ver `tools/*/tests/`).
* Actualiza **documentación** si cambia la interfaz (`docs/`, `README.md` del paquete).
* Sigue la **guía de estilo** (ver abajo).

### 4. Ejecuta los checks locales

```bash
make check
# Equivale a: lint + type-check + tests
# Debe pasar SIN ERRORES antes de pushear
```

### 5. Commit convencional

```bash
git add .
git commit
# commitizen te guiará: feat(scope): descripción breve
# Ejemplos:
# feat(processor): añade deduplicación fuzzy
# fix(pdf): corrige extracción en PDF sin bordes
# docs(readme): actualiza instrucciones de uso
# chore(deps): actualiza dependencias
# refactor(shared): extrae cli base a shared
```

### 5. Push y Pull Request

```bash
git push origin feat/tu-mejora-descriptiva
```

En GitHub, abre el **Pull Request** hacia `main` del repo original. Completa la plantilla de PR.

---

## Guía de estilo (obligatoria)

### Python

* **Type hints obligatorios** en funciones públicas (`mypy --strict`).
* **Docstrings** en estilo Google/NumPy en TODAS las funciones públicas.
* **Type hints** en variables complejas (`List[Dict[str, Any]]`, etc.).
* **Nombres descriptivos**: `filas_limpias` no `fl`, `convertir_a_numero` no `cnv`.
* **Imports absolutos** (`from tools.shared.utils import normalizar_texto`).
* **Type hints en variables** cuando no sean obvias.

### Docstrings (estilo Google)

```python
def normalizar_texto(texto: str) -> str:
    """Normaliza texto para comparación insensible a mayúsculas/acentos.

    Hace tres transformaciones en orden:
      1. Quita acentos (NFD + quitar combinantes).
      2. Minúsculas.
      3. Colapsa espacios múltiples a uno solo.

    Args:
        texto: Cadena a normalizar.

    Returns:
        Texto normalizado (minúsculas, sin acentos, espacios simples).

    Example:
        >>> normalizar_texto("  María Gómez  ")
        'maria gomez'
    """
```

### Commits (Conventional Commits)

```
tipo(scope): descripción corta en minúsculas

[Cuerpo opcional explicando QUÉ y POR QUÉ, no CÓMO]

[Footer opcional: Fixes #123, Closes #456]
```

**Tipos permitidos:**
| Tipo | Cuándo usar |
|---|---|
| `feat` | Nueva funcionalidad |
| `fix` | Corrección de bug |
| `docs` | Cambios en documentación |
| `chore` | Mantenimiento (deps, build, CI) |
| `refactor` | Reestructuración sin cambiar comportamiento |
| `test` | Añadir/actualizar tests |
| `perf` | Mejora de rendimiento |
| `style` | Formato, lint, sin cambio lógico |
| `ci` | Cambios en CI/CD |
| `revert` | Revertir commit anterior |

**Scope** (opcional): `processor`, `pdf`, `converter`, `shared`, `docs`, `ci`, `deps`, `build`, `release`.

### Tests

* **Cobertura mínima**: 80% en código nuevo.
* **Nombres**: `test_<qué_prueba>_<condición>_<resultado_esperado>`
* **Fixtures** en `conftest.py` del paquete.
* **Parametrización** para casos múltiples (`@pytest.mark.parametrize`).
* **Marcadores**: `@pytest.mark.unit`, `@pytest.mark.integration`, `@pytest.mark.slow`.

```python
@pytest.mark.parametrize("entrada,esperado", [
    ("María Gómez", "maria gomez"),
    ("MARIA GOMEZ", "maria gomez"),
    ("  Pedro   López  ", "pedro lopez"),
])
def test_normalizar_texto(entrada, esperado):
    assert normalizar_texto(entrada) == esperado
```

---

## Estructura de PR (template)

Cuando abras el PR, completa:

1. **Qué cambia** (qué y por qué)
2. **Cómo probar** (pasos para verificar)
3. **Checklist**:
   - [ ] `make check` pasa
   - [ ] Tests añadidos/actualizados
   - [ ] Documentación actualizada (README del paquete, docs/)
   - [ ] Commits convencionales
   - [ ] Sin código comentado/debug
   - [ ] Sin secrets/keys en código

---

## Reportar bugs

Usa la plantilla **Bug Report** en Issues. Incluye:
* Versión de Python / OS
* Pasos para reproducir
* Comportamiento esperado vs actual
* Logs/errores completos
* Archivo de ejemplo mínimo (si aplica)

---

## Proponer features

Usa la plantilla **Feature Request**. Explica:
* Problema que resuelve
* Usuario objetivo
* Alternativas consideradas
* Boceto de API/UX si aplica

---

## Preguntas

¿Dudas? Abre un **Discussion** en GitHub o escribe a `diegoalejandrosaenzfalcon@gmail.com`.

---

¡Gracias por contribuir! 🎉