# CSV Reader, using the RPA.Tables library.
# This test case opens a fresh browser session for every row in the CSV file.

*** Settings ***
Documentation    Search coverage for OWASP Juice Shop using Robot Framework DataDriver.
Library          RPA.Tables
Library          SeleniumLibrary
Resource         ${CURDIR}/../resources/juice_shop.resource
Test Setup       Open Application
Test Teardown    Handle Test Cleanup

*** Variables ***
${CSV_FILE}           ${CURDIR}/../data/search_keywords.csv
${CREATE_URL}         ${BASE_URL}/wertpapier/neu
${MESSAGE_LOCATOR}    css=.validation-message


*** Test Cases ***
Create Securities
    ${data}=    Read Table From CSV
    ...    ${CSV_FILE}
    ...    header=${TRUE}
    ...    delimiters=;

    ${row_count}    ${column_count}=    Get Table Dimensions    ${data}

    FOR    ${index}    IN RANGE    ${row_count}
        ${row}=    Get Table Row    ${data}    ${index}

        Go To    ${BASE_URL}/wertpapier/neu

        Input Text    id=isin           ${row}[ISIN]
        Input Text    id=wkn            ${row}[WKN]
        Input Text    id=description    ${row}[Bezeichnung]
        Input Text    id=currency       ${row}[Waehrung]
        Input Text    id=validFrom      ${row}[Gueltig_ab]

        Click Button    id=save

        Wait Until Element Is Visible    ${MESSAGE_LOCATOR}    10s
        Element Text Should Be
        ...    ${MESSAGE_LOCATOR}
        ...    ${row}[Erwartete_Meldung]
    END
