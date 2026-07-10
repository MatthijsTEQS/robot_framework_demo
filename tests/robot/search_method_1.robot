*** Settings ***
Documentation    Search coverage for OWASP Juice Shop using a Python CSV reader.
Resource         ${CURDIR}/../resources/juice_shop.resource
Variables        ${CURDIR}/../../scripts/test_support/search_cases.py
Test Setup       Open Shop Homepage
Test Teardown    Handle Test Cleanup

*** Test Cases ***
Search Keywords From CSV With Python Reader
    [Documentation]    Reuse browser session for every CSV Row. Verify that every search row from the CSV produces the expected catalog result.
    [Template]    Search Results Should Match
    FOR    ${case}    IN    @{SEARCH_CASES}
        ${case}[keyword]    ${case}[amount_of_results]
    END
