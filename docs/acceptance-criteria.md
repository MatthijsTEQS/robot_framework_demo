# Acceptance Criteria

## Purpose

This file keeps the project focused on user-visible outcomes rather than only code-level concerns.

## Version 1 Acceptance Themes

### Runtime

- The webshop can be started reproducibly with Docker Compose
- The documented local commands are enough to run the app and tests

### UI Coverage

## Homepage

- The homepage loads successfully
- The catalog is visible when the homepage opens

## Product Discovery

- A user can search for a product
- The catalog still shows matching results after search

## Product Details

- A user can open product details from the catalog
- The product details dialog is visible when opened

## Basket

- A user can add an item to the basket
- The basket reflects the change
- The basket contains at least one item after an add action

## Login Function

- A fresh account can be created through the UI with a timestamped `testaccountHHMMSS` name
- The next login test can sign in with that newly created account
- Successful login coverage logs out cleanly after sign-in

### CI

- The same suite runs in GitHub Actions
- Reports and screenshots are available as artifacts
