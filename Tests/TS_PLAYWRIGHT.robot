*** Settings ***
Library     Browser


*** Variables ***
${LOGIN}    value
${PWD}      value


*** Test Cases ***
My Fisrt Playwright Robot Test
    [Tags]    my_first_playwright
    # Step 1 : aller sur le site https://www.saucedemo.com/
    # Step 2 : se connecter au compte standard_user
    # Step 3 : vider le panier (avec le bouton "Remove", s’il est visibile sur la grille produit
    # Step 4 : ajouter la produit "Sauce Labs Backpack" au panier
    # Step 5 : aller dans le panier
    # Step 6 : vérifier que le produit "Sauce Labs Backpack" est présent dans le panier
    # Step 7 : continuer le processus de commande
    # Step 8 : vérifier que la commande est validée grâce au message "Thank you for your order"
