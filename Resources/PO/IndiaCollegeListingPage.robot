*** Settings ***
Documentation  locators and methods of collegedunia listing page
Library  SeleniumLibrary

*** Keywords ***
load
   [arguments]  ${testData}
#without excel
#   go to  ${listing_page_URL}
#   log to console  msg : ${testData[5]}
   go to  ${testData}[5]
   Click Element  css:body > div.listing-wrapper > div > div.col-xs-9.snippet_side > div.row.listing-block-cont.js-scrolling-container > div:nth-child(3) > div > a.clg-apply.open-popup-inline.apply-now-button
#   Wait Until Page Contains  Suruchi Gupta

#   uncomment below lines for both buttons

#   ${leadType}=  get variable value  ${testData}
#   Run Keyword if  '${leadType}[6]' == 'Get Contact Details'  click element  //p[contains(text(),'Get Contact Details')]
#   Run Keyword if  '${leadType}[6]' == 'apply now'  click element  //a[@id='info_popup_true']

