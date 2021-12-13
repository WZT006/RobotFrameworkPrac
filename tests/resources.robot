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

@{high-low}
    ...     $49.99
    ...     $29.99
    ...     $15.99
    ...     $15.99
    ...     $9.99
    ...     $7.99
@{low-high}
    ...     $7.99
    ...     $9.99
    ...     $15.99
    ...     $15.99
    ...     $29.99
    ...     $49.99
@{AZ}
  ...  Sauce Labs Backpack
  ...  Sauce Labs Bike Light
  ...  Sauce Labs Bolt T-Shirt
  ...  Sauce Labs Fleece Jacket
  ...  Sauce Labs Onesie
  ...  Test.allTheThings() T-Shirt (Red)

@{ZA}
  ...  Test.allTheThings() T-Shirt (Red)
  ...  Sauce Labs Onesie
  ...  Sauce Labs Fleece Jacket
  ...  Sauce Labs Bolt T-Shirt
  ...  Sauce Labs Bike Light
  ...  Sauce Labs Backpack
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
List Compare
    [Arguments]     ${elem}     ${expe}
    ${i}=  Set Variable     0
     FOR    ${element}    IN    @{elem}
        ${cur}=    Get From List    ${expe}   ${i}
        Should be Equal     ${element.text}     ${cur}
        ${i}=   Evaluate    ${i}+1
     END