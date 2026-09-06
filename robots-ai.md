# robots-ai.md — Crawlers de IA a bloquear (para derivados web)

Este repositorio es **privado** y GitHub no lo indexa públicamente. Sin embargo,
si en el futuro se publica contenido derivado (sitio web, docs, espejo público),
usa este `robots.txt` para mantener fuera a los crawlers de IA de entrenamiento.

## Lista de user-agents de IA (2025–2026)
- `GPTBot` — OpenAI (entrenamiento + ChatGPT Browse)
- `ChatGPT-User` — navegación en vivo de ChatGPT
- `Google-Extended` — entrenamiento de modelos de Google
- `ClaudeBot` / `anthropic-ai` — Anthropic
- `PerplexityBot` — Perplexity
- `CCBot` — Common Crawl (usado por muchos entrenamientos)
- `Bytespider` — ByteDance / TikTok
- `Applebot` — Apple Intelligence
- `Amazonbot` — Amazon Alexa
- `Omgili` / `OmgiliBot` — agregación de datos

## robots.txt sugerido (sitio web derivado)
```text
User-agent: GPTBot
Disallow: /

User-agent: ChatGPT-User
Disallow: /

User-agent: Google-Extended
Disallow: /

User-agent: ClaudeBot
Disallow: /

User-agent: anthropic-ai
Disallow: /

User-agent: PerplexityBot
Disallow: /

User-agent: CCBot
Disallow: /

User-agent: Bytespider
Disallow: /

User-agent: Applebot
Disallow: /

User-agent: Amazonbot
Disallow: /

User-agent: Omgili
Disallow: /

User-agent: *
Allow: /
```

> Nota: `robots.txt` es una convención voluntaria; los crawlers maliciosos
> pueden ignorarlo. Es una capa más, no una barrera.
