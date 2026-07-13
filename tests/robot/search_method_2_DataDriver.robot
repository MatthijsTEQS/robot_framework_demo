# Search method 2: Robot Framework DataDriver.
# DataDriver creates one Robot test per row and starts a fresh browser session for each generated test.

*** Settings ***
Documentation    Search coverage for OWASP Juice Shop using Robot Framework DataDriver.
Library          DataDriver
...              file=${CURDIR}/../data/search_keywords_datadriver.csv
...              dialect=excel
...              encoding=utf_8
Resource         ${CURDIR}/../resources/juice_shop.resource
Test Setup       Open Shop Homepage
Test Teardown    Handle Test Cleanup
# For DataDriver a template is required:
Test Template    Search Row Should Match

*** Test Cases ***
Search for "${keyword}" should return ${amount_of_results} results    keyword    results
    [Documentation]    Use the DataDriver row values as the search input and expected result count.

*** Keywords ***
Search Row Should Match
    [Arguments]    ${keyword}    ${amount_of_results}
    Search Results Should Match    ${keyword}    ${amount_of_results}
