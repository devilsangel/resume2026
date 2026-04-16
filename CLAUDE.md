# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A LaTeX-based resume that auto-compiles to PDF and deploys to GitHub Pages. The source of truth is `resume.tex`; the PDF and HTML wrapper are generated artifacts.

## Build Commands

```bash
make          # Compile resume.tex → Kevin_Joseph_Resume_2026.pdf
make clean    # Remove all LaTeX build artifacts
```

Local builds require `latexmk` and a LaTeX distribution (e.g. TeX Live) with `pdflatex`.

## Architecture

```
resume.tex                     # Single-file LaTeX source (the resume content)
.latexmkrc                     # Sets output job name to Kevin_Joseph_Resume_2026
Makefile                       # Thin wrapper around latexmk
.github/workflows/deploy.yml   # CI/CD: compile → generate HTML → deploy to gh-pages
```

### CI/CD Pipeline (`deploy.yml`)

On every push to `main` (or manual dispatch), GitHub Actions:
1. Compiles `resume.tex` to `Kevin_Joseph_Resume_2026.pdf` using `xu-cheng/latex-action@v3` with `pdflatex`
2. Generates `_site/index.html` — a dark-themed responsive HTML page that embeds the PDF via `<iframe>` on desktop and shows download/open links on mobile (breakpoint: 767px)
3. Deploys `_site/` to the `gh-pages` branch via `peaceiris/actions-gh-pages@v4` with `force_orphan: true`

The HTML for the GitHub Pages site is defined inline in `deploy.yml` (the `cat > _site/index.html << 'EOF'` block) — not as a separate file in the repo.

### Output File Naming

The PDF output name `Kevin_Joseph_Resume_2026` is set in two places that must stay in sync:
- `.latexmkrc`: `$jobname = 'Kevin_Joseph_Resume_2026';`
- `Makefile`: `OUTPUT = Kevin_Joseph_Resume_2026`
- `deploy.yml`: hardcoded in the `args:` line and the HTML template
