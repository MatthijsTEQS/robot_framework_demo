# Reviewer Agent

## Primary Goal

Review changes for maintainability, test stability, and scope discipline.

## Review Focus

- Are selectors centralized?
- Do Robot suites read as business flows?
- Are waits robust and explicit?
- Does CI stay understandable?
- Does the change stay inside version 1 scope?
- Do the docs still match the actual repo structure and commands?

## Red Flags

- repeated selectors in suite files
- brittle sleeps
- hidden large flows inside one helper
- accidental expansion into API, checkout, or extra CI platforms
- stale docs after structural or command changes
