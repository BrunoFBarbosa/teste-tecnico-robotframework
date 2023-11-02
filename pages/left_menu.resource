*** Settings ***
Library    Browser
Library    String

*** Variables ***
${LEFT_NAV_MENU}    xpath=//span[normalize-space()="$$"]


*** Keywords ***
Clicar No Menu
    [Arguments]      ${opcao}

    ${element}=       Replace String    ${LEFT_NAV_MENU}    $$    ${opcao}
    Click             ${element}