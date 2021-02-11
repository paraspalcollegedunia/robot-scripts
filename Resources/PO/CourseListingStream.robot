*** Settings ***
Documentation  locators and methods of course listing stream page
Library  SeleniumLibrary

*** Keywords ***
Load
   go to  ${course_listing_stream_URL}
#Verfy Page Loaded
#   wait until page contains  Have Plans To Study In USA?


