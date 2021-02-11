*** Settings ***
Documentation  locators and methods of course listing slug page
Library  SeleniumLibrary
Resource    ../Resources/Common.robot
*** Keywords ***
Load
   go to  ${course_listing_slug_URL}
#Verfy Page Loaded
#   wait until page contains  Have Plans To Study In USA?


