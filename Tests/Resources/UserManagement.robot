*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${URL}    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${BROWSER}    chrome
${USERNAME}    Admin
${PASSWORD}    admin123
${USER_ROLE}    ESS
${STATUS}    Enabled
${EMPLOYEE_NAME}    Timothy Lewis Amiano
${NEW_USERNAME}    Robotframework
${NEW_PASSWORD}    Admin123!@#

*** Keywords ***
Ouvrir le navigateur et se connecter
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Wait Until Element Is Visible    name=username    10s
    Input Text    name=username    ${USERNAME}
    Input Text    name=password    ${PASSWORD}
    Click Button    xpath=//button[@type='submit']
    Sleep    2s

Accéder à la page Admin
    Wait Until Element Is Visible    xpath=//a[contains(@href, '/admin/viewAdminModule')]    10s
    Click Element    xpath=//a[contains(@href, '/admin/viewAdminModule')]
    Sleep    2s

Créer un nouvel utilisateur
    Wait Until Element Is Visible    xpath=//button[normalize-space()='Add']    10s
    Click Button    xpath=//button[normalize-space()='Add']
    Sleep    2s
    
    # Sélection du rôle utilisateur
    Wait Until Element Is Visible    xpath=//label[normalize-space()='User Role']/../..//div[contains(@class, 'oxd-select-text')]    10s
    Click Element    xpath=//label[normalize-space()='User Role']/../..//div[contains(@class, 'oxd-select-text')]
    Sleep    1s
    Click Element    xpath=//div[@role='listbox']//span[text()='${USER_ROLE}']
    
    # Saisie du nom de l'employé
    Wait Until Element Is Visible    xpath=//input[@placeholder='Type for hints...']    10s
    Input Text    xpath=//input[@placeholder='Type for hints...']    ${EMPLOYEE_NAME}
    Sleep    2s
    Wait Until Element Is Visible    xpath=//div[@role='listbox']//div[@role='option']    10s
    Click Element    xpath=//div[@role='listbox']//div[@role='option']
    
    # Sélection du statut
    Wait Until Element Is Visible    xpath=//label[normalize-space()='Status']/../..//div[contains(@class, 'oxd-select-text')]    10s
    Click Element    xpath=//label[normalize-space()='Status']/../..//div[contains(@class, 'oxd-select-text')]
    Sleep    1s
    Click Element    xpath=//div[@role='listbox']//span[text()='${STATUS}']
    
    # Saisie du nom d'utilisateur
    Wait Until Element Is Visible    xpath=//label[normalize-space()='Username']/../..//input    10s
    Input Text    xpath=//label[normalize-space()='Username']/../..//input    ${NEW_USERNAME}
    
    # Saisie du mot de passe
    Wait Until Element Is Visible    xpath=//label[normalize-space()='Password']/../..//input    10s
    Input Text    xpath=//label[normalize-space()='Password']/../..//input    ${NEW_PASSWORD}
    
    # Confirmation du mot de passe
    Wait Until Element Is Visible    xpath=//label[normalize-space()='Confirm Password']/../..//input    10s
    Input Text    xpath=//label[normalize-space()='Confirm Password']/../..//input    ${NEW_PASSWORD}
    
    # Sauvegarde
    Click Button    xpath=//button[normalize-space()='Save']
    Sleep    2s

Rechercher l'utilisateur créé
    Wait Until Element Is Visible    xpath=//label[normalize-space()='Username']/../..//input    10s
    Input Text    xpath=//label[normalize-space()='Username']/../..//input    ${NEW_USERNAME}
    Wait Until Element Is Visible    xpath=//button[@type='submit']    10s
    Click Element    xpath=//button[@type='submit']
    Sleep    2s

Modifier l'utilisateur
    Wait Until Element Is Visible    xpath=//div[text()='${NEW_USERNAME}']/../..//i[contains(@class, 'bi-pencil-fill')]    10s
    Click Element    xpath=//div[text()='${NEW_USERNAME}']/../..//i[contains(@class, 'bi-pencil-fill')]
    Sleep    2s
    
    # Modification du statut
    Wait Until Element Is Visible    xpath=//label[normalize-space()='Status']/../..//div[contains(@class, 'oxd-select-text')]    10s
    Click Element    xpath=//label[normalize-space()='Status']/../..//div[contains(@class, 'oxd-select-text')]
    Sleep    1s
    Click Element    xpath=//div[@role='listbox']//span[text()='Disabled']
    
    Click Button    xpath=//button[normalize-space()='Save']
    Sleep    2s

Supprimer l'utilisateur
    Wait Until Element Is Visible    xpath=//div[text()='${NEW_USERNAME}']/../..//i[contains(@class, 'bi-trash')]    10s
    Click Element    xpath=//div[text()='${NEW_USERNAME}']/../..//i[contains(@class, 'bi-trash')]
    Sleep    2s
    Wait Until Element Is Visible    xpath=//div[@role='document']//button[normalize-space()='Yes, Delete']    10s
    Click Element    xpath=//div[@role='document']//button[normalize-space()='Yes, Delete']
    Sleep    3s
    Wait Until Page Contains    No Records Found    10s

Se déconnecter
    # Attendre que toute boîte de dialogue disparaisse
    Sleep    2s
    Wait Until Element Is Not Visible    xpath=//div[@role='document']    10s
    
    # Cliquer sur le menu utilisateur
    Wait Until Element Is Visible    xpath=//span[@class='oxd-userdropdown-tab']    10s
    Click Element    xpath=//span[@class='oxd-userdropdown-tab']
    Sleep    2s
    
    # Cliquer sur le lien de déconnexion
    Wait Until Element Is Visible    xpath=//ul[@class='oxd-dropdown-menu']/li[4]/a    10s
    Click Element    xpath=//ul[@class='oxd-dropdown-menu']/li[4]/a
    Sleep    2s

Vérifier la page de connexion
    Wait Until Element Is Visible    xpath=//h5[normalize-space()='Login']    10s
    Element Should Be Visible    name=username
    Element Should Be Visible    name=password 