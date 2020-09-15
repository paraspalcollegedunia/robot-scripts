*** Settings ***
Documentation  locators and methods of collegedunia homepage
Library  SeleniumLibrary
Resource  ../Resources/PO/HomePage.robot
Resource  ../Resources/PO/LeadForm.robot
Resource  ../Resources/PO/IndiaCollegeListingPage.robot
Resource  ../Resources/PO/CollegeHomePage.robot



*** Keywords ***
open listing page
    IndiaCollegeListingPage.load
open college home page
    CollegeHomePage.load

fill lead form

#    ${result} =  set variable  False
    LeadForm.fill lead nameemailphone
    ${current_URL}=  Get Location

#    Run Keyword if  '${current_URL}' != 'https://s1.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi'  ${result} =  SET VARIABLE  True
    Run Keyword if  '${current_URL}' != 'https://s2.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi'  LeadForm.Fill Lead city

#    run keyword if  '${result}' == 'True'  LeadForm.Fill Lead city
#    run keyword if  '${result}' == 'True'  LeadForm.Fill Lead city
    LeadForm.Fill Lead other details



#    HomePage.Load
#    HomePage.Verfy Page Loaded

#    IndiaCollegeListingPage.Open India College Listing Page








