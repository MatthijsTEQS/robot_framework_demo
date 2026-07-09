# Testing Strategy

## Purpose

This document explains how version 1 tests the webshop and why the suite is structured the way it is.

## Scope

- UI-only
- acceptance-oriented
- happy-path focused
- fast enough for pull request feedback

## Version 1 Coverage Areas

The suite structure should stay readable at the page or feature level, similar to a lightweight POM-style organization.

## Homepage

- homepage smoke check
- catalog visible after load

## Product Discovery

- search from the main catalog view
- matching results remain visible after search

## Product Details

- open product details from a catalog card
- verify the details dialog appears

## Basket

- add a visible product to the basket
- verify the basket count changes
- verify the basket page contains an item

## Login Function

- keep login coverage in a dedicated suite
- create one fresh account through the UI
- use a generated account name in the form `testaccountHHMMSS@example.com`
- log into that newly created account in the next test
- keep the flow simple and explicit without custom data readers or external CSV data

## Structure Rules

- Test cases describe business behavior
- Resource files hold reusable actions and locators
- Selectors stay out of the suite files
- Keywords stay readable and explicit
- keep generated test data deterministic and easy to understand

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
