require 'rspec'
require 'rubygems'
require 'selenium-webdriver'




driver = Selenium::WebDriver.for :firefox
driver.navigate.to "http://google.com"    

  

element = driver.find_element(:name, 'q')
element.send_keys "java"
element.submit


# driver.find_element(:id => 'div#main div#res.med div#ires ol#rso li.g:nth-of-type(2) div.vsc h3.r a.l').click
# driver.find_elements(:css => page.db_object.elements.find_by_name(element_name).by_css_locator)


driver.find_element(:id,"sflas").click


driver.quit
