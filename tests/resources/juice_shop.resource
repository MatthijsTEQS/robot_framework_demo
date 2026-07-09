*** Settings ***
Library    Browser
Library    Collections
Resource   browser_setup.resource

*** Variables ***
${CATALOG_CARD_LOCATOR}             css=mat-card
${FIRST_CATALOG_CARD_LOCATOR}       css=mat-card >> nth=0
${SEARCH_TOGGLE_LOCATOR}            css=button[aria-label*="search"], button[mattooltip*="Search"], mat-icon[fonticon="search"], app-mat-search-bar[aria-label*="search"]
${SEARCH_INPUT_LOCATOR}             css=app-mat-search-bar input, input[aria-label*="search" i], input[placeholder*="Search" i], input[type="search"]
${PRODUCT_IMAGE_LOCATOR}            css=mat-card img
${FIRST_PRODUCT_IMAGE_LOCATOR}      css=mat-card img >> nth=0
${PRODUCT_NAME_LOCATOR}             css=mat-card .item-name, mat-card-title
${ADD_TO_BASKET_LOCATOR}            css=button[aria-label*="Add to Basket"], button[mattooltip*="Add to Basket"]
${FIRST_ADD_TO_BASKET_LOCATOR}      css=button[aria-label*="Add to Basket"], button[mattooltip*="Add to Basket"] >> nth=0
${BASKET_BUTTON_LOCATOR}            css=button[aria-label*="shopping cart"], button[mattooltip*="Show the shopping cart"]
${BASKET_ITEM_ROW_LOCATOR}          css=mat-row, tr.mat-mdc-row, .basket-item
${PRODUCT_DETAILS_DIALOG_LOCATOR}   css=mat-dialog-container
${PRODUCT_DETAILS_CLOSE_LOCATOR}    css=mat-dialog-container button[aria-label*="Close"], mat-dialog-container button[mat-dialog-close]

*** Keywords ***
Open Shop Homepage
    Open Browser To Shop
    Dismiss Startup Dialogs
    Wait Until Shop Catalog Loads

Wait Until Shop Catalog Loads
    Wait For Elements State    ${FIRST_CATALOG_CARD_LOCATOR}    visible    ${BROWSER_TIMEOUT}

Dismiss Startup Dialogs
    Click If Visible    text=Dismiss
    Click If Visible    text=Me want it!

Search For Product
    [Arguments]    ${search_term}
    Ensure Search Input Is Visible
    Clear Text    ${SEARCH_INPUT_LOCATOR}
    Fill Text    ${SEARCH_INPUT_LOCATOR}    ${search_term}
    Wait For Elements State    ${FIRST_CATALOG_CARD_LOCATOR}    visible    ${BROWSER_TIMEOUT}

Ensure Search Input Is Visible
    ${search_count}=    Get Element Count    ${SEARCH_INPUT_LOCATOR}
    IF    ${search_count} == 0
        Click If Visible    ${SEARCH_TOGGLE_LOCATOR}
    END
    Wait For Elements State    ${SEARCH_INPUT_LOCATOR}    visible    ${BROWSER_TIMEOUT}

Open First Product Details
    Wait For Elements State    ${FIRST_PRODUCT_IMAGE_LOCATOR}    visible    ${BROWSER_TIMEOUT}
    Click    ${FIRST_PRODUCT_IMAGE_LOCATOR}
    Wait For Elements State    ${PRODUCT_DETAILS_DIALOG_LOCATOR}    visible    ${BROWSER_TIMEOUT}

Close Product Details
    Click If Visible    ${PRODUCT_DETAILS_CLOSE_LOCATOR}

Add First Visible Product To Basket
    Wait For Elements State    ${FIRST_ADD_TO_BASKET_LOCATOR}    visible    ${BROWSER_TIMEOUT}
    ${before}=    Read Basket Count
    Click    ${FIRST_ADD_TO_BASKET_LOCATOR}
    Wait Until Keyword Succeeds    10x    300ms    Basket Count Should Be Greater Than    ${before}

Open Basket
    Click    ${BASKET_BUTTON_LOCATOR}
    Wait For Elements State    ${BASKET_ITEM_ROW_LOCATOR}    visible    ${BROWSER_TIMEOUT}

Read Basket Count
    ${count_text}=    Get Text    ${BASKET_BUTTON_LOCATOR}
    ${numbers}=    Evaluate    __import__("re").findall(r"\\d+", """${count_text}""")
    IF    ${numbers}
        RETURN    ${numbers}[-1]
    END
    RETURN    0

Basket Count Should Be Greater Than
    [Arguments]    ${baseline}
    ${current}=    Read Basket Count
    ${current_int}=    Convert To Integer    ${current}
    ${baseline_int}=    Convert To Integer    ${baseline}
    Should Be True    ${current_int} > ${baseline_int}

Basket Should Contain At Least One Item
    ${rows}=    Get Element Count    ${BASKET_ITEM_ROW_LOCATOR}
    Should Be True    ${rows} >= 1

Catalog Should Show Products
    ${cards}=    Get Element Count    ${CATALOG_CARD_LOCATOR}
    Should Be True    ${cards} >= 1

Details Dialog Should Be Visible
    Wait For Elements State    ${PRODUCT_DETAILS_DIALOG_LOCATOR}    visible    ${BROWSER_TIMEOUT}

Click If Visible
    [Arguments]    ${locator}
    ${is_visible}=    Run Keyword And Return Status
    ...    Wait For Elements State    ${locator}    visible    1s
    IF    ${is_visible}
        Click With Options    ${locator}    force=True
    END
