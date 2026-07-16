*** Settings ***
Resource    C:/Ontwikkel/robot_framework_demo/tests/resources/juice_shop.resource
Resource    C:/Ontwikkel/robot_framework_demo/tests/resources/browser_setup.resource
Test Teardown    Handle Test Cleanup

*** Variables ***
${WHITESPACE_QUERY}        ${SPACE}${SPACE}${SPACE}

*** Test Cases ***
Debug Whitespace Search
    Open Shop Homepage
    Ensure Search Input Is Ready
    Type Text    ${SEARCH_INPUT_LOCATOR}    ${WHITESPACE_QUERY}
    Press Keys    ${SEARCH_INPUT_LOCATOR}    Enter
    Sleep    1s
    ${value}=    Get Property    ${SEARCH_INPUT_LOCATOR}    value
    ${cards}=    Get Element Count    ${CATALOG_CARD_LOCATOR}
    ${body}=    Evaluate JavaScript    css=body
    ...    (body) => body.innerText
    Log To Console    SPACE_VALUE=${value}
    Log To Console    SPACE_CARDS=${cards}
    Log To Console    SPACE_BODY=${body}
