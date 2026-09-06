# ADR 0001: Monorepo vs Multi-repo

**Estado:** Aceptado

**Fecha:** 2025-09-06

**Autor:** Diego Alejandro Sáenz Falcón

---

## Contexto

El proyecto comenzó como varios repos independientes (data-processor, pdf-to-excel, file-converter, curriculum-vitae, soporte-ti-portafolio). Esto genera:

- Duplicación de configuración (CI, lint, tests, docs)
- Dificultad para compartir código (utils, CLI, exceptions)
- Overhead de mantenimiento (5+ repos para sincronizar)
- Dificultad para versionado coherente y releases atómicos

## Decisión

Migrar a **monorepo único** (`data-tools-workshop`) con estructura de workspaces (Hatch).

Cada herramienta vive en `tools/<nombre>/` como paquete instalable independiente, compartiendo código común en `tools/shared/`.

## Consecuencias

### Positivas
- **Cero duplicación** de configuración (CI, lint, types, tests, docs)
- **Código compartido real** — `tools/shared/` con CLI base, exceptions, logging, config, utils
- **Versionado atómico** — un tag = release de todo el ecosistema
- **Refactoring seguro** — cambios en shared se propagan a todas las herramientas
- **Onboarding simple** — un clone, un `make install-dev`, todo listo
- **Release atómico** — un tag = changelog + release de todo

### Negativas / Riesgos
- **Tamaño del repo** — crece con el tiempo (mitigable con .gitignore estricto)
- **Acoplamiento accidental** — cambios en shared pueden romper herramientas (mitigado con tests en CI matrix)
- **Build más lento** — matriz de tests 3 versiones Python × 3 herramientas (mitigable con cache)
- **Permisos granulares** — todo el equipo ve todo (no es problema en equipo pequeño)

### Neutrales
- Requiere herramienta de workspaces (Hatch elegido sobre Poetry/PDM)
- Requiere `pyproject.toml` root + workspaces config

## Alternativas consideradas

| Opción | Por qué se rechazó |
|---|---|
| **Multi-repo + git submodules** | Submodules son frágiles, dolorosos para onboarding, no resuelven compartición de código |
| **Multi-repo + package registry (PyPI privado)** | Overhead de publicar/installar shared en cada cambio; latencia en desarrollo |
| **Mono-repo con Poetry workspaces** | Poetry workspaces experimental, menos maduro que Hatch |
| **Mono-repo con PDM** | PDM excelente pero Hatch tiene mejor soporte para workspaces + build backend |

## Plan de implementación

1. ✅ Crear repo `data-tools-workshop` con estructura completa
2. ✅ Migrar `data-processor` v2.0 → `tools/data-processor/`
3. ✅ Migrar `pdf-to-excel` → `tools/pdf-to-excel/`
4. ✅ Migrar `file-converter` → `tools/file-converter/`
5. ✅ Crear `tools/shared/` con CLI base, exceptions, logging, config
5. ✅ `pyproject.toml` root con workspaces + optional-dependencies
6. ✅ CI/CD matrix (3.10/3.11/3.12) × 3 herramientas
6. ✅ MkDocs + GitHub Pages deploy
7. □ Tutoriales completos (01-05)
7. □ `tools/shared/` extracción completa
7. □ Release automation (cz + GitHub Release)

## Métricas de éxito

- [x] `make install-dev` funciona en < 2 min
- [x] `make check` pasa en < 3 min
- [x] `make test` > 80% coverage
- [x] `make docs-serve` levanta en < 10s
- [ ] `make release` crea release automático en GitHub
- [ ] Onboarding nuevo dev < 15 min (clone → make install-dev → make check)

## Referencias

- [Hatch workspaces](https://hatch.pypa.io/latest/config/workspaces/)
- [Monorepo benefits](https://monorepo.tools/)
- [Google monorepo](https://trunkbaseddevelopment.com/)