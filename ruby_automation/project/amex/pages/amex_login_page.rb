require 'rubygems'
require 'selenium-webdriver'
require_relative '../../../lib/base_page'

require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require_relative '../db/models/database_model'

TIMEOUT = RSpec.configuration.timeout

class AmexLoginPage < BasePage   
  def initialize(driver, test_env, *arg)   
    @db_object = Page.find_by_name('amex login page')
    @url = arg[0] || Environment.find_by_name(test_env).base_url
    @title = Page.find_by_name('amex login page').title
    @driver = driver 
  end  
  
  def amex_login_welcome_title
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
  wait.until {
  @amex_login_welcome_title = self.driver.find_element(:css => self.db_object.elements.find_by_name('amex login welcome title').by_css_locator)
  @amex_login_welcome_title if @amex_login_welcome_title.displayed?
  }
  end  

  def amex_login_form_title
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
  wait.until {
  @amex_login_form_title = self.driver.find_element(:css => self.db_object.elements.find_by_name('amex login form title').by_css_locator)
  @amex_login_form_title if @amex_login_form_title.displayed?
  }
  end       
  
  def amex_login_user_textbox
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
  wait.until {  
  @amex_login_user_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('amex login user textbox').by_id_locator)
  @amex_login_user_textbox if @amex_login_user_textbox.displayed?
  }	
  end      
     
  def amex_login_password_textbox
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
  wait.until {  
  @amex_login_password_textbok = self.driver.find_element(:id => self.db_object.elements.find_by_name('amex login password textbox').by_id_locator)
  @amex_login_password_textbok if @amex_login_password_textbok.displayed?
  }	
  end     
  
  def amex_login_button 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	wait.until {
	@amex_login_button = self.driver.find_element(:class => self.db_object.elements.find_by_name('amex login button').by_class_locator)
	@amex_login_button if @amex_login_button.displayed?
  }
  end  
  
  # def amex_login_button 
      # wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	# wait.until {
	# @amex_login_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('amex login button').by_css_locator)
	# @amex_login_button if @amex_login_button.displayed?
  # }
  # end  
end