require 'rubygems'
require 'selenium-webdriver'
require_relative '../../../lib/base_page'

class PackageDisambiguationPage < BasePage    
  def initialize(driver, test_env)   
    @db_object = Page.find_by_name('package disambiguation page')
    @url = Environment.find_by_name(test_env).base_url + Page.find_by_name('package disambiguation page').url
    @title = Page.find_by_name('package disambiguation page').title
    @driver = driver 
  end    
  
	def departure_city_disambiguation_option_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @departure_city_disambiguation_option_button = self.driver.find_element(:css => self.db_object.elements.find_by_name("departure city disambiguation option button").by_css_locator)
	  @departure_city_disambiguation_option_button if @departure_city_disambiguation_option_button.displayed?
	}
	end

	def arrival_city_disambiguation_option_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @arrival_city_disambiguation_option_button = self.driver.find_element(:css => self.db_object.elements.find_by_name("arrival city disambiguation option button").by_css_locator)
	  @arrival_city_disambiguation_option_button if @arrival_city_disambiguation_option_button.displayed?
	}
	end     

	def update_package_search_button  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @update_package_search_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('update package search button').by_css_locator)
	  @update_package_search_button if @update_package_search_button.displayed?
	}	
	end  
  
  def disambiguation_destinations_list_titles
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @disambiguation_destinations_list_titles = self.driver.find_elements(:css => self.db_object.elements.find_by_name('disambiguation destinations list titles').by_css_locator)
	  @disambiguation_destinations_list_titles if @disambiguation_destinations_list_titles[0].displayed?
	}	
	end
  
  def disambiguation_first_selection_in_all_options
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @disambiguation_first_selection_in_all_options = self.driver.find_elements(:css => self.db_object.elements.find_by_name('disambiguation first selection in all options').by_css_locator)
	  @disambiguation_first_selection_in_all_options if @disambiguation_first_selection_in_all_options[0].displayed?
	}	
	end
  
  def disambiguation_message_error_label
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @disambiguation_message_error_label = self.driver.find_element(:css => self.db_object.elements.find_by_name("disambiguation message error label").by_css_locator)
	  @disambiguation_message_error_label if @disambiguation_message_error_label.displayed?
	}
	end 
   
  def back_to_home_link
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @back_to_home_link = self.driver.find_element(:css => self.db_object.elements.find_by_name("back to home link").by_css_locator)
	  @back_to_home_link if @back_to_home_link.displayed?
	}
	end
  
  def disambiguation_page_title
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @disambiguation_page_title = self.driver.find_element(:css => self.db_object.elements.find_by_name("disambiguation page title").by_css_locator)
	  @disambiguation_page_title if @disambiguation_page_title.displayed?
	}
	end
end