# Testing Strategy

## Purpose

This document explains how version 1 tests the webshop and why the suite is structured the way it is.

## Scope

- UI-only
- acceptance-oriented
- happy-path focused
- fast enough for pull request feedback

## Version 1 Journeys

The first suite should cover:

1. homepage smoke
2. product discovery
3. product details
4. add to basket
5. basket verification

## Structure Rules

- Test cases describe business behavior
- Resource files hold reusable actions and locators
- Selectors stay out of the suite files
- Keywords stay readable and explicit

## Selector Policy

- Prefer role, label, text, or stable test ids
- Use short CSS selectors when semantic hooks are missing
- Use XPath only as a fallback
- Centralize non-trivial locators in resource files

## Not In Scope Yet

- API tests
- security testing
- performance testing
- browser matrices
- checkout coverage
- Gherkin/BDD as a required layer
