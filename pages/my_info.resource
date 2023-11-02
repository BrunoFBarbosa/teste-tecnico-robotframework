*** Settings ***
Library    Browser
Library    FakerLibrary
Library    DateTime
Library    String

*** Variables ***

${FIRST_NAME}          css=[name='firstName']
${MIDDLE_NAME}         css=[name='middleName']
${LAST_NAME}           css=[name='lastName']
${FORM_SECTION}        xpath=//label[normalize-space()="$$"]//ancestor::div[contains(@class, "oxd-input-field-bottom-space")]
${FORM_INPUT}          ${FORM_SECTION}//input
${DROPDOWN_FORM}       ${FORM_SECTION}//div[contains(@class, "oxd-select-text-input")]
${SMOKER}              ${FORM_SECTION}//i
${DROPDOWN_LIST}       xpath=//div[@role="option"]
${ADD_ATTACHMENT}      xpath=//button[normalize-space()="Add"]
${FILE_INPUT}          css=[type='file']
${SECTION_SAVE_BTN}    xpath=//h6[contains(normalize-space(), "$$")]//parent::div//button[@type='submit']
${SUCCESS_TOAST}       css=.oxd-toast-content--success
${LOGIN_URL}           https://opensource-demo.orangehrmlive.com/web/index.php/auth/login

*** Keywords ***
Preencher Campos Com Dados Aleatorios

    ${NOME}                 FakerLibrary.First Name
    ${NOME_MEIO}            FakerLibrary.First Name
    ${SOBRENOME}            FakerLibrary.Last Name
    ${APELIDO}              FakerLibrary.First Name
    ${ID_FUNC}              FakerLibrary.Random Number
    ${ID_SEG}               FakerLibrary.Random Number
    ${CARTEIRA}             FakerLibrary.Random Number
    ${CARTEIRA_EXPIRA}      FakerLibrary.Future Date    +5y
    ${NUMERO_SSN}           FakerLibrary.Ssn
    ${NUMERO_SIN}           FakerLibrary.Random Number
    ${CARTEIRA}             FakerLibrary.Random Number
    ${NASCIMENTO}           FakerLibrary.Date Of Birth
    ${MILITAR}              FakerLibrary.Random Number
    
    Wait Until Network Is Idle
    
    Preencher Primeiro Nome                ${NOME}
    Preencher Nome Do Meio                 ${NOME_MEIO}
    Preencher Sobrenome                    ${SOBRENOME}
    Preencher Formulario    Nickname       ${APELIDO}
    Preencher Formulario    Employee Id    ${ID_FUNC}
    Preencher Formulario    Other Id       ${ID_SEG}
    Preencher Formulario    Driver's License Number    ${CARTEIRA}
    Preencher Formulario    License Expiry Date        ${CARTEIRA_EXPIRA}
    Preencher Formulario    SSN Number                 ${NUMERO_SSN}
    Preencher Formulario    SIN Number                 ${NUMERO_SIN}
    Preencher Formulario    Military Service           ${MILITAR}
    Selecionar Fumante
    Preencher Formulario    Date of Birth              ${NASCIMENTO}
    Preencher Dropdown      Nationality
    Preencher Dropdown      Marital Status
    Preencher Dropdown      Blood Type



Preencher Primeiro Nome
    [Arguments]    ${nome}

    Fill Text         ${FIRST_NAME}         ${nome}

Preencher Nome Do Meio
    [Arguments]    ${nome}

    Fill Text         ${MIDDLE_NAME}         ${nome}

Preencher Sobrenome
    [Arguments]    ${nome}

    Fill Text         ${LAST_NAME}         ${nome}

Preencher Formulario
    [Arguments]    ${input}    ${texto}

    ${element}=    Replace String    ${FORM_INPUT}    $$    ${input}
    Fill Text      ${element}       ${texto}

Preencher Dropdown
    [Arguments]    ${dropdown}

    ${element}=    Replace String    ${DROPDOWN_FORM}    $$    ${dropdown}
    Click         ${element}
    
    ${options}=    Get Element Count    ${DROPDOWN_LIST}
    ${option}=    FakerLibrary.Random Int    2    ${options}
    
    Click    ${DROPDOWN_LIST}\[${option}\]


Selecionar Fumante

    ${element}=    Replace String    ${SMOKER}    $$    Smoker
    Click         ${element}

Adicionar Arquivo
    Click    ${ADD_ATTACHMENT}
    Upload File By Selector       ${FILE_INPUT}       ${CURDIR}/../files/product_image.jpg

A Mensagem De Sucesso Deve Estar Presente Ao Clicar Em Salvar Para A Seção
    [Arguments]    ${seção}
    ${element}=    Replace String    ${SECTION_SAVE_BTN}    $$    ${seção}

    Click    ${element}

    Get Text    ${SUCCESS_TOAST}    contains    Success
    Get Text    ${SUCCESS_TOAST}    contains    Successfully Saved
    Wait For Elements State    ${SUCCESS_TOAST}    hidden