require 'rubygems'
require 'selenium-webdriver'
require_relative '../../../lib/base_page'
require 'spec_helper'

class PackageResultsPage < BasePage    
  def initialize(driver, test_env)   
    @db_object = Page.find_by_name('package results page')
    @url = Environment.find_by_name(test_env).base_url + Page.find_by_name('package results page').url
    @title = Page.find_by_name('package results page').title
    @driver = driver 
  end    

  def package_results_page_head_title
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @package_results_page_head_title = self.driver.find_element(:css => self.db_object.elements.find_by_name('package results page head title').by_css_locator)
	  @package_results_page_head_title if @package_results_page_head_title.displayed?
	}	
	end 
    
  def result_error_messages
  	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @result_error_messages = self.driver.find_elements(:css => self.db_object.elements.find_by_name('package results error messages').by_css_locator)
	  @result_error_messages if @result_error_messages[0].displayed?
	}	
  end     
  
  def sort_by_combobox 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @sort_by_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('sort by combobox').by_css_locator)
	  @sort_by_combobox if @sort_by_combobox.displayed?
	}	
	end  
  
  def sort_by_combobox_values
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @sort_by_combobox_values = self.driver.find_elements(:xpath => self.db_object.elements.find_by_name('sort by combobox values').by_xpath_locator)
	  @sort_by_combobox_values if @sort_by_combobox_values[0].displayed?
	}	
	end 

  def results_hotel_names
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @results_hotel_names = self.driver.find_elements(:css => self.db_object.elements.find_by_name('results hotel names').by_css_locator)
	  @results_hotel_names if @results_hotel_names[0].displayed?
	}	
	end 
  
  def results_hotel_prices
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @results_hotel_prices = self.driver.find_elements(:css => self.db_object.elements.find_by_name('results hotel prices').by_css_locator)
	  @results_hotel_prices if @results_hotel_prices[0].displayed?
	}	
	end 
  
  def first_card_star_five
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @first_card_star_five = self.driver.find_element(:css => self.db_object.elements.find_by_name('first card star five').by_css_locator)
	  @first_card_star_five if @first_card_star_five.displayed?
	}	
	end 
  
  def first_card_star_four
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @first_card_star_four = self.driver.find_element(:css => self.db_object.elements.find_by_name('first card star four').by_css_locator)
	  @first_card_star_four if @first_card_star_four.displayed?
	}	
	end  
  
  def first_card_star_three
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @first_card_star_three = self.driver.find_element(:css => self.db_object.elements.find_by_name('first card star three').by_css_locator)
	  @first_card_star_three if @first_card_star_three.displayed?
	}	
	end 
  
  def second_card_star_five
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @second_card_star_five = self.driver.find_element(:css => self.db_object.elements.find_by_name('second card star five').by_css_locator)
	  @second_card_star_five if @second_card_star_five.displayed?
	}	
	end
  
  def second_card_star_four
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @second_card_star_four = self.driver.find_element(:css => self.db_object.elements.find_by_name('second card star four').by_css_locator)
	  @second_card_star_four if @second_card_star_four.displayed?
	}	
	end
  
  def second_card_star_three
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @second_card_star_three = self.driver.find_element(:css => self.db_object.elements.find_by_name('second card star three').by_css_locator)
	  @second_card_star_three if @second_card_star_three.displayed?
	}	
	end
  
  def third_card_star_five
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @third_card_star_five = self.driver.find_element(:css => self.db_object.elements.find_by_name('third card star five').by_css_locator)
	  @third_card_star_five if @third_card_star_five.displayed?
	}	
	end
  
  def third_card_star_four
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @third_card_star_four = self.driver.find_element(:css => self.db_object.elements.find_by_name('third card star four').by_css_locator)
	  @third_card_star_four if @third_card_star_four.displayed?
	}	
	end
  
  def third_card_star_three
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @third_card_star_three = self.driver.find_element(:css => self.db_object.elements.find_by_name('third card star three').by_css_locator)
	  @third_card_star_three if @third_card_star_three.displayed?
	}	
	end
  
  def help_sorting_icon
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @help_sorting_icon = self.driver.find_element(:class => self.db_object.elements.find_by_name('help sorting icon').by_class_locator)
	  @help_sorting_icon if @help_sorting_icon.displayed?
	}	
	end    
  
  def help_sorting_overlay_title
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @help_sorting_overlay_title = self.driver.find_element(:css => self.db_object.elements.find_by_name('help sorting overlay title').by_css_locator)
	  @help_sorting_overlay_title if @help_sorting_overlay_title.displayed?
	}	
	end    

  def see_all_flights_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @see_all_flights_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('see all flights button').by_css_locator)
	  @see_all_flights_button if @see_all_flights_button.displayed?
	}	
	end   
  
  def explanation_text_label
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @explanation_text_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('explanation text label').by_css_locator)
	  @explanation_text_label if @explanation_text_label.displayed?
	}	
	end    

  def your_hotel_text_element
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @your_hotel_text_element = self.driver.find_element(:css => self.db_object.elements.find_by_name('your hotel text element').by_css_locator)
	  @your_hotel_text_element if @your_hotel_text_element.displayed?
	}	
	end    
  
	def hotel_card_titles
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @hotel_card_titles = self.driver.find_elements(:css => self.db_object.elements.find_by_name("hotel card titles").by_css_locator)
	  @hotel_card_titles if @hotel_card_titles[0].displayed?
	}
	end   
  
	def more_details_links
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @more_details_links = self.driver.find_elements(:css => self.db_object.elements.find_by_name("more details links").by_css_locator)
	  @more_details_links if @more_details_links[0].displayed?
	}
	end       
  
	def rate_card_prices
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @rate_card_prices = self.driver.find_elements(:css => self.db_object.elements.find_by_name("rate card prices").by_css_locator)
	  @rate_card_prices if @rate_card_prices[0].displayed?
	}
	end  

	def booked_separately_prices
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @booked_separately_prices = self.driver.find_elements(:css => self.db_object.elements.find_by_name("booked separately prices").by_css_locator)
	  @booked_separately_prices if @booked_separately_prices[0].displayed?
	}
	end  

	def package_savings_prices
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @package_savings_prices = self.driver.find_elements(:css => self.db_object.elements.find_by_name("package savings prices").by_css_locator)
	  @package_savings_prices if @package_savings_prices[0].displayed?
	}
	end  

	def booked_separately_currencies
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @booked_separately_prices = self.driver.find_elements(:css => self.db_object.elements.find_by_name("booked separately currencies").by_css_locator)
	  @booked_separately_prices if @booked_separately_prices[0].displayed?
	}
	end  

	def package_savings_currencies
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @package_savings_prices = self.driver.find_elements(:css => self.db_object.elements.find_by_name("package savings currencies").by_css_locator)
	  @package_savings_prices if @package_savings_prices[0].displayed?
	}
	end  

	def results_package_cards
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @results_package_cards = self.driver.find_elements(:css => self.db_object.elements.find_by_name("results package cards").by_css_locator)
	  @results_package_cards if @results_package_cards[0].displayed?
	}
	end  

	def number_of_travelers_link
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @number_of_travelers_link = self.driver.find_element(:id => self.db_object.elements.find_by_name("number of travelers link").by_id_locator)
	  @number_of_travelers_link if @number_of_travelers_link.displayed?
	}
	end     

	def adults_combobox(index)  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @adults_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name("adults combobox #{index}").by_css_locator)
	  @adults_combobox if @adults_combobox.displayed?
	}	
	end  

	def seniors_combobox(index)  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @seniors_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name("seniors combobox #{index}").by_css_locator)
	  @seniors_combobox if @seniors_combobox.displayed?
	}	
	end  
  
	def children_combobox(index)  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @children_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name("children combobox #{index}").by_css_locator)
	  @children_combobox if @children_combobox.displayed?
	}	
	end  

	def children_age_combobox(room,index) 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @children_age_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name("room #{room} - children age combobox #{index}").by_css_locator)
	  @children_age_combobox if @children_age_combobox.displayed?
	}	
	end	  
   
	def children_seated_option(room,index)
	  wait = Selenium::WebDriver::Wait.new(:timeout => 5)
	  wait.until {
	  @children_seated_option = self.driver.find_element(:css => self.db_object.elements.find_by_name("room #{room} - child seated option #{index}").by_css_locator)
	  @children_seated_option if @children_seated_option.displayed?
	}
	end  

	def children_seated_option_input(room,index)
	  wait = Selenium::WebDriver::Wait.new(:timeout => 5)
	  wait.until {
	  @children_seated_option_input = self.driver.find_element(:css => self.db_object.elements.find_by_name("room #{room} - child seated option input #{index}").by_css_locator)
	  @children_seated_option_input if @children_seated_option_input.displayed?
	}
	end  
  
	def children_lap_option(room,index)
	  wait = Selenium::WebDriver::Wait.new(:timeout => 5)
	  wait.until {
	  @children_lap_option = self.driver.find_element(:css => self.db_object.elements.find_by_name("room #{room} - child lap option #{index}").by_css_locator)
	  @children_lap_option if @children_lap_option.displayed?
	}
	end 

	def children_lap_option_input(room,index)
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @children_lap_option_input = self.driver.find_element(:css => self.db_object.elements.find_by_name("room #{room} - child lap option input #{index}").by_css_locator)
	  @children_lap_option_input if @children_lap_option_input.displayed?
	}
	end     
  
	def number_of_rooms_link
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @number_of_rooms_link = self.driver.find_elements(:css => self.db_object.elements.find_by_name("number of rooms link").by_css_locator)[0]
	  @number_of_rooms_link if @number_of_rooms_link.displayed?
	}
	end  

	def update_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @update_button = self.driver.find_element(:class => self.db_object.elements.find_by_name("update button").by_class_locator)
	  @update_button if @update_button.displayed?
	}
	end  
  
  def room_1_seniors_combobox  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @room_1_seniors_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('room 1 seniors combobox').by_css_locator)
	  @room_1_seniors_combobox if @room_1_seniors_combobox.displayed?
	}	
	end 
  
  def room_2_seniors_combobox  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @room_2_seniors_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('room 2 seniors combobox').by_css_locator)
	  @room_2_seniors_combobox if @room_2_seniors_combobox.displayed?
	}	
	end
  
  def room_3_seniors_combobox  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @room_3_seniors_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('room 3 seniors combobox').by_css_locator)
	  @room_3_seniors_combobox if @room_3_seniors_combobox.displayed?
	}	
	end
  
  def room_4_seniors_combobox  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @room_4_seniors_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('room 4 seniors combobox').by_css_locator)
	  @room_4_seniors_combobox if @room_4_seniors_combobox.displayed?
	}	
	end
  
  def room_1_children_combobox  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @room_1_children_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('room 1 children combobox').by_css_locator)
	  @room_1_children_combobox if @room_1_children_combobox.displayed?
	}	
	end 
  
  def room_2_children_combobox  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @room_2_children_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('room 2 children combobox').by_css_locator)
	  @room_2_children_combobox if @room_2_children_combobox.displayed?
	}	
	end
  
  def room_3_children_combobox  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @room_3_children_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('room 3 children combobox').by_css_locator)
	  @room_3_children_combobox if @room_3_children_combobox.displayed?
	}	
	end
  
  def room_4_children_combobox  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @room_4_children_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('room 4 children combobox').by_css_locator)
	  @room_4_children_combobox if @room_4_children_combobox.displayed?
	}	
	end
  
  def first_dp_hotel_card  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @first_dp_hotel_card = self.driver.find_element(:css => self.db_object.elements.find_by_name('first dp hotel card').by_css_locator)
	  @first_dp_hotel_card if @first_dp_hotel_card.displayed?
	}	
	end
  
  def travelers_count_link  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @travelers_count_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('travelers count link').by_css_locator)
	  @travelers_count_link if @travelers_count_link.displayed?
	}	
	end
  
  def arrival_city_textbox
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @arrival_city_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name("arrival city textbox").by_id_locator)
	  @arrival_city_textbox if @arrival_city_textbox.displayed?
	}
	end
	
	def departure_city_textbox
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @departure_city_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name("departure city textbox").by_id_locator)
	  @departure_city_textbox if @departure_city_textbox.displayed?
	}	
	end
  
  def arrival_city_clean_text_input
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @arrival_city_clean_text_input = self.driver.find_element(:css => self.db_object.elements.find_by_name("arrival city clean text input").by_css_locator)
	  @arrival_city_clean_text_input if @arrival_city_clean_text_input.displayed?
	}
	end
  
  def departure_city_clean_text_input
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @departure_city_clean_text_input = self.driver.find_element(:css => self.db_object.elements.find_by_name("departure city clean text input").by_css_locator)
	  @departure_city_clean_text_input if @departure_city_clean_text_input.displayed?
	}
	end
  
  def results_error_messages
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @results_error_messages = self.driver.find_elements(:css => self.db_object.elements.find_by_name('results error messages').by_css_locator)
	  @results_error_messages if @results_error_messages[0].displayed?
	}	
	end
  
  def check_in_date_calendar
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @check_in_date_calendar = self.driver.find_element(:id => self.db_object.elements.find_by_name('check-in date calendar').by_id_locator)
	  @check_in_date_calendar if @check_in_date_calendar.displayed?
	}
	end
  
  def check_out_date_calendar
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @check_out_date_calendar = self.driver.find_element(:id => self.db_object.elements.find_by_name('check-out date calendar').by_id_locator)
	  @check_out_date_calendar if @check_out_date_calendar.displayed?
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
  
  def departure_flight_time_label
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @departure_flight_time_label = self.driver.find_element(:css => self.db_object.elements.find_by_name("departure flight time label").by_css_locator)
	  @departure_flight_time_label if @departure_flight_time_label.displayed?
	}
	end 
 
  def return_flight_time_label
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @return_flight_time_label = self.driver.find_element(:css => self.db_object.elements.find_by_name("return flight time label").by_css_locator)
	  @return_flight_time_label if @return_flight_time_label.displayed?
	}
	end  
  
  def flight_times_label
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @flight_times_label = self.driver.find_elements(:css => self.db_object.elements.find_by_name("flight times label").by_css_locator)
	  @flight_times_label if @flight_times_label[0].displayed?
	}
	end
  
  def interstitial_main_text_label
  	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @interstitial_main_text_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('interstitial main text label').by_css_locator)
	  @interstitial_main_text_label if @interstitial_main_text_label.displayed?
	}	
  end 
  
  def start_a_new_search_link 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @start_a_new_search_link = self.driver.find_element(:link_text => self.db_object.elements.find_by_name('start a new search link').by_link_text_locator)
	  @start_a_new_search_link if @start_a_new_search_link.displayed?
      }
  end
  
  def roundtrip_flight_details_link 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @roundtrip_flight_details_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('roundtrip flight details link').by_css_locator)
	  @roundtrip_flight_details_link if @roundtrip_flight_details_link.displayed?
      }
  end
  
  def air_rate_card_departure_slice_alerts_city_name_airport_code
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @air_rate_card_departure_slice_alerts_city_name_airport_code = self.driver.find_elements(:css => self.db_object.elements.find_by_name('air rate card departure slice alerts city name airport code').by_css_locator)
	  @air_rate_card_departure_slice_alerts_city_name_airport_code if @air_rate_card_departure_slice_alerts_city_name_airport_code[0].displayed?
	}
	end

  def air_rate_card_departure_slice_alerts_cabin_class
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @air_rate_card_departure_slice_alerts_cabin_class = self.driver.find_elements(:css => self.db_object.elements.find_by_name('air rate card departure slice alerts cabin class').by_css_locator)
	  @air_rate_card_departure_slice_alerts_cabin_class if @air_rate_card_departure_slice_alerts_cabin_class[0].displayed?
	}
	end

 def air_rate_card_departure_slice_alerts_time
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @air_rate_card_departure_slice_alerts_time = self.driver.find_elements(:css => self.db_object.elements.find_by_name('air rate card departure slice alerts time').by_css_locator)
	  @air_rate_card_departure_slice_alerts_time if @air_rate_card_departure_slice_alerts_time[0].displayed?
	}
	end

  def air_rate_card_departure_slice_alerts_legs_equipment
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @air_rate_card_departure_slice_alerts_legs_equipment = self.driver.find_elements(:css => self.db_object.elements.find_by_name('air rate card departure slice alerts legs equipment').by_css_locator)
	  @air_rate_card_departure_slice_alerts_legs_equipment if @air_rate_card_departure_slice_alerts_legs_equipment[0].displayed?
	}
	end

 def air_rate_card_departure_slice_alerts_mileage
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @air_rate_card_departure_slice_alerts_mileage = self.driver.find_elements(:css => self.db_object.elements.find_by_name('air rate card departure slice alerts mileage').by_css_locator)
	  @air_rate_card_departure_slice_alerts_mileage if @air_rate_card_departure_slice_alerts_mileage[0].displayed?
	}
 end
 
 def air_rate_card_departure_slice_alerts_legs_food_beverage_service
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @air_rate_card_departure_slice_alerts_legs_food_beverage_service = self.driver.find_elements(:css => self.db_object.elements.find_by_name('air rate card departure slice alerts legs food beverage service').by_css_locator)
	  @air_rate_card_departure_slice_alerts_legs_food_beverage_service if @air_rate_card_departure_slice_alerts_legs_food_beverage_service[0].displayed?
	}
	end 

  def air_rate_card_departure_slice_logo_1_img
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @air_rate_card_departure_slice_logo_1_img  = self.driver.find_element(:css => self.db_object.elements.find_by_name('air rate card departure slice logo 1 img').by_css_locator)
	  @air_rate_card_departure_slice_logo_1_img  if @air_rate_card_departure_slice_logo_1_img .displayed?
      }
  end

  def air_rate_card_departure_slice_logo_2_img
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @air_rate_card_departure_slice_logo_2_img  = self.driver.find_element(:css => self.db_object.elements.find_by_name('air rate card departure slice logo 2 img').by_css_locator)
	  @air_rate_card_departure_slice_logo_2_img  if @air_rate_card_departure_slice_logo_2_img .displayed?
      }
  end
  
 def air_rate_card_return_slice_alerts_city_name_airport_code
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @air_rate_card_return_slice_alerts_city_name_airport_code = self.driver.find_elements(:css => self.db_object.elements.find_by_name('air rate card return slice alerts city name airport code').by_css_locator)
	  @air_rate_card_return_slice_alerts_city_name_airport_code if @air_rate_card_return_slice_alerts_city_name_airport_code[0].displayed?
	}
	end 

  def air_rate_card_return_slice_alerts_cabin_class
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @air_rate_card_return_slice_alerts_cabin_class = self.driver.find_elements(:css => self.db_object.elements.find_by_name('air rate card return slice alerts cabin class').by_css_locator)
	  @air_rate_card_return_slice_alerts_cabin_class if @air_rate_card_return_slice_alerts_cabin_class[0].displayed?
	}
	end 

  def air_rate_card_return_slice_alerts_time
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @air_rate_card_return_slice_alerts_time = self.driver.find_elements(:css => self.db_object.elements.find_by_name('air rate card return slice alerts time').by_css_locator)
	  @air_rate_card_return_slice_alerts_time if @air_rate_card_return_slice_alerts_time[0].displayed?
	}
	end 

  def air_rate_card_return_slice_alerts_legs_equipment
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @air_rate_card_return_slice_alerts_legs_equipment = self.driver.find_elements(:css => self.db_object.elements.find_by_name('air rate card return slice alerts legs equipment').by_css_locator)
	  @air_rate_card_return_slice_alerts_legs_equipment if @air_rate_card_return_slice_alerts_legs_equipment[0].displayed?
	}
	end 

  def air_rate_card_return_slice_alerts_mileage
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @air_rate_card_return_slice_alerts_mileage = self.driver.find_elements(:css => self.db_object.elements.find_by_name('air rate card return slice alerts mileage').by_css_locator)
	  @air_rate_card_return_slice_alerts_mileage if @air_rate_card_return_slice_alerts_mileage[0].displayed?
	}
	end 

  def air_rate_card_return_slice_alerts_legs_food_beverage_service
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @air_rate_card_return_slice_alerts_legs_food_beverage_service = self.driver.find_elements(:css => self.db_object.elements.find_by_name('air rate card return slice alerts legs food beverage service').by_css_locator)
	  @air_rate_card_return_slice_alerts_legs_food_beverage_service if @air_rate_card_return_slice_alerts_legs_food_beverage_service[0].displayed?
	}
	end 

  def air_rate_card_return_slice_logo_1_img
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @air_rate_card_return_slice_logo_1_img  = self.driver.find_element(:css => self.db_object.elements.find_by_name('air rate card return slice logo 1 img').by_css_locator)
	  @air_rate_card_return_slice_logo_1_img  if @air_rate_card_return_slice_logo_1_img .displayed?
      }
  end
  
  def air_rate_card_return_slice_logo_2_img
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @air_rate_card_return_slice_logo_2_img  = self.driver.find_element(:css => self.db_object.elements.find_by_name('air rate card return slice logo 2 img').by_css_locator)
	  @air_rate_card_return_slice_logo_2_img  if @air_rate_card_return_slice_logo_2_img .displayed?
      }
  end
  
  def air_rate_card_segments_with_logo
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @air_rate_card_segments_with_logo = self.driver.find_elements(:css => self.db_object.elements.find_by_name('air rate card segments with logo').by_css_locator)
	  @air_rate_card_segments_with_logo if @air_rate_card_segments_with_logo[0].displayed?
	}
	end

  def air_rate_card_slice_alerts_connection  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @air_rate_card_slice_alerts_connection = self.driver.find_elements(:css => self.db_object.elements.find_by_name('air rate card slice alerts connection').by_css_locator)
	  @air_rate_card_slice_alerts_connection if @air_rate_card_slice_alerts_connection[0].displayed?
	}
	end

  def hotel_rate_card_show_hotel_highlights_labels
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @hotel_rate_card_show_hotel_highlights_labels = self.driver.find_elements(:css => self.db_object.elements.find_by_name('hotel rate card show hotel highlights labels').by_css_locator)
	  @hotel_rate_card_show_hotel_highlights_labels if @hotel_rate_card_show_hotel_highlights_labels[0].displayed?
	}
  end

  def view_hide_roundtrip_flight_details_labels
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
      @view_hide_roundtrip_flight_details_labels = self.driver.find_elements(:css => self.db_object.elements.find_by_name('view hide roundtrip flight details labels').by_css_locator)
      @view_hide_roundtrip_flight_details_labels if @view_hide_roundtrip_flight_details_labels[0].displayed?
    }
  end
  
  def hotel_rate_card_dp_hotel_selected 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_rate_card_dp_hotel_selected = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel rate card dp hotel selected').by_css_locator)
	  @hotel_rate_card_dp_hotel_selected if @hotel_rate_card_dp_hotel_selected.displayed?
	}	
	end
  
  def hotel_rate_card_your_room_details_label 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_rate_card_your_room_details_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel rate card your room details label').by_css_locator)
	  @hotel_rate_card_your_room_details_label if @hotel_rate_card_your_room_details_label.displayed?
	}	
	end
  
  def hotel_rate_card_hotel_first_name_best_value
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_rate_card_first_name_best_value = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel rate card hotel first name best value').by_css_locator)
	  @hotel_rate_card_first_name_best_value if @hotel_rate_card_first_name_best_value.displayed?
	}	
	end
  
  def hotel_rate_card_your_dp_hotel_name_selected
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_rate_card_your_dp_hotel_name_selected = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel rate card your dp hotel name selected').by_css_locator)
	  @hotel_rate_card_your_dp_hotel_name_selected if @hotel_rate_card_your_dp_hotel_name_selected.displayed?
	}	
	end
  
  def see_all_hotels_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @see_all_hotels_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('see all hotels button').by_css_locator)
	  @see_all_hotels_button if @see_all_hotels_button.displayed?
	}	
	end
  
  def hotel_rate_card_your_dp_hotel_selected_img
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_rate_card_your_dp_hotel_selected_img = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel rate card your dp hotel selected img').by_css_locator)
	  @hotel_rate_card_your_dp_hotel_selected_img if @hotel_rate_card_your_dp_hotel_selected_img.displayed?
	}	
	end
  
  def hotel_rate_card_your_dp_hotel_selected_address
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_rate_card_your_dp_hotel_selected_address = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel rate card your dp hotel selected address').by_css_locator)
	  @hotel_rate_card_your_dp_hotel_selected_address if @hotel_rate_card_your_dp_hotel_selected_address.displayed?
	}	
	end
  
  def hotel_rate_card_your_dp_hotel_selected_number_of_rooms
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_rate_card_your_dp_hotel_selected_number_of_rooms = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel rate card your dp hotel selected number of rooms').by_css_locator)
	  @hotel_rate_card_your_dp_hotel_selected_number_of_rooms if @hotel_rate_card_your_dp_hotel_selected_number_of_rooms.displayed?
	}	
	end
  
  def hotel_rate_card_your_dp_hotel_selected_check_in_date
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_rate_card_your_dp_hotel_selected_check_in_date = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel rate card your dp hotel selected check in date').by_css_locator)
	  @hotel_rate_card_your_dp_hotel_selected_check_in_date if @hotel_rate_card_your_dp_hotel_selected_check_in_date.displayed?
	}	
	end
  
  def hotel_rate_card_your_dp_hotel_selected_check_out_date
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_rate_card_your_dp_hotel_selected_check_out_date = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel rate card your dp hotel selected check out date').by_css_locator)
	  @hotel_rate_card_your_dp_hotel_selected_check_out_date if @hotel_rate_card_your_dp_hotel_selected_check_out_date.displayed?
	}	
	end
  
   def hotel_rate_card_your_dp_hotel_selected_check_in_calendar_icon
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_rate_card_your_dp_hotel_selected_check_in_calendar_icon = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel rate card your dp hotel selected check in calendar icon').by_css_locator)
	  @hotel_rate_card_your_dp_hotel_selected_check_in_calendar_icon if @hotel_rate_card_your_dp_hotel_selected_check_in_calendar_icon.displayed?
	}	
	end
  
  def hotel_rate_card_your_dp_hotel_selected_check_out_calendar_icon
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_rate_card_your_dp_hotel_selected_check_out_calendar_icon = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel rate card your dp hotel selected check out calendar icon').by_css_locator)
	  @hotel_rate_card_your_dp_hotel_selected_check_out_calendar_icon if @hotel_rate_card_your_dp_hotel_selected_check_out_calendar_icon.displayed?
	}	
	end
  
  def hotel_rate_card_your_dp_hotel_selected_number_of_nights
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_rate_card_your_dp_hotel_selected_number_of_nights = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel rate card your dp hotel selected number of nights').by_css_locator)
	  @hotel_rate_card_your_dp_hotel_selected_number_of_nights if @hotel_rate_card_your_dp_hotel_selected_number_of_nights.displayed?
	}	
	end
  
  def hotel_rate_card_your_dp_hotel_selected_room_description
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_rate_card_your_dp_hotel_selected_room_description = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel rate card your dp hotel selected room description').by_css_locator)
	  @hotel_rate_card_your_dp_hotel_selected_room_description if @hotel_rate_card_your_dp_hotel_selected_room_description.displayed?
	}	
	end
  
  def hotel_rate_card_cost_text_labels
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
      @hotel_rate_card_cost_text_labels = self.driver.find_elements(:css => self.db_object.elements.find_by_name('hotel rate card cost text labels').by_css_locator)
      @hotel_rate_card_cost_text_labels if @hotel_rate_card_cost_text_labels[0].displayed?
    }
  end
  
  def hotel_rate_card_currency_booked_separately
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_rate_card_currency_booked_separately = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel rate card currency booked separately').by_css_locator)
	  @hotel_rate_card_currency_booked_separately if @hotel_rate_card_currency_booked_separately.displayed?
	}	
	end
  
  def hotel_rate_card_currency_package_savings
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_rate_card_currency_package_savings = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel rate card currency package savings').by_css_locator)
	  @hotel_rate_card_currency_package_savings if @hotel_rate_card_currency_package_savings.displayed?
	}	
	end
  
  def hotel_rate_card_average_per_person
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_rate_card_average_per_person = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel rate card average per person').by_css_locator)
	  @hotel_rate_card_average_per_person if @hotel_rate_card_average_per_person.displayed?
	}	
	end
  
  def room_1_adults_combobox  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @room_1_adults_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('room 1 adults combobox').by_css_locator)
	  @room_1_adults_combobox if @room_1_adults_combobox.displayed?
	}	
	end
  
  def selection_options_adults_1_combobox
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
      @selection_options_adults_1_combobox = self.driver.find_elements(:css => self.db_object.elements.find_by_name('selection options adults 1 combobox').by_css_locator)
      @selection_options_adults_1_combobox if @selection_options_adults_1_combobox[0].displayed?
    }
  end
  
  def hotel_rate_card_horizontal_line  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @hotel_rate_card_horizontal_line = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel rate card horizontal line').by_css_locator)
	  @hotel_rate_card_horizontal_line if @hotel_rate_card_horizontal_line.displayed?
	}	
	end
  
  def all_hotel_your_flight_rate_card_num_tickets_alert
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @all_hotel_your_flight_rate_card_num_tickets_alert = self.driver.find_element(:css => self.db_object.elements.find_by_name('all hotel your flight rate card num tickets alert').by_css_locator)
	  @all_hotel_your_flight_rate_card_num_tickets_alert if @all_hotel_your_flight_rate_card_num_tickets_alert.displayed?
	}	
	end
  
   def all_flight_rate_card_num_tickets_alerts
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
      @all_flight_rate_card_num_tickets_alerts = self.driver.find_elements(:css => self.db_object.elements.find_by_name('all flight rate card num tickets alerts').by_css_locator)
      @all_flight_rate_card_num_tickets_alerts if @all_flight_rate_card_num_tickets_alerts[0].displayed?
    }
  end
  
  def all_flight_matrix_rows
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
      @all_flight_matrix_rows = self.driver.find_elements(:css => self.db_object.elements.find_by_name('all flight matrix rows').by_css_locator)
      @all_flight_matrix_rows if @all_flight_matrix_rows[0].displayed?
    }
  end
  
  def all_flight_matrix_top_row_airline_names
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
      @all_flight_matrix_top_row_airline_names = self.driver.find_elements(:css => self.db_object.elements.find_by_name('all flight matrix top row airline names').by_css_locator)
      @all_flight_matrix_top_row_airline_names if @all_flight_matrix_top_row_airline_names[0].displayed?
    }
  end
  
  def all_flight_matrix_top_row_airline_logos
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
      @all_flight_matrix_top_row_airline_logos = self.driver.find_elements(:css => self.db_object.elements.find_by_name('all flight matrix top row airline logos').by_css_locator)
      @all_flight_matrix_top_row_airline_logos if @all_flight_matrix_top_row_airline_logos[0].displayed?
    }
  end
  
  def all_flight_rate_card_airline_names
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
      @all_flight_rate_card_airline_names = self.driver.find_elements(:css => self.db_object.elements.find_by_name('all flight rate card airline names').by_css_locator)
      @all_flight_rate_card_airline_names if @all_flight_rate_card_airline_names[0].displayed?
    }
  end
  
  def all_flight_rate_card_airline_logos
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
      @all_flight_rate_card_airline_logos = self.driver.find_elements(:css => self.db_object.elements.find_by_name('all flight rate card airline logos').by_css_locator)
      @all_flight_rate_card_airline_logos if @all_flight_rate_card_airline_logos[0].displayed?
    }
  end
  
  def all_flight_matrix_ammounts
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
      @all_flight_matrix_ammounts = self.driver.find_elements(:css => self.db_object.elements.find_by_name('all flight matrix ammounts').by_css_locator)
      @all_flight_matrix_ammounts if @all_flight_matrix_ammounts[0].displayed?
    }
  end
  
  def all_flight_matrix_slider  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @all_flight_matrix_slider = self.driver.find_element(:css => self.db_object.elements.find_by_name('all flight matrix slider').by_css_locator)
	  @all_flight_matrix_slider if @all_flight_matrix_slider.displayed?
	}	
	end
  
  def all_flight_matrix_airline_columns
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
      @all_flight_matrix_airline_columns = self.driver.find_elements(:css => self.db_object.elements.find_by_name('all flight matrix airline columns').by_css_locator)
      @all_flight_matrix_airline_columns if @all_flight_matrix_airline_columns[0].displayed?
    }
  end
  
  def all_flight_matrix_stop_columns
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
      @all_flight_matrix_stop_columns = self.driver.find_elements(:css => self.db_object.elements.find_by_name('all flight matrix stop columns').by_css_locator)
      @all_flight_matrix_stop_columns if @all_flight_matrix_stop_columns[0].displayed?
    }
  end
  
  def all_flight_baggage_charges_link  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @all_flight_baggage_charges_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('all flight baggage charges link').by_css_locator)
	  @all_flight_baggage_charges_link if @all_flight_baggage_charges_link.displayed?
	}	
	end
  
  def all_flight_taxes_and_fees_link  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @all_flight_taxes_and_fees_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('all flight taxes and fees link').by_css_locator)
	  @all_flight_taxes_and_fees_link if @all_flight_taxes_and_fees_link.displayed?
	}	
	end
  
  def all_flight_packages_taxes_and_fees_close_button  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @all_flight_packages_taxes_and_fees_close_button = self.driver.find_element(:xpath => self.db_object.elements.find_by_name('all flight packages taxes and fees close button').by_xpath_locator)
	  @all_flight_packages_taxes_and_fees_close_button if @all_flight_packages_taxes_and_fees_close_button.displayed?
	}	
	end  
  
  def all_flight_baggage_fees_close_button  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @all_flight_baggage_fees_close_button = self.driver.find_element(:xpath => self.db_object.elements.find_by_name('all flight baggage fees close button').by_xpath_locator)
	  @all_flight_baggage_fees_close_button if @all_flight_baggage_fees_close_button.displayed?
	}	
	end  
  
  def all_flight_baggage_fees_title  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @all_flight_baggage_fees_title = self.driver.find_element(:css => self.db_object.elements.find_by_name('all flight baggage fees title').by_css_locator)
	  @all_flight_baggage_fees_title if @all_flight_baggage_fees_title.displayed?
	}	
	end
  
  def all_flight_packages_taxes_and_fees_title  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @all_flight_packages_taxes_and_fees_title = self.driver.find_element(:css => self.db_object.elements.find_by_name('all flight packages taxes and fees title').by_css_locator)
	  @all_flight_packages_taxes_and_fees_title if @all_flight_packages_taxes_and_fees_title.displayed?
	}	
	end
  
  def all_flight_collapse_expand_button  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @all_flight_collapse_expand_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('all flight collapse expand button').by_css_locator)
	  @all_flight_collapse_expand_button if @all_flight_collapse_expand_button.displayed?
	}	
	end
  
  def all_flight_matrix  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @all_flight_matrix = self.driver.find_element(:css => self.db_object.elements.find_by_name('all flight matrix').by_css_locator)
	  @all_flight_matrix if @all_flight_matrix.displayed?
	}	
	end 
  
  def book_this_package_buttons 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @book_this_package_buttons = self.driver.find_elements(:css => self.db_object.elements.find_by_name('book this package buttons').by_css_locator)
	  @book_this_package_buttons if @book_this_package_buttons[0].displayed?
	}	
	end  
   
  def hotel_card_flight_and_hotel_costs_upper_labels 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @hotel_card_flight_and_hotel_costs_upper_labels = self.driver.find_elements(:css => self.db_object.elements.find_by_name('hotel card flight and hotel costs upper labels').by_css_locator)
	  @hotel_card_flight_and_hotel_costs_upper_labels if @hotel_card_flight_and_hotel_costs_upper_labels[0].displayed?
	}	
	end     
end