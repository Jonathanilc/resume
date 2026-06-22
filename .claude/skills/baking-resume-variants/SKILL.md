---
name: baking-resume-variants
description: Use when asked to bake, create, or tailor a resume and/or cover-letter variant for a specific job in this resume repo (e.g. "bake a variant for this job", "make a variant for this role", a pasted job URL/description). Covers where files live, the candidate's fixed background, naming, LaTeX gotchas, and verification — so you don't re-scan the whole project.
---

# Baking Resume Variants

## Overview
This repo holds Jonathan Xu's LaTeX resume + cover letter. A **variant** is a tailored copy of both, angled at one job, living in `variants/<name>/`. This skill caches everything needed to bake one without re-reading the whole project: the layout, the candidate's fixed facts, the conventions, and the build/verify steps.

**Core principle: tailor the angle, never fabricate.** Reorder and reframe real experience to match the job; do not invent skills or experience Jonathan lacks.

## Where things live
- Baselines at repo root: `resume.tex` (`\documentclass{resume}`), `coverletter.tex` (`\documentclass[11pt,a4paper]{article}`).
- Variants: `variants/<name>/resume.tex` and/or `variants/<name>/coverletter.tex`. Each file is self-contained and compiles **from the repo root** (so it finds `resume.cls`, `fontawesome.sty`, etc.).
- `variants/README.md` documents the system; `Makefile` builds it; `.github/workflows/build-pdf.yml` builds baselines + every variant on push.
- A variant may include only one document (resume OR cover letter) — both is the norm.

## Workflow
1. **Read the job.** If given a URL, fetch it (WebFetch). Pull: company, title, location, employment type, required stack, responsibilities, candidate-profile language/tone.
2. **Pick the angle.** What does the JD lead with? Map it to Jonathan's real strengths (see fact sheet). Decide the framing in one phrase (e.g. "Go + AWS + platform reliability").
3. **Copy structure from the closest existing variant** (don't hand-build LaTeX). Good models: `variants/iot-backend/` (backend/Node + working-rights surfaced), `variants/potentia-integration/` (Python/integration, company-named), `variants/backend-focused/` (generic backend).
4. **Tune the resume:** rewrite the Summary to the angle; **reorder the Skills section to lead with the JD's tech**; reframe experience bullets toward what the role values (e.g. debugging/reliability vs. greenfield build). Keep dates, employers, titles, contact info **unchanged**.
5. **Tune the cover letter:** address the real company/people; match their tone; lead with the 1–2 strongest matches; **address gaps honestly** in one paragraph (see honesty rule).
6. **Add a header comment** to each `.tex` (every existing variant has one): variant name, role, source URL, and the angle. If the JD was pasted rather than a URL, write `% Source: pasted JD (no URL)`. Example:
   ```
   % Variant: Cupla -- Full Stack Engineer contract (part time).
   % Source: <job URL, or "pasted JD (no URL)">
   % Angle: lead with Go + AWS + platform reliability; honest on native mobile.
   ```
7. **Verify** (see below). **Do not commit or push unless the user asks.**

## Candidate fact sheet (fixed — reuse verbatim, do not fabricate)
Identity / contact (note: use the resume email, NOT the session/IDEXX email):
- Jonathan Xu · `jonathanilc@hotmail.com` · (+64) 21-026-24525
- LinkedIn `jonoxu` <https://www.linkedin.com/in/jonathan-x-4aba55115> · GitHub <https://github.com/Jonathanilc>
- Auckland, New Zealand · **full NZ working rights** · open to contract/remote
- Languages: English (fluent), Mandarin (native) · 10+ years experience

Education & certs:
- Unitec Institute of Technology — Bachelor of Computing Systems, 2016–2018
- AWS Certified Solutions Architect – Professional · Professional Scrum Master I (PSM I)

Experience (fixed timeline & employers):
- **IDEXX**, Auckland — 2022–Present
  - Senior SWE, **VetSoft Platform Team** (2025–Present): platform engineering — builds **VetSoft Deploy (VSD)**, an internal developer platform that ships a service from Git repo to running on AWS. Spans a **Go** CLI (`vetsoft-cli`, distributed as a Homebrew cask), a webhook API (Go), **Helm** charts, a **Terraform** module, and reusable **GitHub Actions** workflows; provisions per-service **OIDC IAM** roles + **ECR** repos via Terraform; deploys to **Kubernetes (EKS)** via Helm + **ArgoCD** GitOps, with **Datadog** observability. Authored the VSD ecosystem guide. Also leads the **Go** billing platform refactor to vertical-slice architecture with an OpenAPI-driven REST API layer.
  - Senior SWE, **VetSoft Platform Team** (2024–2025): designed/built high-volume **Go** billing pipeline aggregating & reconciling data from **5k+ sites and 9k hospitals**, syncing to **SAP** for monthly invoicing; built the React/Tailwind/Vite self-service app for the billing team; owned SAP integration; SQL relational modelling.
  - Senior SWE, Vet Radar Team (2022–2024): full-stack JS — **Node.js/Express** services on **ECS (Fargate)**, **React** (Context API) client on **S3**; AWS IaC with **Terraform**; **Docker**.
- **Moustache Republic**, Auckland — 2018–2022
  - Senior SWE (2020–2022): e-commerce on Shopify/BigCommerce; Shopify↔stock/ERP integrations; micro-frontends; mentoring; tech docs.
  - SWE / DevOps Engineer (2018–2020): e-commerce; CI/CD automation; reusable components; unit tests.

Real skill inventory (draw from these — reorder to fit the JD):
- Frontend: React, Angular, JavaScript, TypeScript, HTML, CSS, Tailwind
- Backend: Golang, Node.js, Python, Flask, C#, .NET Core, RESTful APIs, GraphQL
- Data: SQL/PostgreSQL relational modelling, large-scale pipelines, aggregation & reconciliation, SAP integration
- Cloud/AWS: ECS/Fargate, S3, VPC, networking are hands-on; broader services (Lambda, SQS, RDS, etc.) are Solutions Architect – Professional breadth, not all hands-on — frame accordingly
- DevOps/CI-CD: Docker, Kubernetes, Terraform, GitHub Actions, GitLab CI, Git
- Architecture: microservices, clean/vertical-slice architecture, OpenAPI contracts, cloud-native
- Practices: SOLID, design patterns, TDD/unit testing, Agile, mentoring & code review

## Honesty rule (do not skip)
Tailor by **reordering and reframing real experience**, never by inventing it. Known gaps to NOT fabricate:
- No hands-on **native mobile** (Kotlin/Swift).
- Not demonstrated hands-on: **Redis/Elasticache**, **Pulumi/CDK**, observability stacks **other than Datadog** (**Grafana/Prometheus/Loki/Tempo/Posthog**). NOW hands-on via the VetSoft Platform role: **Datadog** (observability), **ArgoCD** (GitOps), **Helm**, **Kubernetes/EKS**, **ECR**, **OIDC/IAM** — these are no longer gaps.
- Frame these as transferable/adoptable, not as held experience: "Terraform (comfortable adopting Pulumi/CDK)", "operational visibility / monitoring" rather than naming tools he hasn't used. When a JD's core requirement is a real gap, name it plainly in the cover letter and pivot to willingness + transferable strength.

## Naming
Kebab-case folder under `variants/`. Existing repo practice mixes **angle** names (`backend-focused`, `iot-backend`) and **company** names (`potentia-integration`) — both are fine and tracked in git. For company-specific variants you want kept **local only**, prefix with `private-` → `variants/private-*/` is gitignored.

## LaTeX gotchas
- Escape specials in body text: `&` `%` `#` `_` → `\&` `\%` `\#` `\_`. (Optional-arg brackets like `\linkedin[...]`, `\begin{itemize}[...]`, `[11pt,a4paper]` are fine.)
- **No raw `[...]` placeholders in body text** — `[Company Name]`-style brackets caused a real parse error (commit 531a829). Replace every placeholder with concrete values when baking.
- Mirror an existing variant's preamble exactly; don't improvise package setup.

## Verify (no local xelatex on this machine)
`xelatex`/`latexmk` are usually **not installed locally** — on push, CI (`.github/workflows/build-pdf.yml`) builds each variant as its own standalone job and uploads a per-variant artifact (named after the folder, e.g. `cupla-fullstack`, containing `resume.pdf` + `coverletter.pdf`). New `variants/<name>/` folders are auto-discovered. So verify statically:
- `\begin{...}`/`\end{...}` counts balanced in each file.
- No unescaped `& % #` in **body text** (scan body only — `%`-comment lines, including those with `--`, will false-positive in a naive grep); no stray `[...]` placeholders left in body.
- If a toolchain IS present: `make variants` (or `xelatex variants/<name>/resume.tex` from repo root).

## Common mistakes
- Re-scanning the whole repo — this skill is the cache; only open an existing variant to copy structure.
- Using the session/IDEXX email instead of `jonathanilc@hotmail.com`.
- Fabricating a JD-required skill instead of framing the gap honestly.
- Forgetting the header comment, or committing/pushing without being asked.
