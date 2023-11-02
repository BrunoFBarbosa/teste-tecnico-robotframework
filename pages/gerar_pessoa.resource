*** Settings ***
Library     Collections
Library     RequestsLibrary

*** Variables ***

${ENDPOINT}     https://www.4devs.com.br/ferramentas_online.php

*** Keywords ***

Uma Sessão É Criada Para O Endpoint Gerar Pessoa
    Set Suite Variable    ${SESSION}    gerar_pessoa
    Create Session        ${SESSION}    ${ENDPOINT}

Requisicao POST Realizada Para O Endpoint Gerar Pessoa
    
    ${HEADERS}      Create Dictionary       Content-Type=application/x-www-form-urlencoded
    &{PAYLOAD}      Create Dictionary       acao=gerar_pessoa    pontuacao=N    sexo=H    txt_qtde=1

    ${RESPONSE}     POST On Session     ${SESSION}    ${ENDPOINT}     data=&{PAYLOAD}
    ...    headers=${HEADERS}

    Set Test Variable    ${RESPONSE}

Requisicao POST Realizada Para O Endpoint De Validação de CPF

    ${HEADERS}      Create Dictionary       Content-Type=application/x-www-form-urlencoded
    &{PAYLOAD}      Create Dictionary       acao=validar_cpf    txt_cpf=${RESPONSE.json()[0]["cpf"]}

    ${RESPONSE_CPF}     POST On Session     ${SESSION}    ${ENDPOINT}     data=&{PAYLOAD}
    ...    headers=${HEADERS}

    Set Test Variable    ${RESPONSE_CPF}

O Status Code Da Resposta Deve Ser
    [Arguments]    ${resposta}    ${status_code}
    Status Should Be        ${status_code}     ${resposta}

Resposta Deve Conter O Campo ${campo}
    
    Dictionary Should Contain Key    ${RESPONSE.json()[0]}    ${campo}

Resposta Deve Conter O Item
    [Arguments]    ${chave}    ${valor}        
    Dictionary Should Contain Item    ${RESPONSE.json()[0]}    ${chave}    ${valor}

Resposta Deve Conter O Texto
    [Arguments]    ${resposta}    ${texto}

    Should Contain    ${resposta.text}    ${texto}
