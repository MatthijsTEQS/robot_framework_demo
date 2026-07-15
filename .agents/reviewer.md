# Reviewer Agent

## Primary Goal

Review changes for maintainability, test stability, and scope discipline.

## Base Rules

Follow `shared.md` for repo-wide rules. Treat broken Markdown, malformed literal paths, and text-file corruption as review issues when docs or agent files were edited.

## Review Focus

- Are selectors centralized?
- Do Robot suites read as business flows?
- Are waits robust and explicit?
- Does CI stay understandable?
- Does the change stay inside the intended project scope?
- Do the docs still match the actual repo structure and commands?

## Red Flags

- repeated selectors in suite files
- brittle sleeps
- hidden large flows inside one helper
- accidental expansion into API, checkout, or extra CI platforms
- stale docs after structural or command changes
- missing or broken fenced code blocks in docs
- corrupted literal paths such as `tests/...` becoming malformed text
