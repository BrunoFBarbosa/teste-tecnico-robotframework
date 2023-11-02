*** Settings ***
Resource    ../../pages/login.resource
Resource    ../../pages/left_menu.resource
Resource    ../../pages/my_info.resource

*** Test Cases ***

Caso de Teste 1 - Realizar a alteração de informações do cadastro
    [Tags]    ui    cadastro
    Given O Usuario Esteja No Site
    And Clicar No Menu     My Info
    And Preencher Campos Com Dados Aleatorios
    And Adicionar Arquivo
    Then A Mensagem De Sucesso Deve Estar Presente Ao Clicar Em Salvar Para A Seção   Personal Details
    And A Mensagem De Sucesso Deve Estar Presente Ao Clicar Em Salvar Para A Seção    Custom Fields
    And A Mensagem De Sucesso Deve Estar Presente Ao Clicar Em Salvar Para A Seção    Add Attachment
