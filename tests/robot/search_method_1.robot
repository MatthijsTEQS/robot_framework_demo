*** Settings ***
Documentation    Search coverage for OWASP Juice Shop using a Python CSV reader.
Resource         ../resources/juice_shop.resource
Resource         ../resources/browser_setup.resource
Variables        ../../scripts/test_support/search_cases.py
Test Setup       Open Shop Homepage
Test Teardown    Handle Test Cleanup

*** Test Cases ***
Search Keywords From Csv With Python Reader
    [Documentation]    Verify that every search row from the CSV produces the expected catalog result.
    FOR    ${case}    IN    @{SEARCH_CASES}
        Run Keyword And Continue On Failure    Search Results Should Match    ${case}[keyword]    ${case}[amount_of_results]
    END
