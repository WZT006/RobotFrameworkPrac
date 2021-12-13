*** Settings ***
Documentation   A test suite with a single test suite for a valid login
...         
...             This test Follows the example using keywords from
...             The SeleniumLibrary
Library         SeleniumLibrary
Resource        resources.robot
*** Variables ***

*** Keywords ***



*** Test Cases ***
Valid Login
    Open Browser To Login Page
    # input username
    Input Username    ${VALID_USER}
    # input password
    Input Pass    ${Password}
    # click login button
    Submit Credentials
    # should be open in products page
    Product Page Should Be Open
    # close browser
    [Teardown]    Close Browser

Locked Out Login
    Open Browser To Login Page
    # input username
    Input Username    ${LOCKED_OUT}
    # input password
    Input Pass    ${Password}
    # click login button
    Submit Credentials
    # Error message is "Epic sadface: Sorry, this user has been locked out."
    Element Text Should Be    xpath://*[@id="login_button_container"]/div/form/div[3]/h3    Epic sadface: Sorry, this user has been locked out.
    # close browser
    [Teardown]    Close Browser

