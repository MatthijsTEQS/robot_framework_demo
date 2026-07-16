# Excel Reader, using the RPA.Excel.Files library.
# This test case opens a fresh browser session for every row in the Excel file.

*** Settings ***
Documentation    Example flow that reads Excel rows and submits them to a page form with ids keyword, result, and save.
Library          Collections
Library          RPA.Excel.Files
Resource         ${CURDIR}/../resources/browser_setup.resource
Test Teardown    Handle Test Cleanup

*** Variables ***
${EXCEL_FILE}           ${CURDIR}/../data/search_keywords.xlsx
${WORKSHEET_NAME}              Records
${KEYWORD_COLUMN}              keyword
${RESULT_COLUMN}               result
${KEYWORD_INPUT_LOCATOR}       id=keyword
${RESULT_INPUT_LOCATOR}        id=result
${SAVE_BUTTON_LOCATOR}         id=save

*** Test Cases ***
Submit Excel Rows To Form
    [Documentation]    Open page, read each Excel row, fill the form fields, and click save once per row.
    Open Application Page
    ${records}=    Load Records From Excel
    FOR    ${record}    IN    @{records}
        Submit Record To Form    ${record}
    END

*** Keywords ***
Load Records From Excel
    Open Workbook    ${EXCEL_FILE}
    ${rows}=    Read Worksheet    name=${WORKSHEET_NAME}    header=${TRUE}
    Close Workbook
    RETURN    ${rows}

Submit Record To Form
    [Arguments]    ${record}
    ${keyword}=    Get From Dictionary    ${record}    ${KEYWORD_COLUMN}
    ${result}=    Get From Dictionary    ${record}    ${RESULT_COLUMN}
    Fill Text    ${KEYWORD_INPUT_LOCATOR}    ${keyword}
    Fill Text    ${RESULT_INPUT_LOCATOR}    ${result}
    Click    ${SAVE_BUTTON_LOCATOR}
