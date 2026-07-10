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
${KEYWORD_COLUMN}              keyword
${RESULT_COUNT_COLUMN}         amount_of_results

*** Test Cases ***
Search Keywords From Excel With RPA Excel Files
    [Documentation]    Reuse browser session for every Excel Row. Verify that every search row from the workbook produces the expected catalog result.
    ${search_cases}=    Load Search Cases From Excel
    FOR    ${case}    IN    @{search_cases}
        ${keyword}=    Get From Dictionary    ${case}    ${KEYWORD_COLUMN}
        ${amount_of_results}=    Get From Dictionary    ${case}    ${RESULT_COUNT_COLUMN}
        Run Keyword And Continue On Failure    Search Results Should Match    ${keyword}    ${amount_of_results}
    END

*** Keywords ***
Load Search Cases From Excel
    Open Workbook    ${SEARCH_EXCEL_FILE}
    ${rows}=    Read Worksheet    name=${SEARCH_WORKSHEET_NAME}    header=${TRUE}
    Close Workbook
    RETURN    ${rows}
