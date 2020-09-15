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
${home_page_URL} =  https://s2.collegedunia.com
${listing_page_URL} =  https://s2.collegedunia.com/india-colleges
${college_home_page_URL} =  https://s2.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi
${BROWSER} =  chrome
${name}
${email}
${phone}

#${city} = New Delhi
#${course} = BA - Bachelors (Arts)
*** Test Cases ***
FakerLibrary Words Generattion
   [tags]  listing  home  college

    ${name}=  Name
    ${name} =  Set global Variable  ${name}
    ${email}=  email
    ${email} =  Set global Variable  ${email}
    ${phonee}=  random number  digits=7  fix_len=True
    ${prefix} =  set variable  911
    ${phone} =  Catenate  SEPARATOR=  ${prefix}  ${phonee}
    Log  phone: ${phone}
    ${phone} =  Set global Variable  ${phone}

Open home page and fill lead form
    [tags]  home
    HomePage.load

Open college listing page and fill lead form
    [tags]  listing
    RfKeywords.open listing page
    RfKeywords.fill Lead Form

Open college home page and fill lead form
    [tags]  college
    RfKeywords.open college home page
    RfKeywords.fill Lead Form

Check Invalid Links
    [tags]  invalidlinks
    HomePage.load
#    ${Items} =  Get Element Count  //a
#    Log  ${Items}
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
    ${LengthFinalItems} =  get length  ${FinalItems}
    run keyword if  ${LengthFinalItems}==10  log to console   ${FinalItems}
    run keyword if  ${LengthFinalItems}==10  Exit For Loop
    END

    Remove Duplicates  ${FinalItems}
    Log list  ${FinalItems}

    ${final_length}=  get length  ${FinalItems}

    FOR  ${j}  IN RANGE  ${final_length}
    log  ${FinalItems}[${j}]
    ${ignore_first} =	Get Substring  ${FinalItems}[${j}]  27  end=None
    Create Session  pwebb  ${home_page_URL}
    ${response}  get request  pwebb  ${ignore_first}
    RUN KEYWORD AND CONTINUE ON FAILURE  SHOULD BE EQUAL AS STRINGS  ${response.status_code}  200
    END