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
Search for "${keyword}" should return ${amount_of_results} results
    [Documentation]    Fresh browser session for every CSV Row. Verify that every search row from the CSV produces the expected catalog result.
    # placeholder 0 supplies the two arguments required by the template keyword: Test Template, Search Row Should Match.
    # placeholder = keyword, 0 = amount_of_results
    placeholder    0

*** Keywords ***
Search Row Should Match
    [Arguments]    ${keyword}    ${amount_of_results}
    Search Results Should Match    ${keyword}    ${amount_of_results}
