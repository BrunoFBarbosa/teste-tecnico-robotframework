# Sobre O Projeto

[![ui-tests](https://github.com/BrunoFBarbosa/teste-tecnico-robotframework/actions/workflows/webtesting-workflow.yml/badge.svg)](https://github.com/BrunoFBarbosa/teste-tecnico-robotframework/actions/workflows/webtesting-workflow.yml)
[![api-tests](https://github.com/BrunoFBarbosa/teste-tecnico-robotframework/actions/workflows/api-testing-workflow.yml/badge.svg)](https://github.com/BrunoFBarbosa/teste-tecnico-robotframework/actions/workflows/api-testing-workflow.yml)

Projeto de avaliação de um teste técnico utilizando o Robot Framework. A aplicação a ser testada é o site https://opensource-demo.orangehrmlive.com/web/index.php/auth/login para testes de UI e o endpoint https://www.4devs.com.br/ferramentas_online.php para testes de API
# Cenários

## Web

```
Caso de Teste 1 – Realizar a alteração de informações do cadastro
Dado que o usuário esteja no site https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
E clicar em “My Info”
E Realizar o preenchimento do campos com dados aleatórios
E Realizar a add de um anexo 
Quando clicar em “Save” de cada etapa
Então o sistema deve apresentar a mensagem “Success – Successfully save”
```

## API

Dado a seguinte requisição ao endpoint:
```
Serviço para Gerar Pessoa
Método POST
Body /Form-data
Key=acao Value=gerar_pessoa
Key= pontuacao Value=N
Key=sexo Value=H
Key= txt_qtde Value=1
```

Validar o seguinte:
```
1° - Validar o campo Status Code (Resultado esperado deve ser 200)
2° - Validar se o campo idade consta no ResponseBody (Resultado esperado deve ser Sucesso)
3° - Validar se o valor do campo sexo do ResponseBody é igual a Masculino (Resultado esperado deve ser Sucesso)
4° - Validar se o valor do campo sexo do ResponseBody é igual a Feminino (Resultado esperado deve ser Falha)
5° - Armazenar o campo CPF do ResponseBody em uma variável nomeada CPF.
6° Verificar se o CPF é valido fazendo a chamada do serviço validar cpf do 4devs, passando como parâmetro no campo txt cpf a variável setada no passo 4. (Resultado Esperado Verdadeiro)
7° - Limpar a variável CPF.
```

## Começando

### Pre-requisitos
- Python 3.10.6
- PIP 22.2.1
- Node v19.1.0

### Instalação
1. Clonar o repo
```
git clone https://github.com/BrunoFBarbosa/teste-tecnico-robotframework.git
```
2. Ir até a pasta do projeto e instalar as dependências
```
cd robot-framework-playwright/
pip install -U -r requirements.txt
sudo npm install @playwright/test
sudo npx playwright install-deps
rfbrowser init
```

### Executando Os Testes Localmente
Os testes são executados usando o comando `robot`

Exemplos:

1. Executar todos os testes de UI dentro da pasta `tests` com um browser Chromium headless e armazenar os resultados na pasta `results`:
```
robot -d ./results -v HEADLESS:true -v BROWSER:chromium -i ui tests
```

2. Executar todos os testes de API dentro da pasta `tests` e armazenar os resultados na pasta `results`:
```
robot -d ./results -i api tests
```

### Github Actions

Esse projeto contém 2 workflows para um CI simples, um para rodar os testes relacionados a Web, e outro para API. Eles podem ser encontrados em [workflows](https://github.com/BrunoFBarbosa/teste-tecnico-robotframework/tree/main/.github/workflows)

#### 1. **webtesting-workflow.yml**

Workflow utilizado para rodar os testes de Web contra os principais browsers (Chromium, Firefox and Webkit)

#### 2. **api-testing-workflow.yml**

Workflow utilizado para rodar os testes de API

### Considerações

Ambos os testes (UI e API) estão falhando, abaixo estão os motivos:

#### Web

De acordo com a documentação, o cenário esperado era que:

```
Quando clicar em “Save” de cada etapa
Então o sistema deve apresentar a mensagem “Success – Successfully save”
```
Porém, esse não é o comportamento observado na aplicação, a mensagem `Success – Successfully save` somente é exibido quando se clica em salvar na seção de adicionar arquivos e de campos customizados. Para a seção de detalhes pessoais, a mensagem exibida é `Success – Successfully updated`.
Outro ponto notado é a frase esperada em si. Note que nela, não contém a letra `d` em `save`. O correto, neste caso, seria `Success – Successfully saved`.

#### API

A documentação não apresenta de maneira muito claro qual seria o resultado esperado neste cenário:

```
4° - Validar se o valor do campo sexo do ResponseBody é igual a Feminino (Resultado esperado deve ser Falha)
```
Foi assumido que a frase "o resultado esperado deve ser falha" significa que o teste deve falhar. Porém há outras maneiras de interpretá-la, como por exemplo, verificar que o campo sexo não é igual a "Feminino". Se a primeira hipótese for a correta, então os testes estão falhando corretamente. No entando, caso a segunda hipótese seja a correta, será necessário atualizar os testes para refletir a documentação


