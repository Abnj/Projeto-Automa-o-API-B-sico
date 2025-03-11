*** Settings ***
Library    RequestsLibrary
Library    String
Library    FakerLibrary
Library    Collections
 

*** Keywords ***
 Criar um novo Usuario na Serverest
    ${palavra_aleatoria}    Generate Random String    length=4  chars=[Letters]
    Set Test Variable  ${EMAIL_TESTE}    ${palavra_aleatoria}@emailteste.com
    Log To Console    ${EMAIL_TESTE}

Cadastrar o Usuario na Serverest
    [Arguments]  ${email}  ${status_code_desejado}
    ${body}    Create Dictionary    
    ...    nome=Fulano da Silva    
    ...    email=${email}    
    ...    password=1234    
    ...    administrador=true
    Log To Console    ${body}
    
    Criar sessao
    ${resposta}  POST On Session
    ...  alias=ServeRest  
    ...  url=https://serverest.dev/usuarios  
    ...  json=${body}
    ...  expected_status=${status_code_desejado}

    Log To Console    ${resposta.json()}
    Set Test Variable  ${RESPOSTA}  ${resposta.json()}

Criar sessao
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session  alias=ServeRest  url=https://serverest.dev  headers=${headers}

Conferir se o Usuario foi Cadastrado corretamente
    Log To Console  ${RESPOSTA}
    Dictionary Should Contain Item  ${RESPOSTA}  message  Cadastro realizado com sucesso
    Dictionary Should Contain Key  ${RESPOSTA}  _id

 Repetir o Cadastro do usuario
     Cadastrar o Usuario na Serverest  ${EMAIL_TESTE}  status_code_desejado=400

 Verificar se a API não permitiu o Cadastro repetido  
     Dictionary Should Contain Item  ${RESPOSTA}  message  Este email já está sendo usado


