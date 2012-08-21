require 'rubygems'
require 'selenium-webdriver'
require_relative '../../../lib/base_page'
require 'spec_helper'
require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require_relative '../db/models/database_model'

class PackageHotelDetailsPage < BasePage   
  def initialize(driver, test_env)   
    @db_object = Page.find_by_name('package hotel details page')
    @url = Environment.find_by_name(test_env).base_url + Page.find_by_name('package hotel details page').url
    @title = Page.find_by_name('package hotel details page').title
    @driver = driver 
  end  
  
  def dp_room_details_card_titles
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @dp_room_details_card_titles = self.driver.find_elements(:css => self.db_object.elements.find_by_name('dp room details card titles').by_css_locator)
    @dp_room_details_card_titles if @dp_room_details_card_titles[0].displayed?
  }
  end   
  
  def package_hotel_details_hotel_name
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @package_hotel_details_hotel_name = self.driver.find_element(:css => self.db_object.elements.find_by_name('package hotel details hotel name').by_css_locator)
    @package_hotel_details_hotel_name if @package_hotel_details_hotel_name.displayed?
  }
  end 

  def package_hotel_details_check_dates
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @package_hotel_details_check_dates = self.driver.find_elements(:css => self.db_object.elements.find_by_name('package hotel details check dates').by_css_locator)
    @package_hotel_details_check_dates if @package_hotel_details_check_dates[0].displayed?
  }
  end
  
  def package_hotel_details_guests_and_rooms
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @package_hotel_details_guests_and_rooms = self.driver.find_elements(:css => self.db_object.elements.find_by_name('package hotel details guests and rooms').by_css_locator)
    @package_hotel_details_guests_and_rooms if @package_hotel_details_guests_and_rooms[0].displayed?
  }
  end  
    
  def package_hotel_details_stars_container
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @package_hotel_details_stars_container = self.driver.find_element(:css => self.db_object.elements.find_by_name('package hotel details stars container').by_css_locator)
    @package_hotel_details_stars_container if @package_hotel_details_stars_container.displayed?
  }
  end  

  def package_hotel_details_stars_help_link
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @package_hotel_details_stars_help_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('package hotel details stars help link').by_css_locator)
    @package_hotel_details_stars_help_link if @package_hotel_details_stars_help_link.displayed?
  }
  end    
  
  def package_hotel_details_start_a_new_search_link
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @package_hotel_details_start_a_new_search_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('package hotel details start a new search link').by_css_locator)
    @package_hotel_details_start_a_new_search_link if @package_hotel_details_start_a_new_search_link.displayed?
  }
  end    
  
  def package_hotel_details_first_select_this_hotel_button
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @package_hotel_details_first_select_this_hotel_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('package hotel details first select this hotel button').by_css_locator)
    @package_hotel_details_first_select_this_hotel_button if @package_hotel_details_first_select_this_hotel_button.displayed?
  } 
  end
  
  def package_hotel_details_address
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @package_hotel_details_first_select_this_hotel_button = self.driver.find_element(:class => self.db_object.elements.find_by_name('package hotel details address').by_class_locator)
    @package_hotel_details_first_select_this_hotel_button if @package_hotel_details_first_select_this_hotel_button.displayed?
  } 
  end  
end