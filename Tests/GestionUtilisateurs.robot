*** Settings ***
Documentation    Test de gestion des utilisateurs dans OrangeHRM
Resource    Resources/UserManagement.robot
Suite Setup    Ouvrir le navigateur et se connecter
Suite Teardown    Close Browser

*** Test Cases ***
Test Ajout Utilisateur
    [Documentation]    Test d'ajout d'un nouvel utilisateur
    [Tags]    create    user_management
    Given Accéder à la page Admin
    When Créer un nouvel utilisateur
    Sleep    3s
    And Rechercher l'utilisateur créé
    Then Page Should Contain    ${NEW_USERNAME}

Test Recherche Utilisateur
    [Documentation]    Test de recherche d'un utilisateur existant
    [Tags]    read    user_management
    Given Accéder à la page Admin
    When Rechercher l'utilisateur créé
    Then Page Should Contain    ${NEW_USERNAME}
    And Element Should Be Visible    xpath=//div[text()='${NEW_USERNAME}']

Test Modification Utilisateur
    [Documentation]    Test de modification du statut d'un utilisateur
    [Tags]    update    user_management
    Given Accéder à la page Admin
    When Rechercher l'utilisateur créé
    And Modifier l'utilisateur
    Sleep    3s
    And Rechercher l'utilisateur créé
    Then Page Should Contain    Disabled

Test Suppression Utilisateur
    [Documentation]    Test de suppression d'un utilisateur
    [Tags]    delete    user_management
    Given Accéder à la page Admin
    When Rechercher l'utilisateur créé
    And Supprimer l'utilisateur
    Sleep    3s
    And Rechercher l'utilisateur créé
    Then Page Should Contain    No Records Found

Test Déconnexion
    [Documentation]    Test de déconnexion
    [Tags]    logout    user_management
    Given Se déconnecter
    Then Vérifier la page de connexion 