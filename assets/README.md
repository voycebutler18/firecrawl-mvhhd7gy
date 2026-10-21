# Template assets

This folder holds the gallery images the Render templates team needs before
listing this template on `render.com/templates`. **Capture these after a real
deploy succeeds, not from a mockup.**

## Required

- `hero.png` — 1600 × 900. Screenshot of the Render dashboard showing the
  deployed `firecrawl` project with all five resources (`firecrawl-api`,
  `firecrawl-playwright`, `firecrawl-postgres`, `firecrawl-rabbitmq`,
  `firecrawl-redis`) in `live` status. This becomes the gallery card image.

- `logo.png` — 512 × 512, transparent background. Use the Firecrawl flame
  from [firecrawl/firecrawl/img/firecrawl_logo.png](https://github.com/firecrawl/firecrawl/blob/main/img/firecrawl_logo.png)
  (the upstream version is small; upscale or re-export from the source SVG
  if available).

## Adding them

Once captured, drop the files in this folder and reference them from
`README.md` near the top — for example:

```markdown
![Firecrawl on Render](./assets/hero.png)
```

The current `README.md` does not embed a hero image yet, on purpose: a
broken `![]()` link is worse than no image at all.
