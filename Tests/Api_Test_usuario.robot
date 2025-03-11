*** Settings ***

Resource    ../Resources/Api_Test_usuario.resource

*** Variables ***

*** Test Cases ***
Cenario 1: Cadastrar Usuario na Serverest
    Criar um novo Usuario na Serverest
    Cadastrar o Usuario na Serverest  email=${EMAIL_TESTE}  status_code_desejado=201
    Conferir se o Usuario foi Cadastrado corretamente
Cenario 2: Cadastrar um usuarios existente
     Criar um novo Usuario na Serverest
     Cadastrar o Usuario na Serverest  email=${EMAIL_TESTE}  status_code_desejado=201
     Repetir o Cadastro do usuario
     Verificar se a API não permitiu o Cadastro repetido  

     