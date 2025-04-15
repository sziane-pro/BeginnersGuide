*** Settings ***
Resource    Resources/UserManagement.robot
Suite Setup    Ouvrir le navigateur et se connecter
Suite Teardown    Close Browser

*** Test Cases ***
Test d'ajout d'utilisateur
    Accéder à la gestion des utilisateurs
    ${random_username}=    Generate Random String    8    [LETTERS]
    Ajouter un nouvel utilisateur    ESS    Alice Duval    ${random_username}    Enabled    Password123!
    Page Should Contain    Successfully Saved

Test de recherche d'utilisateur
    Accéder à la gestion des utilisateurs
    Rechercher un utilisateur    Admin
    Page Should Contain    Admin

Test de modification d'utilisateur
    Accéder à la gestion des utilisateurs
    Modifier un utilisateur    Admin    Disabled
    Page Should Contain    Successfully Updated

Test de suppression d'utilisateur
    [Tags]    delete
    Accéder à la gestion des utilisateurs
    ${random_username}=    Generate Random String    8    [LETTERS]
    Ajouter un nouvel utilisateur    ESS    Bob Martin    ${random_username}    Enabled    Password123!
    Supprimer un utilisateur    ${random_username}
    Page Should Contain    Successfully Deleted 