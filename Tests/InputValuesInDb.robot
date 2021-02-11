*** Settings ***
Documentation  Its a test cases file
Resource  ../Resources/Common.robot
Resource  ../Resources/RfKeywords.robot
Library  FakerLibrary  locale=en_IN
Library  SeleniumLibrary
Library  Collections
Library  RequestsLibrary
Library  String

Suite Setup  Begin Web Test
Suite Teardown  End Web Test

*** Variables ***
${BROWSER} =  chrome

*** Test Cases ***
Logging data
    log  abc
