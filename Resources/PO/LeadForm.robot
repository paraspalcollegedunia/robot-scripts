*** Settings ***
Documentation  locators and methods of lead form
Library  SeleniumLibrary

*** Keywords ***
Fill Lead nameemailphone
   [arguments]  ${testData}

   run keyword and ignore error  clear Element text  css:#js-input-name
#   set selenium timeout    10s
#   wait until element is enabled  css:#js-input-name
#   clear Element text  css:#js-input-name
   input text  css:#js-input-name  ${testData}[0]

   clear Element text  css:#js-input-email
#   run keyword and ignore error  clear Element text  css:#js-input-email
   input text  css:#js-input-email  ${testData}[1]

   clear Element text  css:#js-input-phone_no
#   run keyword and ignore error  clear Element text  css:#js-input-phone_no
   input text  css:#js-input-phone_no  ${testData}[2]

Fill Lead city
#   [arguments]  ${testData}
   ${cityText} =  get text  xpath://*[@id="js-input-city"]
   Set Focus To Element  xpath://*[@id="js-input-city"]
   run keyword if  "${cityText}"==" ${EMPTY}"  input text  css:#js-input-city  New Delhi

#   run keyword if  "${cityText}"==" ${EMPTY}"  input text  css:#js-input-city  ${testData}[3]
   Set Focus To Element  xpath://div[@id='js-city']/ul[@id="js-select-container-city"]
   ${elem} =  Get WebElement  xpath://body/div[@id='responsive_modal_leadform']/div[@id='responsive-modal-content-leadform']/div[@id='js-leadform-main']/div[@id='form-container']/div[@id='leadform_wrap_1']/div[1]/form[1]/div[1]/div[2]/div[1]/div[5]/div[1]/ul[1]/li[1]/ul[1]/li[1]
   click element  ${elem}

Fill Lead other details
#   [arguments]  ${testData}
   ${courseText} =  get text  css:#js-input-course_tag_id
   Set Focus To Element  css:#js-input-course_tag_id
#   run keyword if  "${courseText}"==" ${EMPTY}"  input text  css:#js-input-course_tag_id  BA - Bachelors (Arts)
   run keyword if  "${courseText}"==" ${EMPTY}"  input text  css:#js-input-course_tag_id  B.P.Ed - Bachelor (Education)

#   run keyword if  "${courseText}"==" ${EMPTY}"  input text  css:#js-input-course_tag_id  ${testData}[4]
#   ${finalCourseXpathA} =  (//div[@id='js-course_tag_id']/ul/li/ul/li[text()='
#   ${finalCourseXpathB} =  ${testData}[4]
#   ${finalCourseXpathC} =  '])[1]
#   ${finalCourseXpathAB} =  catenate  ${finalCourseXpathA}   ${finalCourseXpathB}
#   ${finalCourseXpathABC} =  catenate  ${finalCourseXpathAB}   ${finalCourseXpathC}



#   click element  xpath:(//div[@id='js-course_tag_id']/ul/li/ul/li[text()='BA - Bachelors (Arts)'])[1]
   click element  xpath:(//div[@id='js-course_tag_id']/ul/li/ul/li[text()='B.P.Ed - Bachelor (Education)'])[1]
#   click element  xpath:${finalCourseXpathABC}
   Click Button  css:#js-lead-submit
   sleep  2s

