*** Settings ***
Documentation       Search coverage for OWASP Juice Shop using a Python-backed CSV variable file.
...                 Search method 1: Python variable file plus csv.DictReader.
...                 The suite keeps one browser session open while it iterates through search_keywords.csv.

Resource            ${CURDIR}/../resources/juice_shop.resource
Variables           ${CURDIR}/../../scripts/test_support/search_cases.py

Test Setup          Open Shop Homepage
Test Teardown       Handle Test Cleanup


*** Test Cases ***
Search Keywords From CSV With Python Reader
    [Documentation]    Verify that every search_keywords.csv row produces the expected result.
    Search Every CSV Row


*** Keywords ***
Search Every CSV Row
    FOR    ${row}    IN    @{ROWS}
        Search Results Should Match    ${row}[input]    ${row}[expectation]
    END
