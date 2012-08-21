require 'rubygems'
require 'selenium-webdriver'
require 'spec_helper'
require_relative '../../../lib/base_page'

class FlightResultsPage < BasePage    
  def initialize(driver, test_env)   
    @db_object = Page.find_by_name('flight results page')
    @url = Environment.find_by_name(test_env).base_url + Page.find_by_name('flight results page').url
    @title = Page.find_by_name('flight results page').title
    @driver = driver 
  end    

	def baggage_charges_link 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @baggage_charges_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('baggage charges link').by_css_locator)
	  @baggage_charges_link if @baggage_charges_link.displayed?
	}	
	end	    
  
	def baggage_fees_combobox  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @baggage_fees_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('baggage fees combobox').by_css_locator)
	  @baggage_fees_combobox if @baggage_fees_combobox.displayed?
	}	
	end    
  
	def baggage_fees_close_button  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @baggage_fees_close_button = self.driver.find_element(:xpath => self.db_object.elements.find_by_name('baggage fees close button').by_xpath_locator)
	  @baggage_fees_close_button if @baggage_fees_close_button.displayed?
	}	
	end  

	def baggage_fees_no_data_message  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @baggage_fees_no_data_message = self.driver.find_element(:css => self.db_object.elements.find_by_name('baggage fees no data message').by_css_locator)
	  @baggage_fees_no_data_message if @baggage_fees_no_data_message.displayed?
	}	
	end  
  
	def fare_class_link  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @fare_class_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('fare class link').by_css_locator)
	  @fare_class_link if @fare_class_link.displayed?
	}	
	end    
  
	def update_button  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @update_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('update button').by_css_locator)
	  @update_button if @update_button.displayed?
	}	
	end   
  
	def departure_city_textbox
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @departure_city_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name("departure city textbox").by_id_locator)
	  @departure_city_textbox if @departure_city_textbox.displayed?
	}
	end

	def arrival_city_textbox
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @arrival_city_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name("arrival city textbox").by_id_locator)
	  @arrival_city_textbox if @arrival_city_textbox.displayed?
	}
	end  
  
	def departure_city_clear_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @departure_city_clean_button = self.driver.find_element(:css => self.db_object.elements.find_by_name("departure city clear button").by_css_locator)
	  @departure_city_clean_button if @departure_city_clean_button.displayed?
	}
	end

	def arrival_city_clear_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @arrival_city_clean_button = self.driver.find_element(:css => self.db_object.elements.find_by_name("arrival city clear button").by_css_locator)
	  @arrival_city_clean_button if @arrival_city_clean_button.displayed?
	}
	end      
  
	def number_of_travelers_link
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @number_of_travelers_link = self.driver.find_element(:css => self.db_object.elements.find_by_name("number of travelers link").by_css_locator)
	  @number_of_travelers_link if @number_of_travelers_link.displayed?
	}
	end     

	def adults_combobox  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @adults_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('adults combobox').by_css_locator)
	  @adults_combobox if @adults_combobox.displayed?
	}	
	end  

	def seniors_combobox  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @seniors_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('seniors combobox').by_css_locator)
	  @seniors_combobox if @seniors_combobox.displayed?
	}	
	end  
  
	def children_combobox  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @children_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('children combobox').by_css_locator)
	  @children_combobox if @children_combobox.displayed?
	}	
	end  

	def children_age_combobox(index) 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @children_age_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name("children age combobox #{index}").by_css_locator)
	  @children_age_combobox if @children_age_combobox.displayed?
	}	
	end	 

	def children_seated_option(index)
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @children_seated_option = self.driver.find_element(:css => self.db_object.elements.find_by_name("child seated option #{index}").by_css_locator)
	  @children_seated_option if @children_seated_option.displayed?
	}
	end  

	def children_seated_option_input(index)
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @children_seated_option_input = self.driver.find_element(:css => self.db_object.elements.find_by_name("child seated option input #{index}").by_css_locator)
	  @children_seated_option_input if @children_seated_option_input.displayed?
	}
	end  
  
	def children_lap_option(index)
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @children_lap_option = self.driver.find_element(:css => self.db_object.elements.find_by_name("child lap option #{index}").by_css_locator)
	  @children_lap_option if @children_lap_option.displayed?
	}
	end 

	def children_lap_option_input(index)
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @children_lap_option_input = self.driver.find_element(:css => self.db_object.elements.find_by_name("child lap option input #{index}").by_css_locator)
	  @children_lap_option_input if @children_lap_option_input.displayed?
	}
	end   
  
	def search_error_messages
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @search_error_message = self.driver.find_elements(:css => self.db_object.elements.find_by_name('search error messages').by_css_locator)
	  @search_error_message if !(@search_error_message.nil?)
	}	
	end 

	def search_error_messages_present?
    search_error_messages = []
	  search_error_messages = self.driver.find_elements(:css => self.db_object.elements.find_by_name('search error messages').by_css_locator)
    search_error_messages[0].nil? ? false : true  
	end 
  
 	def departure_date_textbox 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @departure_date_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('departure date textbox 1').by_id_locator)
	  @departure_date_textbox if @departure_date_textbox.displayed?
	}	
	end 

	def return_date_textbox 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @return_date_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('return date textbox 1').by_id_locator)
	  @return_date_textbox if @return_date_textbox.displayed?
	}	
	end  
  
	def calendar_datepicker_present? 
    calendar_datepicker = []
	  calendar_datepicker = self.driver.find_elements(:css => self.db_object.elements.find_by_name('calendar datepicker').by_css_locator)
    calendar_datepicker.nil? ? false : true
	end    
  
	def calendar_datepicker_current_months
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @calendar_datepicker_current_months = self.driver.find_elements(:css => self.db_object.elements.find_by_name('calendar datepicker current months').by_css_locator)
	  @calendar_datepicker_current_months if @calendar_datepicker_current_months[0].displayed?
	}	
	end     
  
	def calendar_datepicker_next_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @calendar_datepicker_next_button = self.driver.find_element(:css => self.db_object.elements.find_by_name("calendar datepicker next button").by_css_locator)
	  @calendar_datepicker_next_button if @calendar_datepicker_next_button.displayed?
	}
	end    
  
	def calendar_datepicker_previous_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @calendar_datepicker_previous_button = self.driver.find_element(:css => self.db_object.elements.find_by_name("calendar datepicker previous button").by_css_locator)
	  @calendar_datepicker_previous_button if @calendar_datepicker_previous_button.displayed?
	}
	end    

	def calendar_datepicker_day_numbers
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @calendar_datepicker_day_number = self.driver.find_elements(:css => self.db_object.elements.find_by_name("calendar datepicker day numbers").by_css_locator)
	  @calendar_datepicker_day_number if @calendar_datepicker_day_number[0].displayed?
	}
	end   
  
	def flight_results_container
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @flight_results_container = self.driver.find_elements(:css => self.db_object.elements.find_by_name("flight results container").by_css_locator)
	  @flight_results_container if @flight_results_container[0].displayed?
	}
	end     
  
  
	def slice_flight_type_titles
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @slice_flight_type_titles = self.driver.find_elements(:css => self.db_object.elements.find_by_name("slice flight type titles").by_css_locator)
	  @slice_flight_type_titles if @slice_flight_type_titles[0].displayed?
	}
	end      

	def slice_show_hide_flight_details_buttons
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @slice_show_hide_flight_details_buttons = self.driver.find_elements(:css => self.db_object.elements.find_by_name("slice show hide flight details buttons").by_css_locator)
	  @slice_show_hide_flight_details_buttons if @slice_show_hide_flight_details_buttons[0].displayed?
	}
	end

	def price_dollar_matrix_airline_columns
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @price_dollar_matrix_airline_columns = self.driver.find_elements(:css => self.db_object.elements.find_by_name("price dollar matrix airline columns").by_css_locator)
	  @price_dollar_matrix_airline_columns if @price_dollar_matrix_airline_columns[0].displayed?
	}
	end
    
	def price_dollar_matrix_collapse_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @price_dollar_matrix_collapse_button = self.driver.find_element(:css => self.db_object.elements.find_by_name("price dollar matrix collapse button").by_css_locator)
	  @price_dollar_matrix_collapse_button if @price_dollar_matrix_collapse_button.displayed?
	}
	end    
  
	def price_dollar_matrix_scroll_bar
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @price_dollar_matrix_scroll_bar = self.driver.find_element(:css => self.db_object.elements.find_by_name("price dollar matrix scroll bar").by_css_locator)
	  @price_dollar_matrix_scroll_bar if @price_dollar_matrix_scroll_bar.displayed?
	}
	end   
  
	def price_dollar_matrix_stops_rows
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @price_dollar_matrix_stops_rows = self.driver.find_elements(:css => self.db_object.elements.find_by_name("price dollar matrix stops rows").by_css_locator)
	  @price_dollar_matrix_stops_rows if @price_dollar_matrix_stops_rows[0].displayed?
	}
	end  

	def price_dollar_matrix_us_dollar_value_row(index)
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @price_dollar_matrix_us_dollar_value_row = self.driver.find_elements(:css => self.db_object.elements.find_by_name("price dollar matrix us dollar value row #{index}").by_css_locator)
	  @price_dollar_matrix_us_dollar_value_row if @price_dollar_matrix_us_dollar_value_row[0].displayed?
	}
	end    

  def quick_compare_air_title
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @quick_compare_air_title = self.driver.find_element(:css => self.db_object.elements.find_by_name("quick compare air title").by_css_locator)
	  @quick_compare_air_title if @quick_compare_air_title.displayed?
	}
	end 
end