require 'rubygems'
require 'selenium-webdriver'
require 'spec_helper'
require_relative '../../../lib/base_page'

TIMEOUT = RSpec.configuration.timeout

class HotelCheckoutPage < BasePage  
  def initialize(driver, test_env)   
    @db_object = Page.find_by_name('hotel checkout page')
    @url = Environment.find_by_name(test_env).base_url + Page.find_by_name('hotel checkout page').url
    @title = Page.find_by_name('hotel checkout page').title
    @driver = driver 
  end  
  
  def checkout_title
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @checkout_title = self.driver.find_element(:css => self.db_object.elements.find_by_name('checkout title').by_css_locator)
	  @checkout_title if @checkout_title.displayed?
	}	
	end 
  
  def more_details_link
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @more_details_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('more details link').by_css_locator)
	  @more_details_link if @more_details_link.displayed?
	}	
	end 
  
  def review_your_hotel_booking_label
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @review_your_hotel_booking_label = self.driver.find_elements(:css => self.db_object.elements.find_by_name('review your hotel booking label').by_css_locator)
	  @review_your_hotel_booking_label if @review_your_hotel_booking_label[0].displayed?
	}	
  end
  
  def step_1_checkout_label
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @step_1_checkout_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('step 1 checkout label').by_css_locator)
	  @step_1_checkout_label if @step_1_checkout_label.displayed?
	}	
	end 
  
    def step_2_information_label
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @step_2_information_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('step 2 information label').by_css_locator)
	  @step_2_information_label if @step_2_information_label.displayed?
	}	
	end 
end