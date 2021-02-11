*** Settings ***
Documentation  Its a test cases file
Resource  ../Resources/Common.robot
Resource  ../Resources/RfKeywords.robot
Library  ../Resources/utilities.py
Library  ../Resources/sendEmail.py

Library  FakerLibrary  locale=en_IN
Library  SeleniumLibrary
Library  Collections
Library  RequestsLibrary
Library  String


Suite Setup  Begin Web Test
Suite Teardown  End Web Test

#*** Variables ***
#${home_page_URL} =  https://s3.collegedunia.com
#${listing_page_URL} =  https://s2.collegedunia.com/india-colleges
#${college_home_page_URL} =  https://s3.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi
# uncomment below line when using bat file
#${BROWSER}
#${BROWSER} =  chrome
#${course_listing_stream_URL} =  https://s3.collegedunia.com/courses/engineering
#${course_listing_slug_URL} =  https://s3.collegedunia.com/courses/btech
#${filePath} =  /Users/paraspal/Desktop/leaddata.xlsx
#${WritefilePath} =  /Users/paraspal/Desktop/output.xlsx
#${sheetName} =  Sheet1

#Variables without excel
#*** Variables ***
#${home_page_URL} =  https://s2.collegedunia.com
#${listing_page_URL} =  https://s2.collegedunia.com/india-colleges
#${college_home_page_URL} =  https://s2.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi
#${batchFilePath} =  /Users/paraspal/Desktop/practice/batchfile.bat
## uncomment below line when using bat file
#${BROWSER}
#
#${BROWSER} =  chrome
#${name}
#${email}
#${phone}

*** Test Cases ***
multiarr trial
    [tags]  fillLeads
#    @{data}  create list
    ${data}=  data from excel  ${filePath}  ${sheetName}
#    ${TOTALITEMS}=  GET length  ${data}
#    log to console  ${data}
    ${ALLRECORDS}=  Get Variable Value  ${data}
     log to console  ${data}

    ${TOTALROWS}=  Get length  ${data}
#    ${FIRSTRECORD}=  Get Variable Value  ${data[0]}
    ${TOTALCOL}=  Get length  ${data[0]}
#    log to console  ${ALLRECORDS}
#    log to console  ${TOTALCOL}

    FOR  ${i}  IN RANGE  ${TOTALROWS}
#    @{record}  create list
    #can get all values from each row here by just changing last index 'j'
    ${one_record_from_excel} =  get variable value  ${ALLRECORDS[${i}]}
#    log to console  ${one_record_from_excel}
    RfKeywords.fill Lead Form with excel data  ${one_record_from_excel}
    END

db test
    [tags]  dbtrial
    ${data}=  data from excel  ${filePath}  ${sheetName}
    log to console  ${data}
#    fail
#    ${TOTALITEMS}=  GET length  ${data}

    ${ALLRECORDS}=  Get Variable Value  ${data}
    ${TOTALROWS}=  Get length  ${data}
#    ${FIRSTRECORD}=  Get Variable Value  ${data[0]}
    ${TOTALCOL}=  Get length  ${data[0]}
    log to console  ${ALLRECORDS}
    log to console  ${TOTALCOL}

    FOR  ${i}  IN RANGE  ${TOTALROWS}
#    @{record}  create list
    #can get all values from each row here by just changing last index 'j'
    ${phone_no_from_excel} =  get variable value  ${ALLRECORDS[${i}][2]}
    # this gives one record from excel
#    log to console  ${ALLRECORDS[${i}]}
    ${record}=  db test  ${phone_no_from_excel}
    # this gives corresponding phone_no_from_excel
#     log to console  ${phone_no_from_excel}
    # using this phone no from excel this gives corresponding record from db
    log to console  ${record}
    Compare each cell in a row  ${ALLRECORDS}[${i}]  ${record}  ${TOTALCOL}

    END


Open college listing page and fill lead form
#    [tags]  listing
    RfKeywords.open listing page
    RfKeywords.fill Lead Form

Open college home page and fill lead form
#    [tags]  college
    RfKeywords.open college home page
    RfKeywords.fill Lead Form



Find Broken
#    [arguments]    ${filepath}    ${sheetname}
    [tags]    broken
    Open course listing slug page
    ${outputLinks} =  Find Broken Links  seleniumlibrary.driver
    ${finalLinks} =  get variable value  ${outputLinks}

Check Invalid Links
    [tags]  invalidlinks
#    HomePage.load
#    Open course listing stream page
    Open course listing slug page

    @{LinksItems}  Create List
    @{FinalItems}  Create List

    @{LinksItems}=  Get WebElements  xpath://a
    ${count} =  get length  ${LinksItems}

    FOR  ${i}  IN RANGE  1  ${count}
    ${href}=  get element attribute  ${LinksItems}[${i}]  href
    ${linkLength}=  get length  ${href}
    ${checkStartsWith}=  run keyword and ignore error  should start with  ${href}  ${home_page_URL}/
    ${checkContainsHash}=  run keyword and ignore error  should not contain  ${href}  \#
    run keyword if  ${linkLength}>1 and '${checkStartsWith}[0]'=='PASS' and '${checkContainsHash}[0]'=='PASS'  Append To List  ${FinalItems}  ${href}
#    ${LengthFinalItems} =  get length  ${FinalItems}
#    run keyword if  ${LengthFinalItems}==10  log to console   ${FinalItems}
#    run keyword if  ${LengthFinalItems}==10  Exit For Loop
    END

    Remove Duplicates  ${FinalItems}
    Log list  ${FinalItems}

    ${final_length}=  get length  ${FinalItems}

    @{invalidLInks}  Create List
    FOR  ${j}  IN RANGE  ${final_length}
    log  ${FinalItems}[${j}]
    ${appended_url} =	Get Substring  ${FinalItems}[${j}]  27  end=None
    Create Session  pwebb  ${home_page_URL}
    ${response}  get request  pwebb  ${appended_url}
#    RUN KEYWORD AND CONTINUE ON FAILURE  SHOULD BE EQUAL AS STRINGS  ${response.status_code}  200
    ${status}=  Run Keyword And Return Status  SHOULD BE EQUAL AS STRINGS  ${response.status_code}  200
#    Run Keyword If   ${status}==False  ${invalidLInks}.append(${FinalItems}[${j}])
    run keyword if  ${status}==False  Append To List  ${invalidLInks}  ${FinalItems}[${j}]

    END

    log  ${invalidLInks}

Check Links with blank pages
    [tags]  linksWithBlankPages
#     open home page
#    Open course listing stream page
#    Open course listing slug page

    @{LinksItems}  Create List
    @{FinalItems}  Create List

    @{LinksItems}=  Get WebElements  xpath://a
    ${count} =  get length  ${LinksItems}

    FOR  ${i}  IN RANGE  1  ${count}
    ${href}=  get element attribute  ${LinksItems}[${i}]  href
    ${linkLength}=  get length  ${href}
    ${checkStartsWith}=  run keyword and ignore error  should start with  ${href}  ${home_page_URL}/
    ${checkContainsHash}=  run keyword and ignore error  should not contain  ${href}  \#
    run keyword if  ${linkLength}>1 and '${checkStartsWith}[0]'=='PASS' and '${checkContainsHash}[0]'=='PASS'  Append To List  ${FinalItems}  ${href}
#    ${LengthFinalItems} =  get length  ${FinalItems}
#    run keyword if  ${LengthFinalItems}==10  log to console   ${FinalItems}
    run keyword if  ${i}==10  Exit For Loop
    END

    Remove Duplicates  ${FinalItems}
    Log list  ${FinalItems}

    ${final_length}=  get length  ${FinalItems}

    @{invalidLInks}  Create List
    FOR  ${j}  IN RANGE  ${final_length}
    log  ${FinalItems}[${j}]
    ${appended_url} =	Get Substring  ${FinalItems}[${j}]  27  end=None
    Create Session  pwebb  ${home_page_URL}

    ${response}  get request  pwebb  ${appended_url}
#    ${response}  get request  pwebb  ${appended_url}

#    RUN KEYWORD AND CONTINUE ON FAILURE  SHOULD BE EQUAL AS STRINGS  ${response.status_code}  200
    ${status}=  Run Keyword And Return Status  SHOULD BE EQUAL AS STRINGS  ${response.content}  ${EMPTY}
#    ${status}=  Run Keyword And Return Status  SHOULD BE EQUAL AS STRINGS  ${response.content}  ${EMPTY}
#    log  ${response}
    run keyword if  ${status}==False  Append To List  ${invalidLInks}  ${FinalItems}[${j}]
#    run keyword if  ${status}!=False  Append To List  ${invalidLInks}  ${FinalItems}[${j}]

    END

    log  ${invalidLInks}
    write to excel  ${invalidLInks}  ${WritefilePath}
    send email




FakerLibrary Words Generattion
#   [tags]  listing  home  college

    ${name}=  Name
    ${name} =  Set global Variable  ${name}
    ${email}=  email
    ${email} =  Set global Variable  ${email}
    ${phonee}=  random number  digits=7  fix_len=True
    ${prefix} =  set variable  911
    ${phone} =  Catenate  SEPARATOR=  ${prefix}  ${phonee}
    Log  phone: ${phone}
    ${phone} =  Set global Variable  ${phone}
