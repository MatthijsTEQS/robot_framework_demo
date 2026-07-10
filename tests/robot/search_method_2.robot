*** Settings ***
Documentation    Search coverage for OWASP Juice Shop using Robot Framework DataDriver.
Library          DataDriver    file=../data/search_keywords_datadriver.csv    dialect=excel    encoding=utf_8
Resource         ../resources/juice_shop.resource
Resource         ../resources/browser_setup.resource
Test Setup       Open Shop Homepage
Test Teardown    Handle Test Cleanup
Test Template    Search Row Should Match

*** Test Cases ***
Search Template    placeholder    0

*** Keywords ***
Search Row Should Match
    [Arguments]    ${keyword}    ${amount_of_results}
    Search Results Should Match    ${keyword}    ${amount_of_results}
