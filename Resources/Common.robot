*** Settings ***
Library  SeleniumLibrary


*** Keywords ***
Begin Web Test
    Open Browser  about:blank  ${BROWSER}    options=addArguments("--incognito")
    maximize browser window
    Set Selenium Implicit Wait  15s

End Web Test
    Close Browser

*** Variables ***

${listingPage} =  https://s3.collegedunia.com/india-colleges
${collegePage} =  https://s3.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi
${course_listing_stream_URL} =  https://s3.collegedunia.com/courses/engineering
${course_listing_slug_URL} =  https://s3.collegedunia.com/courses/btech
${filePath} =  /Users/paraspal/Desktop/leaddata.xlsx
${WritefilePath} =  /Users/paraspal/Desktop/output.xlsx
${sheetName} =  Sheet1
${BROWSER} =  chrome
${batchFilePath} =  /Users/paraspal/Desktop/practice/batchfile.bat

${home_page_URL} =  https://s3.collegedunia.com
${college_home_page_URL} =  https://s3.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi
