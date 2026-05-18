# Application Variants

Tailored resumes and cover letters for specific roles or applications.

## Layout

Each variant is a **folder** containing the documents for one application:

```
variants/
├── backend-focused/
│   ├── resume.tex
│   └── coverletter.tex
├── frontend-focused/
│   ├── resume.tex
│   └── coverletter.tex
└── private-acme-corp/         # gitignored — see "Private variants" below
    ├── resume.tex
    └── coverletter.tex
```

The baselines live at the repo root:

- `../resume.tex` — canonical, general-purpose resume.
- `../coverletter.tex` — canonical cover letter with placeholders.

## How it works

- Each `variants/<name>/*.tex` file is self-contained. It can `\documentclass{resume}` (for resumes) or `\documentclass{article}` (for cover letters) exactly like the baselines, because the LaTeX compiler runs from the repo root and finds `resume.cls`, `fontawesome.sty`, etc. there.
- The GitHub Actions workflow at `../.github/workflows/build-pdf.yml` builds the baselines plus every variant on push.
- The artifact (`resume-pdfs`) contains all PDFs, with variant PDFs renamed to `<variant>-<doctype>.pdf` so they're unambiguous:
  - `resume.pdf`
  - `coverletter.pdf`
  - `backend-focused-resume.pdf`
  - `backend-focused-coverletter.pdf`

## Creating a new variant

```sh
# from the repo root
mkdir variants/staff-engineer
cp resume.tex       variants/staff-engineer/resume.tex
cp coverletter.tex  variants/staff-engineer/coverletter.tex
# edit both files, commit, push
```

A variant doesn't need both documents — if you only need a tailored resume, just create `variants/<name>/resume.tex` and skip the cover letter (or vice versa).

## Naming

Use kebab-case describing the angle, not the company:

- `backend-focused/`
- `frontend-focused/`
- `devops-cloud/`
- `staff-engineer/`

## Private / sensitive variants

If a variant is tailored to a specific company (mentions the company name, references their stack, etc.) and you don't want it in git, prefix the folder with `private-`:

- `variants/private-acme-corp/` → `variants/private-*` is in `.gitignore`, so the folder and its contents stay local.

You can still build private variants locally with `make variants`.

## Building locally

From the repo root:

```sh
make baseline            # build resume.pdf + coverletter.pdf
make variants            # build every variants/*/*.tex
make all                 # baseline + variants
xelatex variants/backend-focused/resume.tex   # build one document manually
```
