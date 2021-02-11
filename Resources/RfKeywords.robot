*** Settings ***
Documentation  all the keywords used in project
Library  SeleniumLibrary
Library  ../Resources/utilities.py
Resource  ../Resources/Common.robot
Resource  ../Resources/PO/LeadForm.robot
Resource  ../Resources/PO/IndiaCollegeListingPage.robot
Resource  ../Resources/PO/CollegeHomePage.robot
Resource  ../Resources/PO/CourseListingSlug.robot
Resource  ../Resources/PO/CourseListingStream.robot

*** Keywords ***

open listing page
    [arguments]  ${testData}
    IndiaCollegeListingPage.load  ${testData}
open college home page
    [arguments]  ${testData}
    CollegeHomePage.load  ${testData}

fill lead form
    [arguments]  ${testData}
    LeadForm.fill lead nameemailphone  ${testData}
    ${current_URL}=  Get Location
#    Run Keyword if  '${current_URL}' != 'https://s2.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi'  LeadForm.Fill Lead city
    LeadForm.Fill Lead city
    LeadForm.Fill Lead other details

fill Lead Form with excel data
    [arguments]  ${testData}
    ${curr_url}=  get variable value  ${testData}
    log to console  ${curr_url}
#    Run Keyword if  '${curr_url}[5]' == 'https://s3.collegedunia.com/india-colleges'  open listing page  ${testData}
    Run Keyword if  '${curr_url}[5]' == '${listingPage}'  open listing page  ${testData}
    Run Keyword if  '${curr_url}[5]' == '${collegePage}'  open college home page  ${testData}
#    Run Keyword if  '${curr_url}[5]' == 'https://s3.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi'  open college home page  ${testData}

    fill lead form  ${testData}

data from excel
    [arguments]  ${filename}  ${sheetname}
    ${data}=  read data from excel  ${filename}  ${sheetname}
    [return]  ${data}

Compare each cell in a row
    [arguments]  ${CURRRECORDEXCEL}  ${CURRRECORDDB}  ${TOTALCOL}
    FOR  ${j}  IN RANGE  ${TOTALCOL}-3
    Run Keyword And Continue On Failure  should be equal as strings  ${CURRRECORDEXCEL}[${j}]  ${CURRRECORDDB[${j}+1]}
    log  ${CURRRECORDEXCEL}[${j}]
    log  ${CURRRECORDDB[${j}+1]}
    END

Open home page
    [tags]  home
    HomePage.load

Open course listing stream page
    [tags]  home
    CourseListingStream.load

Open course listing slug page
    [tags]  home
    CourseListingSlug.load