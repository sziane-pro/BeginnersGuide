*** Settings ***
Library         ${CURDIR}/../../libs/Common.py

# Dans notre launch.json,
# on a paramétré de lancer que les tests tagué tnr
Test Tags       tnr


*** Variables ***
@{LIST1}    Un    Deux    Trois    Quatre    Cinq    six    sept
@{LIST2}    Un    Deux    Trois    Quatro    Cinq    N/A    sept


*** Test Cases ***
Test01 Log
    Log To Console    Hello Word

Test02 Log
    Log Bold Welcome

Test03 Log
    Log Welcome Name    Julien
    Log Welcome Name    Julie
    Log Bold And Color    WELCOME${SPACE*4}%{USERNAME}
    Log Bold And Color    WELCOME %{USERNAME}    blue

Test11 Division
    ${resultat}    Division    10    2
    Should Be Equal As Numbers    5    ${resultat}

Test12 Division
    ${resultat}    Division    10    3
    Should Be Equal As Numbers    3    ${resultat}

Test13 Division
    ${resultat}    Division    10    2
    Run Keyword And Continue On Failure    Should Be Equal As Numbers    5    ${resultat}
    ${resultat}    Division    10    3
    Run Keyword And Continue On Failure    Should Be Equal As Numbers    3    ${resultat}
    ${resultat}    Division    10    3
    Run Keyword And Continue On Failure    Should Be Equal As Numbers    5    ${resultat}
    ${resultat}    Division    27    9
    Run Keyword And Continue On Failure    Should Be Equal As Numbers    3    ${resultat}

Test20 Boucle Methode1
    FOR    ${el1}    ${el2}    IN ZIP    ${LIST1}    ${LIST2}
        IF    '${el1}' == 'N/A' or '${el2}' == 'N/A'    BREAK
        Run Keyword And Continue On Failure    Should Be Equal As Strings    ${el1}    ${el2}
    END

Test20 Boucle Methode2
    ${length}    Get Length    ${LIST1}
    FOR    ${index}    IN RANGE    0    ${length}
        IF    '${LIST1}[${index}]' == 'N/A' or '${LIST2}[${index}]' == 'N/A'
            BREAK
        END
        Run Keyword And Continue On Failure    Should Be Equal As Strings    ${LIST1}[${index}]    ${LIST2}[${index}]
    END

Test20 Boucle Methode3
    FOR    ${INDEX}    ${VALUE1}    IN ENUMERATE    @{LIST1}
        Log To Console    \nindex=${INDEX}
        ${VALUE2}    Set Variable    ${LIST2}[${INDEX}]
        Log To Console    value1=${VALUE1} value2=${VALUE2}
        IF    '${VALUE1}' == 'N/A' or '${VALUE2}' == 'N/A'    BREAK
        Run Keyword And Continue On Failure    Should Be Equal    ${VALUE1}    ${VALUE2}
    END

Test30 Square
    ${my_result}    Square    5
    Should Be Equal As Numbers    25    ${my_result}

Test Somme
    ${result}    Common.Somme Plusieurs Nombres Bis    1    5    6    9    10
    Should Be Equal As Numbers    ${31}    ${result}


*** Keywords ***
Log Bold Welcome
    Log    <b>Welcome %{USERNAME}<b>    html=True

Log Welcome Name
    [Arguments]    ${name}
    Log    Bonjour ${name}

Log Bold And Color
    [Arguments]    ${message}    ${color}=red
    Log    <b style='color:${color};'>${message}</b>    html=True

Division
    [Arguments]    ${nombre1}    ${nombre2}
    ${result}    Evaluate    int(${nombre1}) / int(${nombre2})
    RETURN    ${result}

Square
    [Arguments]    ${number}
    ${result}    Evaluate    int(${number}) ** 2
    RETURN    ${result}
