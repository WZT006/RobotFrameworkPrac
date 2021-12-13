*** Settings ***
Documentation    A resource file with reusable keywords and variables
...
...              Creating system specific keywords from default keywords
...              from SeleniumLibrary
Library          SeleniumLibrary

*** Variables ***
${Server}       www.saucedemo.com
${Browser}      chrome
${Delay}        0
${VALID_USER}   standard_user
${LOCKED_OUT}   locked_out_user
${Password}     secret_sauce
${login_url}    https://${Server}/
${Home_URL}     https://${Server}/inventory.html


*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Page Should Contain Element    login-button

Product Page Should Be Open
    Element Text Should Be    class:title    PRODUCTS

Product Sorted by
    [Arguments]     ${Sorting}
    Element Text Should Be    class:active_option    ${Sorting}
Input Credentials
    [Arguments]    ${username}  ${password}
    Input Text    user-name    ${username}
    Input Password  password    ${password}
    Click Button    login-button
