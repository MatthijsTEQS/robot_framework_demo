*** Settings ***
Library    Browser
Resource   ../variables/environment.resource

*** Keywords ***
Open Browser To Shop
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Context    viewport={'width': 1440, 'height': 1080}
    Set Browser Timeout    ${BROWSER_TIMEOUT}
    New Page    ${BASE_URL}

Close Browser Session
    Run Keyword And Ignore Error    Close Browser

Take Failure Screenshot
    Run Keyword If Test Failed    Take Screenshot

Handle Test Cleanup
    Take Failure Screenshot
    Close Browser Session
