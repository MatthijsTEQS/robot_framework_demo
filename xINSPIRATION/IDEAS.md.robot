*** Settings ***
Library    SeleniumLibrary
Library    RPA.Excel.Files
Test Teardown    Close All Browsers

*** Variables ***
${EXCEL_FILE}       ${CURDIR}${/}testdata.xlsx
${WORKSHEET}        TestData
${URL}              https://example.test
${INPUT_FIELD}      id:input-field
${SUBMIT_BUTTON}    id:submit-button
${ERROR_MESSAGE}    css:.error-message

*** Test Cases ***
Enter Nice Test Case Name Here
    ${data}=    Read From Excel
    ...    ${EXCEL_FILE}
    ...    ${WORKSHEET}

    Open Browser    ${URL}    chrome
    Input Text      ${INPUT_FIELD}    ${data}[Input]
    Click Button    ${SUBMIT_BUTTON}

    Wait Until Element Is Visible    ${ERROR_MESSAGE}    10s
    Element Text Should Be    ${ERROR_MESSAGE}    ${data}[ExpectedMessage]

*** Keywords ***
Read From Excel
    [Arguments]    ${file}    ${worksheet}

    TRY
        Open Workbook    ${file}
        ${rows}=    Read Worksheet As Table
        ...    name=${worksheet}
        ...    header=${TRUE}
    FINALLY
        Close Workbook
    END

    Should Not Be Empty    ${rows}
    RETURN    ${rows}[0]
