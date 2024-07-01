*** Settings ***
Library     SeleniumLibrary


*** Variables ***
${OPTION_1}     value
${OPTION_2}     value


*** Test Cases ***
Demo Selenium Easy Select Dropdown List
    [Tags]    my_second_selenium
    # Step 1 : aller sur le site https://demo.seleniumeasy.com/basic-select-dropdown-demo.html 
    # Step 2 : dans la liste simple sélectionnez le jour « Monday »
    # Step 3 : dans la liste à choix multiple sélectionnez les villes « New York » et « Texas »
    # Step 4 : contrôler dans les champs de retours sur la page web les valeurs sélectionnées
