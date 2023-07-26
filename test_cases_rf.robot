*** Settings ***
Library  SeleniumLibrary
Documentation    Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}      https://scouts-test.futbolkolektyw.pl/en
${BROWSER}        Chrome
${SIGNINBUTTON}     xpath=//*[text()= 'Sign in']
${EMAILINPUT}       xpath=//*[@id='login']
${PASSWORDINPUT}        xpath=//*[@id='password']
${PAGELOGO}     xpath=//*[@id='__next']/div[1]/main/div[3]/div[1]/div/div[1]
${SIGNOUTBUTTON}        xpath=//*[text()='Sign out']
${WRONGPASSWORDPOPUP}       xpath=//*[@id='__next']/form/div/div[1]/div[3]/span
${ADDAPLAYERPAGE}       xpath=//*[text()='Add player']
${AGEINPUT}     xpath=//input[@name='age']
${NAMEINPUT}        xpath=//input[@name='name']
${SURNAMEINPUT}     xpath=//input[@name='surname']
${MAINPOSITIONINPUT}        xpath=//input[@name='mainPosition']
${SUBMITPLAYERBUTTON}       xpath=//button[@type='submit']
${ADDPLAYERALERT}       xpath=//*[@id='9ddtuyzvez']
${ADDPLAYERHEADER}      xpath=//*[@id='__next']/div[1]/main/div[2]/form/div[1]/div/span
${NAMEREQUIREDALERT}        xpath=//*[@id='__next']/div[1]/main/div[2]/form/div[2]/div/div[2]/div/p
${SURNAMEREQUIREDALERT}     xpath=//*[@id='__next']/div[1]/main/div[2]/form/div[2]/div/div[3]/div/p
${AGEREQUIREDALERT}     xpath=//*[@id='__next']/div[1]/main/div[2]/form/div[2]/div/div[7]/div/p
${MAINPOSITIONREQUIREDALERT}        xpath=//*[@id='__next']/div[1]/main/div[2]/form/div[2]/div/div[11]/div/p
${ENGLISHOPTIONBUTTON}      xpath=//*[text()='English']
${POLISHOPTIONBUTTON}       xpath=//*[text()='Polski']
${MATCHESEDITPLAYERPAGE}        xpath=//*[text()='Matches']

*** Test Cases ***
Log in to the system
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Assert dashboard
    [Teardown]  Close Browser

Log in with wrong password
    Open login page
    Type in email
    Type in wrong password
    Click on the Submit button
    Check pop-up
    [Teardown]  Close Browser

Sign out of the system
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Assert dashboard
    Sign out
    [Teardown]  Close Browser

Add a player with age above 100
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Assert dashboard
    Assert add a player form
    Type in name
    Type in surname
    Type in main position
    Type in age
    Click Submit Player Button
    Check Add player pop-up
    [Teardown]  Close Browser

Add a player without mandatory fields
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Assert dashboard
    Assert add a player form
    Click Submit Player Button
    Click Submit Player Button
    Check Add Player Required Alert
    [Teardown]  Close Browser

Change language
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Assert dashboard
    Select Language
    [Teardown]  Close Browser

*** Keywords ***
Open login page
    Open Browser    ${LOGIN URL}      ${BROWSER}
    Title Should Be     Scouts panel - sign in
Type in email
    Input Text      ${EMAILINPUT}   user10@getnada.com
Type in password
    Input Password    ${PASSWORDINPUT}  Test-1234
Type in wrong password
    Input Password      ${PASSWORDINPUT}    abcabc111
Click on the Submit button
    Click Element    ${SIGNINBUTTON}
Assert dashboard
    Wait Until Element Is Visible   ${PAGELOGO}
    Title Should Be    Scouts panel
    #Capture Page Screenshot  alert.png
Sign out
    Click Element   ${SIGNOUTBUTTON}
    Title Should Be     Scouts panel - sign in
Check pop-up
    Wait Until Element Is Visible   ${WRONGPASSWORDPOPUP}
    Element Text Should Be      ${WRONGPASSWORDPOPUP}   Identifier or password invalid.
Assert add a player form
    Click Element       ${ADDAPLAYERPAGE}
    Wait Until Element Is Visible       ${ADDPLAYERHEADER}
    Title Should Be     Add player
Type in name
    Input Text      ${NAMEINPUT}   Lemon
Type in surname
    Input Text      ${SURNAMEINPUT}   Smith
Type in main position
    Input Text      ${MAINPOSITIONINPUT}   goalkeeper
Type in age
    Input Text      ${AGEINPUT}     11111811
Click Submit player button
    Scroll Element Into View        ${SUBMITPLAYERBUTTON}
    Click Element       ${SUBMITPLAYERBUTTON}
Check Add player pop-up
    Wait Until Element Is Visible       ${ADDPLAYERALERT}
    Element Text Should Be      ${ADDPLAYERALERT}       Added player.
    Wait Until Element Is Not Visible       ${ADDPLAYERALERT}
    Element Text Should Not Be      ${ADDPLAYERALERT}       Added player.
Check Add player Required alert
    Scroll Element Into View        ${NAMEREQUIREDALERT}
    Wait Until Element Is Visible       ${NAMEREQUIREDALERT}
    #Wait Until Element Is Visible       ${SURNAMEREQUIREDALERT}
    #Wait Until Element Is Visible       ${AGEREQUIREDALERT}
    #Wait Until Element Is Visible       ${MAINPOSITIONREQUIREDALERT}
Select language
    Click Element       ${POLISHOPTIONBUTTON}
    Click Element       ${ENGLISHOPTIONBUTTON}


