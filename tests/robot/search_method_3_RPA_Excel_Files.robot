# Search method 3: RPA.Excel.Files.
# The suite reads the workbook into memory and keeps one browser session open while it iterates through the rows.

*** Settings ***
Documentation    Search coverage for OWASP Juice Shop using RPA.Excel.Files.
Library          Collections
Library          RPA.Excel.Files
Resource         ${CURDIR}/../resources/juice_shop.resource
Test Setup       Open Shop Homepage
Test Teardown    Handle Test Cleanup

*** Variables ***
${SEARCH_EXCEL_FILE}           ${CURDIR}/../data/search_keywords.xlsx
${SEARCH_WORKSHEET_NAME}       SearchCases

*** Test Cases ***
Search Keywords From Excel With RPA Excel Files
    [Documentation]    Verify that each workbook row produces the expected search result.
    ${rows}=    Load Search Rows From Excel
    FOR    ${row}    IN    @{rows}
        ${input}=    Get From Dictionary    ${row}    Input
        ${normalized_input}=    Normalize Search Input    ${input}
        ${expectation}=    Get From Dictionary    ${row}    Expectation
        Run Keyword And Continue On Failure    Search Results Should Match    ${normalized_input}    ${expectation}
    END

*** Keywords ***
Load Search Rows From Excel
    Open Workbook    ${SEARCH_EXCEL_FILE}
    ${rows}=    Read Worksheet    name=${SEARCH_WORKSHEET_NAME}    header=${TRUE}
    Close Workbook
    RETURN    ${rows}

Normalize Search Input
    [Arguments]    ${value}
    IF    $value is None
        RETURN    ${EMPTY}
    END
    RETURN    ${value}
