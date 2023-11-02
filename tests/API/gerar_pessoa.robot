*** Settings ***
Resource    ../../pages/gerar_pessoa.resource

Suite Setup    Given Uma Sessão É Criada Para O Endpoint Gerar Pessoa

*** Test Cases ***

Caso de Teste 1 - Endpoint Gerar Pessoa Deve Retornar Valores Esperados
    [Tags]    api    gerar_pessoa
    When Requisicao POST Realizada Para O Endpoint Gerar Pessoa
    Then O Status Code Da Resposta Deve Ser     ${RESPONSE}    200
    And Resposta Deve Conter O Campo idade
    And Resposta Deve Conter O Item    sexo    Masculino
    And Resposta Deve Conter O Item    sexo    Feminino

Caso de Teste 2 - Endpoint Gerar Pessoa Deve Retornar Um CPF Válido
    [Tags]    api    gerar_pessoa    cpf
    [Setup]    Requisicao POST Realizada Para O Endpoint Gerar Pessoa
    When Requisicao POST Realizada Para O Endpoint De Validação de CPF
    Then O Status Code Da Resposta Deve Ser     ${RESPONSE_CPF}    200
    And Resposta Deve Conter O Texto    ${RESPONSE_CPF}    Verdadeiro
    
