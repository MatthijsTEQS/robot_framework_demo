*** Settings ***
Library    Browser
Resource   juice_shop.resource

*** Variables ***
${ACCOUNT_BUTTON_LOCATOR}          css=#navbarAccount
${LOGIN_BUTTON_LOCATOR}            css=#navbarLoginButton
${LOGOUT_BUTTON_LOCATOR}           css=#navbarLogoutButton
${EMAIL_INPUT_LOCATOR}             css=#email
${PASSWORD_INPUT_LOCATOR}          css=#password
${SUBMIT_LOGIN_LOCATOR}            css=#loginButton
${LOGIN_ERROR_LOCATOR}             text=Invalid email or password.

*** Keywords ***
Login Row Should Match Expected Result
    [Arguments]    ${email}    ${password}    ${expected_result}
    Open Login Page
    Submit Login Credentials    ${email}    ${password}
    IF    '${expected_result}' == 'success'
        Successful Login Should Be Visible
        Logout If Signed In
    ELSE IF    '${expected_result}' == 'failure'
        Failed Login Should Be Visible
    ELSE
        Fail    Unsupported expected_result value: ${expected_result}
    END

Open Login Page
    Open Shop Homepage
    Ensure Account Menu Is Open
    Click    ${LOGIN_BUTTON_LOCATOR}
    Wait For Elements State    ${EMAIL_INPUT_LOCATOR}    visible    ${BROWSER_TIMEOUT}

Submit Login Credentials
    [Arguments]    ${email}    ${password}
    Fill Text    ${EMAIL_INPUT_LOCATOR}    ${email}
    Fill Text    ${PASSWORD_INPUT_LOCATOR}    ${password}
    Click    ${SUBMIT_LOGIN_LOCATOR}

Successful Login Should Be Visible
    Wait Until Keyword Succeeds    10x    1s    Account Menu Should Show Logged In State

Failed Login Should Be Visible
    Wait For Elements State    ${LOGIN_ERROR_LOCATOR}    visible    ${BROWSER_TIMEOUT}
    Account Menu Should Show Logged Out State

Logout If Signed In
    ${logged_in}=    Run Keyword And Return Status    Account Menu Should Show Logged In State
    IF    ${logged_in}
        Click    ${LOGOUT_BUTTON_LOCATOR}
        Wait Until Keyword Succeeds    5x    1s    Account Menu Should Show Logged Out State
    END

Account Menu Should Show Logged In State
    Ensure Account Menu Is Open
    Wait For Elements State    ${LOGOUT_BUTTON_LOCATOR}    visible    ${BROWSER_TIMEOUT}
    ${login_visible}=    Run Keyword And Return Status
    ...    Wait For Elements State    ${LOGIN_BUTTON_LOCATOR}    visible    1s
    Should Be True    not ${login_visible}

Account Menu Should Show Logged Out State
    Ensure Account Menu Is Open
    Wait For Elements State    ${LOGIN_BUTTON_LOCATOR}    visible    ${BROWSER_TIMEOUT}
    ${logout_visible}=    Run Keyword And Return Status
    ...    Wait For Elements State    ${LOGOUT_BUTTON_LOCATOR}    visible    1s
    Should Be True    not ${logout_visible}

Ensure Account Menu Is Open
    ${login_visible}=    Run Keyword And Return Status
    ...    Wait For Elements State    ${LOGIN_BUTTON_LOCATOR}    visible    1s
    ${logout_visible}=    Run Keyword And Return Status
    ...    Wait For Elements State    ${LOGOUT_BUTTON_LOCATOR}    visible    1s
    IF    not ${login_visible} and not ${logout_visible}
        Click    ${ACCOUNT_BUTTON_LOCATOR}
        Wait Until Keyword Succeeds    5x    500ms    Account Menu Should Contain Actions
    END

Account Menu Should Contain Actions
    ${login_visible}=    Run Keyword And Return Status
    ...    Wait For Elements State    ${LOGIN_BUTTON_LOCATOR}    visible    1s
    ${logout_visible}=    Run Keyword And Return Status
    ...    Wait For Elements State    ${LOGOUT_BUTTON_LOCATOR}    visible    1s
    Should Be True    ${login_visible} or ${logout_visible}