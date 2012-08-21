require 'rubygems'
require 'selenium-webdriver'
require 'spec_helper'
require_relative '../../../lib/base_page'

TIMEOUT = RSpec.configuration.timeout

class HotelDescriptionPage < BasePage  
  def initialize(driver, test_env)   
    @db_object = Page.find_by_name('hotel description page')
    @url = Environment.find_by_name(test_env).base_url + Page.find_by_name('hotel description page').url
    @title = Page.find_by_name('hotel description page').title
    @driver = driver 
  end  
  
  def back_to_search_results_link
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @back_to_search_results_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('back to search results link').by_css_locator)
	  @back_to_search_results_link if @back_to_search_results_link.displayed?
	}	
	end	 
  
  def description_tab
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @description_tab = self.driver.find_element(:css => self.db_object.elements.find_by_name('description tab').by_css_locator)
	  @description_tab if @description_tab.displayed?
	}	
	end	 
  
  def rooms_and_rates_tab
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @rooms_and_rates_tab = self.driver.find_element(:css => self.db_object.elements.find_by_name('rooms and rates tab').by_css_locator)
	  @rooms_and_rates_tab if @rooms_and_rates_tab.displayed?
	}	
	end	
  
  def map_tab
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @map_tab = self.driver.find_element(:css => self.db_object.elements.find_by_name('map tab').by_css_locator)
	  @map_tab if @map_tab.displayed?
	}	
	end	
  
  def description_tab
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @description_tab = self.driver.find_element(:css => self.db_object.elements.find_by_name('description tab').by_css_locator)
	  @description_tab if @description_tab.displayed?
	}	
	end	
  
  def amenities_tab
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @amenities_tab = self.driver.find_element(:css => self.db_object.elements.find_by_name('amenities tab').by_css_locator)
	  @amenities_tab if @amenities_tab.displayed?
	}	
	end	
  
  def lowest_rate_guaranteed_tab
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @lowest_rate_guaranteed_tab = self.driver.find_element(:css => self.db_object.elements.find_by_name('lowest rate guaranteed tab').by_css_locator)
	  @lowest_rate_guaranteed_tab if @lowest_rate_guaranteed_tab.displayed?
	}	
	end	
  
  def result_details_lowest_rates
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @result_details_lowest_rates = self.driver.find_elements(:css => self.db_object.elements.find_by_name('result details lowest rates').by_css_locator)
	  @result_details_lowest_rates if @result_details_lowest_rates[0].displayed?
	}	
	end 
  
  def lowest_rate_guaranteed_results_detail_cars
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @lowest_rate_guaranteed_results_detail_cars = self.driver.find_elements(:css => self.db_object.elements.find_by_name('lowest rate guaranteed results detail cars').by_css_locator)
	  @lowest_rate_guaranteed_results_detail_cars if @lowest_rate_guaranteed_results_detail_cars[0].displayed?
	}	
	end 
  
 def booking_the_selected_room_error_message
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @booking_the_selected_room_error_message = self.driver.find_element(:css => self.db_object.elements.find_by_name('booking the selected room error message').by_css_locator)
	  @booking_the_selected_room_error_message if @booking_the_selected_room_error_message.displayed?
	}	
	end	
  
  def room_combobox
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @room_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('room combobox').by_css_locator)
	  @room_combobox if @room_combobox.displayed?
	}	
	end	
  
  def room_combobox_selection_options
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @room_combobox_selection_options = self.driver.find_elements(:css => self.db_object.elements.find_by_name('room combobox selection options').by_css_locator)
	  @room_combobox_selection_options if @room_combobox_selection_options[0].displayed?
	}	
	end 
  
  def book_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @book_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('book button').by_css_locator)
	  @book_button if @book_button.displayed?
	}	
	end
  
  def description_room_details_label
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @description_room_details_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('description room details label').by_css_locator)
	  @description_room_details_label if @description_room_details_label.displayed?
	}	
	end
  
  def update_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @update_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('update button').by_css_locator)
	  @update_button if @update_button.displayed?
	}	
	end
  
  def room_details_label
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @room_details_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('room details label').by_css_locator)
	  @room_details_label if @room_details_label.displayed?
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
  
   def number_of_days_error_message
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @number_of_days_error_message = self.driver.find_element(:css => self.db_object.elements.find_by_name('number of days error message').by_css_locator)
	  @number_of_days_error_message if @number_of_days_error_message.displayed?
	}
	end
  
   def see_nightly_rates_link
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @see_nightly_rates_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('see nightly rates link').by_css_locator)
	  @see_nightly_rates_link if @see_nightly_rates_link.displayed?
	}
	end
  
  def nightly_rates_tab_text
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @nightly_rates_tab_text = self.driver.find_element(:css => self.db_object.elements.find_by_name('nightly rates tab text').by_css_locator)
	  @nightly_rates_tab_text if @nightly_rates_tab_text.displayed?
	}
	end
  
  def room_restrictions_and_cancellation_policy_link
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @room_restrictions_and_cancellation_policy_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('room restrictions and cancellation policy link').by_css_locator)
	  @room_restrictions_and_cancellation_policy_link if @room_restrictions_and_cancellation_policy_link.displayed?
	}
	end
  
  def dialog_restrictions_and_cancellation_policy_title
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @dialog_restrictions_and_cancellation_policy_title = self.driver.find_element(:css => self.db_object.elements.find_by_name('dialog restrictions and cancellation policy title').by_css_locator)
	  @dialog_restrictions_and_cancellation_policy_title if @dialog_restrictions_and_cancellation_policy_title.displayed?
	}
	end
  
  def map_view_1_img
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @map_view_1_img = self.driver.find_element(:css => self.db_object.elements.find_by_name('map view 1 img').by_css_locator)
	  @map_view_1_img if @map_view_1_img.displayed?
	}
	end  
  
  def map_view_2_img
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @map_view_2_img = self.driver.find_element(:css => self.db_object.elements.find_by_name('map view 2 img').by_css_locator)
	  @map_view_2_img if @map_view_2_img.displayed?
	}
	end  
  
  def dialog_restrictions_and_cancellation_policy_close_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @dialog_restrictions_and_cancellation_policy_close_button = self.driver.find_elements(:css => self.db_object.elements.find_by_name('dialog restrictions and ancellation policy close button').by_css_locator)
	  @dialog_restrictions_and_cancellation_policy_close_button if @dialog_restrictions_and_cancellation_policy_close_button[0].displayed?
	}	
	end 
  
  def nightly_rates_tab_close_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @nightly_rates_tab_close_button = self.driver.find_elements(:css => self.db_object.elements.find_by_name('nightly rates tab close button').by_css_locator)
	  @nightly_rates_tab_close_button if @nightly_rates_tab_close_button[0].displayed?
	}	
	end 
  
  def description_tab_hotel_name_title
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @description_tab_hotel_name_title = self.driver.find_element(:css => self.db_object.elements.find_by_name('description tab hotel name title').by_css_locator)
	  @description_tab_hotel_name_title if @description_tab_hotel_name_title.displayed?
	}
	end 
  
  def description_tab_hotel_description_general
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @description_tab_hotel_description_general = self.driver.find_element(:css => self.db_object.elements.find_by_name('description tab hotel description general').by_css_locator)
	  @description_tab_hotel_description_general if @description_tab_hotel_description_general.displayed?
	}
	end 
  
   def hotel_name_title
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @hotel_name_title = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel name title').by_css_locator)
	  @hotel_name_title if @hotel_name_title.displayed?
	}
	end 
  
  def list_of_amenities
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @list_of_amenities = self.driver.find_element(:css => self.db_object.elements.find_by_name('list of amenities').by_css_locator)
	  @list_of_amenities if @list_of_amenities.displayed?
	}
	end 
  
  def slides_control_view_photos
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @slides_control_view_photos = self.driver.find_elements(:css => self.db_object.elements.find_by_name('slides control view photos').by_css_locator)
	  @slides_control_view_photos if @slides_control_view_photos[0].displayed?
	}	
	end 
  
  def carousel_photo_reviews_buttons
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @carousel_photo_reviews_buttons = self.driver.find_elements(:css => self.db_object.elements.find_by_name('carousel photo reviews buttons').by_css_locator)
	  @carousel_photo_reviews_buttons if @carousel_photo_reviews_buttons[0].displayed?
	}	
	end 
  
  def pagination_reviews_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @pagination_reviews_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('pagination reviews button').by_css_locator)
	  @pagination_reviews_button if @pagination_reviews_button.displayed?
	}	
	end 
end