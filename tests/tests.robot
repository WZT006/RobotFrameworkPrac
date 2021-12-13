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
    # input username and password
    Input Credentials    ${VALID_USER}      ${Password}
    # should be open in products page
    Product Page Should Be Open
    # close browser
    [Teardown]    Close Browser

Locked Out Login
    Open Browser To Login Page
    # input username and password
    Input Credentials    ${LOCKED_OUT}      ${Password}
    # Error message is "Epic sadface: Sorry, this user has been locked out."
    Element Text Should Be    xpath://*[@id="login_button_container"]/div/form/div[3]/h3    Epic sadface: Sorry, this user has been locked out.
    # close browser
    [Teardown]    Close Browser

Wrong password
    Open Browser To Login Page
    # input username and password
    Input Credentials  ${VALID_USER}   asasdasdas
    Element Text Should Be    xpath://*[@id="login_button_container"]/div/form/div[3]/h3    Epic sadface: Username and password do not match any user in this service
    [Teardown]  Close Browser

Broken User
    Open Browser To Login Page
    # input username and password
    Input Credentials    problem_user      ${Password}
    # should be open in products page
    Product Page Should Be Open
    Page Should Contain Image   /static/media/sl-404.168b1cce.jpg
    [Teardown]  Close Browser

Sort Product A-Z
    Open Browser To Login Page
    # input username and password
    Input Credentials    ${VALID_USER}      ${Password}
    # should be open in products page
    Product Page Should Be Open
    Select From List By Label   class:product_sort_container    Name (A to Z)
    Product Sorted by   NAME (A TO Z)
    ${elem}=    Get WebElement  class:inventory_item_name
    Element Text Should Be  ${elem}     Sauce Labs Backpack
    # close browser
    [Teardown]    Close Browser

Sort Product Z-A
    Open Browser To Login Page
    # input username and password
    Input Credentials    ${VALID_USER}      ${Password}
    # should be open in products page
    Select From List By Label   class:product_sort_container    Name (Z to A)
    Product Sorted by   NAME (Z TO A)
    ${elem}=    Get WebElement  class:inventory_item_name
    Element Text Should Be  ${elem}     Test.allTheThings() T-Shirt (Red)
    # close browser
    [Teardown]    Close Browser
Sort Product low-high
    Open Browser To Login Page
    # input username and password
    Input Credentials    ${VALID_USER}      ${Password}
    # should be open in products page
    Product Page Should Be Open
    Select From List By Label   class:product_sort_container    Price (low to high)
    ${elem}=    Get WebElement  class:inventory_item_price
    Element Text Should Be  ${elem}     $7.99    
    # close browser
    [Teardown]    Close Browser
Sort Product high-low
    Open Browser To Login Page
    # input username and password
    Input Credentials    ${VALID_USER}      ${Password}
    # should be open in products page
    Product Page Should Be Open
    Select From List By Label   class:product_sort_container    Price (high to low)
    ${elem}=    Get WebElement  class:inventory_item_price
    Element Text Should Be  ${elem}     $49.99 
    # close browser
    [Teardown]    Close Browser

