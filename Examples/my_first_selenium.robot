*** Settings ***
Library     SeleniumLibrary

*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${MESSAGE}    Lorem Ipsum
${VALUE_1}    10
${VALUE_2}    5


*** Test Cases ***
My Fisrt Selenium Robot Test
    [Tags]    my_first_selenium
    # Step 1 : aller sur le site https://demo.seleniumeasy.com/basic-first-form-demo.html
    # Step 2 : remplir le premier formulaire et vérifier le résultat
    # Step 3 : remplir le deuxième formulaire et vérifier le résultat
    # Step 4 : contrôler les deux résultats avec les retours textuels visibles sur la page web
