# Search method 1: Python variable file plus csv.DictReader.
# The suite keeps one browser session open while it iterates through search_keywords.csv.

*** Settings ***
Documentation    Search coverage for OWASP Juice Shop using a Python-backed CSV variable file.
Resource         ${CURDIR}/../resources/juice_shop.resource
Variables        ${CURDIR}/../../scripts/test_support/search_cases.py
Test Setup       Open Shop Homepage
Test Teardown    Handle Test Cleanup

*** Test Cases ***
Search Keywords From CSV With Python Reader
    [Documentation]    Verify that each row from search_keywords.csv produces the expected search result.
    [Template]    Search Results Should Match
    FOR    ${row}    IN    @{ROWS}
        ${row}[input]    ${row}[expectation]
    END
