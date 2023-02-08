*** Settings ***
Library    SeleniumLibrary
Library    XML

*** Variables ***
${URL}                         https://www.amazon.com.br/
${MENU_ELETRONICOS}            //a[@href='/Eletronicos-e-Tecnologia/b/?ie=UTF8&node=16209062011&ref_=nav_cs_electronics'][contains(.,'Eletrônicos')]
${HEADER_ELETRONICOS}          //h1[contains(.,'Eletrônicos e Tecnologia')]
# ${TEXTO_HEADER_ELETRONICOS}    Eletrônicos e Tecnologia

*** Keywords ***
Abrir o navegador
    Open Browser    browser=chrome
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
    Wait Until Element Is Visible    locator=//span[@class='nav-line-1'][contains(.,'Devoluções')]
    Close Browser

Acessar a home page do site Amazon.com.br
    Go To                            url=${URL}
    Wait Until Element Is Visible    locator=${MENU_ELETRONICOS}

Entrar no menu "Eletrônicos"
    Click Element    locator=${MENU_ELETRONICOS}

Verificar se aparece a frase "${FRASE}"
    Wait Until Page Contains    text=${FRASE}
    Wait Until Element Is Visible    locator=${HEADER_ELETRONICOS}

Verificar se o título da página fica "${TITULO}"
    Title Should Be    title=${TITULO}

Verificar se aparece a categoria "${NOME_CATEGORIA}"
    Element Should Be Visible    locator=//a[contains(@aria-label,'${NOME_CATEGORIA}')]
    Element Should Be Visible    locator=//img[contains(@alt,'${NOME_CATEGORIA}')]

Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Input Text    locator=twotabsearchtextbox    text=${PRODUTO}

Clicar no botão de pesquisa
    Click Element    locator=nav-search-submit-button

Verificar se o resultado da pesquisa está listando o produto "${PRODUTO}"
    Wait Until Element Is Visible    locator=(//span[contains(.,'Xbox Series S')])[10]

Clicar no produto "${PRODUTO}"
    Click Image    locator=//img[@alt='Xbox Series S']

Adicionar o produto "${PRODUTO}" no carrinho
    Wait Until Element Is Visible    locator=//span[@class='a-size-large product-title-word-break'][contains(.,'${PRODUTO}')]
    Click Element    locator=//input[contains(@name,'submit.add-to-cart')]

Verificar se o produto "${PRODUTO}" foi adicionado com sucesso
    Wait Until Element Is Visible    locator=//span[@class='a-size-medium-plus a-color-base sw-atc-text a-text-bold'][contains(.,'Adicionado ao carrinho')]  

Acessar o carrinho de compras
    Click Element    locator=//a[contains(@aria-label,'1 item no carrinho')]

Remover o produto do carrinho
    Wait Until Element Is Visible    locator=//span[@class='a-truncate-cut'][contains(.,'Xbox Series S')]
    Click Element    locator=//input[contains(@aria-label,'Excluir Xbox Series S')]

Verificar se o carrinho fica vazio
    Wait Until Element Is Visible    locator=//h1[@class='a-spacing-mini a-spacing-top-base'][contains(.,'Seu carrinho de compras da Amazon está vazio.')]
