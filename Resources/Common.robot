*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
Begin Web Test
    Open Browser  about:blank  ${BROWSER}
    maximize browser window
#    Set Selenium Implicit Wait  15s

End Web Test
    Close Browser
