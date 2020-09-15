*** Settings ***
Documentation  locators and methods of collegedunia listing page
Library  SeleniumLibrary

*** Keywords ***
load
   go to  ${listing_page_URL}
#   Click Element  xpath:/html/body/div[7]/div/div[6]/div[2]/div[2]/div/a[1]
   Click Element  xpath:/html/body/div[7]/div/div[4]/div[2]/div[2]/div/a[1]
#   Wait Until Page Contains  Suruchi Gupta


#/html/body/div[7]/div/div[4]/div[2]/div[2]/div/a[1]/text()
