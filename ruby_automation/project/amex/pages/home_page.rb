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

class HomePage < BasePage   
  def initialize(driver, test_env, *arg)   
    @db_object = Page.find_by_name('home page')
    @url = arg[0] || Environment.find_by_name(test_env).base_url
    @title = Page.find_by_name('home page').title
    @driver = driver 
  end  

  def departure_date_textbox 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @departure_date_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('home departure date textbox').by_id_locator)
	  @departure_date_textbox if @departure_date_textbox.displayed?
  }	
  end
	
	
  def return_date_textbox 
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @return_date_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('home return date textbox').by_id_locator)
    @return_date_textbox if @return_date_textbox.displayed?
  } 
  end 
  
  def departure_city_textbox 
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @departure_city_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('departure city textbox').by_id_locator)
    @departure_city_textbox if @departure_city_textbox.displayed?
  } 
  end   
  
  def arrival_city_textbox 
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @arrival_city_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('departure city textbox').by_id_locator)
    @arrival_city_textbox if @arrival_city_textbox.displayed?
  } 
  end    
  
  def home_flight_and_hotel_search_button 
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @home_flight_and_hotel_search_button = self.driver.find_element(:name => self.db_object.elements.find_by_name('home flight and hotel search button').by_name)
    @home_flight_and_hotel_search_button if @home_flight_and_hotel_search_button.displayed?
  } 
  end  
end