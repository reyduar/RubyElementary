require 'rubygems'
require 'selenium-webdriver'
require 'spec_helper'
require_relative '../../../lib/base_page'

TIMEOUT = RSpec.configuration.timeout

class TestLoginPage < BasePage  
  def initialize(driver, test_env)   
    @db_object = Page.find_by_name('test login page')
    @url = Environment.find_by_name(test_env).base_url + Page.find_by_name('test login page').url
    @title = Page.find_by_name('test login page').title
    @driver = driver 
  end  
 
  def test_user1_login_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @test_user1_login_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('test user1 login button').by_css_locator)
	  @test_user1_login_button if @test_user1_login_button.displayed?
	}	
	end  
  
  def test_user2_login_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @test_user1_login_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('test user2 login button').by_css_locator)
	  @test_user1_login_button if @test_user1_login_button.displayed?
	}	
	end    
  
  def test_user4_login_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @test_user1_login_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('test user4 login button').by_css_locator)
	  @test_user1_login_button if @test_user1_login_button.displayed?
	}	
	end  

  def logout_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @logout_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('logout button').by_css_locator)
	  @logout_button if @logout_button.displayed?
	}	
	end  
end