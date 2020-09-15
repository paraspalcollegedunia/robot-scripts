*** Settings ***
Documentation  locators and methods of lead form
Library  SeleniumLibrary
*** Keywords ***
Fill Lead nameemailphone
#   Click Element  xpath:/html/body/div[7]/div/div[6]/div[2]/div[2]/div/a[1]
#   Wait Until Page Contains  Register Now To Apply
#   sleep  1s
   input text  css:#js-input-name  ${name}
   input text  css:#js-input-email  ${email}
   input text  css:#js-input-phone_no  ${phone}
#   ${current_URL}=  Get Location
Fill Lead city
   input text  css:#js-input-city  New Delhi
   Wait Until Element Is Enabled  //div[@id='js-city']/ul[@id="js-select-container-city"]/li/ul/li[text()='New Delhi']
#   click element  //*[@id="js-select-container-city"]/li/ul/li[text()='New Delhi']
   click element  //div[@id='js-city']/ul[@id="js-select-container-city"]/li/ul/li[text()='New Delhi']
Fill Lead other details
   input text  css:#js-input-course_tag_id  BA - Bachelors (Arts)
   click element  xpath://*[@id="js-select-container-course_tag_id"]/li/ul/li[text()='BA - Bachelors (Arts)']
   Click Button  css:#js-lead-submit
   sleep  2s

#//*[@id="js-city"]/ul/li/ul/li[contains(text(),'New Delhi')]


