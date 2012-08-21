require 'rubygems'
require 'selenium-webdriver'

TIMEOUT = RSpec.configuration.timeout

class BasePage  
  attr_accessor :db_object, :url, :title, :driver

  def initialize(driver, test_env)    
  end
  
  def visit()
    self.driver.navigate.to self.url
  end  
    
  def url_is_ok?()   
    if self.driver.current_url == self.url
       true
    else
       false
    end    
  end    
  
  def text_present?(text)
    if self.driver.page_source().include?(text)
       true
    else
       false
    end
  end 
  
  def text_visible?(text)
    self.driver.find_element(:tag_name, 'body').text.include?(text)
  end
  
  def string_empty?(text)   
    if text.empty?
       true
    else
       false
    end    
  end  
  
  def text_present_wait?(text, wait_time)   
   wait = Selenium::WebDriver::Wait.new(:timeout => wait_time)
   wait.until {true if self.driver.page_source().include?(text)}    
  end

  def element_present?(page, element_name, locate_by)
    begin
      case locate_by
        when "css"
          elements = page.driver.find_elements(:css => page.db_object.elements.find_by_name(element_name).by_css_locator)
        when "xpath"
          elements = page.driver.find_elements(:xpath => page.db_object.elements.find_by_name(element_name).by_xpath_locator)
        when "id"
          elements = page.driver.find_elements(:id => page.db_object.elements.find_by_name(element_name).by_id_locator)
        else
          puts "Error: Case statement needs a valid locateby string!"
      end
    rescue NoMethodError
      return false
    end    
    elements[0].displayed? ? true : false
  end  
  
  def wait_for_element_present(page, element_name, locate_by)
    false
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    case locate_by
      when "css"
        elements = page.driver.find_elements(:css => page.db_object.elements.find_by_name(element_name).by_css_locator)
      when "xpath"
        elements = page.driver.find_elements(:xpath => page.db_object.elements.find_by_name(element_name).by_xpath_locator)
      when "id"
        elements = page.driver.find_elements(:id => page.db_object.elements.find_by_name(element_name).by_id_locator)
      when "link_text"
        elements = page.driver.find_elements(:link_text => page.db_object.elements.find_by_name(element_name).by_link_text_locator)           
      else
        puts "Error: Case statement needs a valid locateby string!"
    end
    true if !elements[0].nil?}  
  end    

  def my_element_present?(page, element_name, locate_by)
    case locate_by
      when "css"
        elements = page.driver.find_elements(:css => page.db_object.elements.find_by_name(element_name).by_css_locator)
      when "xpath"
        elements = page.driver.find_elements(:xpath => page.db_object.elements.find_by_name(element_name).by_xpath_locator)
      when "id"
        elements = page.driver.find_elements(:id => page.db_object.elements.find_by_name(element_name).by_id_locator)
      when "class"
        elements = page.driver.find_elements(:class => page.db_object.elements.find_by_name(element_name).by_class_locator)        
    else
        puts "Error: Case statement needs a valid locateby string!"
    end
    !elements[0].nil? ? true : false
  end    
  
  def wait_for_element_not_present(page, element_name, locate_by)
    i = 0
    TIMEOUT.times {|i| 
    if self.my_element_present?(page, element_name, locate_by) 
      sleep 1
    else
      break
    end  
    }
    (i == 0) ? false : true       
  end  

  def select_option(element, text)   
    element.send_keys(text) 
    element.send_keys(:return)
    element.send_keys(:tab) 
    sleep 1
  end   
  
  def select_option_without_tab(element, text)   
    element.send_keys(text) 
    element.send_keys(:return)
    sleep 1
  end    
  
  def enter_airport(element, text)   
    element.send_keys(text)     
    sleep 2 
    element.send_keys(:arrow_down)     
    element.send_keys(:tab)      
  end  

  def numeric?(text)
    true if Float(text) rescue false
  end
end
