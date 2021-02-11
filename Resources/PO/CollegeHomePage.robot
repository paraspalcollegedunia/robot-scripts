*** Settings ***
Documentation  locators and methods of college homepage
Library  SeleniumLibrary


*** Keywords ***
#find shadow element here
#    find shadow element

load
   [arguments]  ${testData}

   go to  ${testData}[5]
   ${leadType}=  get variable value  ${testData}

#   ele=  driver.executeScript("return arguments[0].shadowRoot", element)
#   driver=
#   ${ele} =
#   Run Keyword if  '${leadType}[6]' == 'shortlist'  click element  ${ele}
   Run Keyword if  '${leadType}[6]' == 'Get Contact Details'  click element  //p[contains(text(),'Get Contact Details')]
   Run Keyword if  '${leadType}[6]' == 'apply now'  click element  //a[@id='info_popup_true']
   Run Keyword if  '${leadType}[6]' == 'download brochure'  click element  //body/div[12]/a[2]
   sleep  2s


#   go to  ${college_home_page_URL}
#   sleep  3s
#   click element  css:body > div.college_top_wrapper > div.container-fluid.wrapper-top > div > div.college_shortlist > a > svg > use
#   sleep  3s
#







#Verfy Page Loaded
#   wait until page contains  Have Plans To Study In USA?

#make a list of xpath of different elements and loop through them
#"""
#info page:
#https://s1.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi
#add the above xpath of shortlist too
#click button  apply now
#click button  Download Brochure
#click button   Get free counselling
#click element  # with second or first in list of courses occurence of text 'Download Brochure'
#svg in similar colleges and- css:#news_extra_section > div > div > div > div:nth-child(1) > div > div > div > a > svg > use
##check the above point fr both snippets similar collegs and news colleges
#
#https://s1.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi/courses-fees
#all same as info
#
#https://s1.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi/admission
#except list download br btn
#
#https://s1.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi/reviews
#https://s1.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi/department
#https://s1.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi/cutoff
#https://s1.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi/placement
#https://s1.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi/ranking
#https://s1.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi/gallery
#https://s1.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi/scholarship
#https://s1.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi/faculty
#https://s1.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi/hostel
#same as in adm
#
#https://s1.collegedunia.com/university/25455-indian-institute-of-technology-iit-new-delhi/news
#diff
#"""