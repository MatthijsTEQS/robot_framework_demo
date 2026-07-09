*** Settings ***
Documentation    CSV-driven login coverage for OWASP Juice Shop.
Library          DataDriver    file=../data/login_credentials.csv    encoding=utf-8    dialect=excel
Resource         ../resources/login.resource
Resource         ../resources/browser_setup.resource
Test Template    Execute Login Row
Test Teardown    Handle Test Cleanup

*** Test Cases ***
Login: ${email} should ${expected_result}
    [Documentation]    Verify that each credential row produces the expected login outcome.

*** Keywords ***
Execute Login Row
    [Arguments]    ${email}    ${password}    ${expected_result}
    Login Row Should Match Expected Result    ${email}    ${password}    ${expected_result}