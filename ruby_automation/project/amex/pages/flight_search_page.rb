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

class FlightSearchPage < BasePage   
  def initialize(driver, test_env)   
    @db_object = Page.find_by_name('flight search page')
    @url = Environment.find_by_name(test_env).base_url + Page.find_by_name('flight search page').url
    @title = Page.find_by_name('flight search page').title
    @driver = driver 
  end  
  
  def book_a_flight(dataset_name)
    flight = Flight.find_by_name(dataset_name)
    # type of flight option

    if !(flight.round_trip_option.nil?)
      self.round_trip_option.click()
    end    
    if !(flight.one_way_option.nil?)
      self.one_way_option.click()
    end  
    if !(flight.multi_city_option.nil?)
      self.multi_city_option.click()
    end      
    # add another flight link
    if !(flight.add_another_flight.nil?)
      if flight.add_another_flight > 0
        for n in 1..flight.add_another_flight
          self.add_another_flight_link.click()
        end  
      end
    end  
       
    # departure city textbox    
    if !(flight.departure_city_1.nil?)
      self.enter_airport(self.departure_city_textbox(1),flight.departure_city_1)     
    end
    if !(flight.departure_city_2.nil?)
      self.enter_airport(self.departure_city_textbox(2),flight.departure_city_2)            
    end
    if !(flight.departure_city_3.nil?)
      self.enter_airport(self.departure_city_textbox(3),flight.departure_city_3)         
    end
    if !(flight.departure_city_4.nil?)
      self.enter_airport(self.departure_city_textbox(4),flight.departure_city_4)       
    end
    if !(flight.departure_city_5.nil?)
      self.enter_airport(self.departure_city_textbox(5),flight.departure_city_5)       
    end
    if !(flight.departure_city_6.nil?)
      self.enter_airport(self.departure_city_textbox(6),flight.departure_city_6)       
    end    
    # arrival city textbox
    if !(flight.arrival_city_1.nil?)
      self.enter_airport(self.arrival_city_textbox(1),flight.arrival_city_1)             
    end
    if !(flight.arrival_city_2.nil?)
      self.enter_airport(self.arrival_city_textbox(2),flight.arrival_city_2)       
    end
    if !(flight.arrival_city_3.nil?)
      self.enter_airport(self.arrival_city_textbox(3),flight.arrival_city_3)        
    end
    if !(flight.arrival_city_4.nil?)
      self.enter_airport(self.arrival_city_textbox(4),flight.arrival_city_4)        
    end
    if !(flight.arrival_city_5.nil?)
      self.enter_airport(self.arrival_city_textbox(5),flight.arrival_city_5)       
    end
    if !(flight.arrival_city_6.nil?)
      self.enter_airport(self.arrival_city_textbox(6),flight.arrival_city_6)         
    end    
    # departure date textbox
    if !(flight.departure_date_1.nil?)
      self.departure_date_textbox(1).send_keys(eval(flight.departure_date_1))  
    end 
    if !(flight.departure_date_2.nil?)
      self.departure_date_textbox(2).send_keys(eval(flight.departure_date_2))  
    end 
    if !(flight.departure_date_3.nil?)
      self.departure_date_textbox(3).send_keys(eval(flight.departure_date_3))  
    end 
    if !(flight.departure_date_4.nil?)
      self.departure_date_textbox(4).send_keys(eval(flight.departure_date_4))  
    end 
    if !(flight.departure_date_5.nil?)
      self.departure_date_textbox(5).send_keys(eval(flight.departure_date_5))  
    end 
    if !(flight.departure_date_6.nil?)
      self.departure_date_textbox(6).send_keys(eval(flight.departure_date_6))  
    end     
    # return date textbox
    if !(flight.return_date.nil?)
      self.return_date_textbox.send_keys(eval(flight.return_date)) 
    end   
    
    # departure time combobox
    if !(flight.departure_time_1.nil?)
      self.select_option(self.departure_time_combobox(1), flight.departure_time_1.to_s)
    end  
    if !(flight.departure_time_2.nil?)
      self.select_option(self.departure_time_combobox(2), flight.departure_time_2.to_s)
    end    
    if !(flight.departure_time_3.nil?)
      self.select_option(self.departure_time_combobox(3), flight.departure_time_3.to_s)
    end    
    if !(flight.departure_time_4.nil?)
      self.select_option(self.departure_time_combobox(4), flight.departure_time_4.to_s)
    end    
    if !(flight.departure_time_5.nil?)
      self.select_option(self.departure_time_combobox(5), flight.departure_time_5.to_s)
    end    
    if !(flight.departure_time_6.nil?)
      self.select_option(self.departure_time_combobox(6), flight.departure_time_6.to_s) 
    end        
  
    # return time combobox
    if !(flight.return_time.nil?)
      self.select_option(self.return_time_combobox, flight.return_time.to_s) 
    end       
             
    # adults combobox
    if !(flight.adults.nil?)
      if flight.adults > 0
        self.select_option(self.adults_combobox, flight.adults.to_s)       
      end  
    end  
    # seniors combobox
    if !(flight.seniors.nil?)
      if flight.seniors > 0
        self.select_option(self.seniors_combobox, flight.seniors.to_s)         
      end  
    end  
    # children combobox    
    if !(flight.children.nil?)
      if flight.children > 0
        self.select_option(self.children_combobox, flight.children.to_s)         
      end  
    end  
   
    # children age combobox 1    
    if !(flight.children_age_1.nil?)
      if flight.children_age_1 > 0
        if flight.children_age_1 > 1
          self.select_option(self.children_age_combobox(1), flight.children_age_1.to_s) 
        else
          self.select_option(self.children_age_combobox(1), "<2") 
        end                
      end  
    end 

    # children age combobox 2    
    if !(flight.children_age_2.nil?)
      if flight.children_age_2 > 0
        if flight.children_age_2 > 1
          self.select_option(self.children_age_combobox(2), flight.children_age_2.to_s) 
        else
          self.select_option(self.children_age_combobox(2), "<2") 
        end                
      end  
    end 
    
    # children age combobox 3    
    if !(flight.children_age_3.nil?)
      if flight.children_age_3 > 0
        if flight.children_age_3 > 1
          self.select_option(self.children_age_combobox(3), flight.children_age_3.to_s) 
        else
          self.select_option(self.children_age_combobox(3), "<2") 
        end                
      end  
    end 

    # children age combobox 4    
    if !(flight.children_age_4.nil?)
      if flight.children_age_4 > 0
        if flight.children_age_4 > 1
          self.select_option(self.children_age_combobox(4), flight.children_age_4.to_s) 
        else
          self.select_option(self.children_age_combobox(4), "<2") 
        end                
      end  
    end    

    # children seated option 1    
    if !(flight.children_seated_option_1.nil?)
      self.children_seated_option(1).click()         
    end 

    # children seated option 2    
    if !(flight.children_seated_option_2.nil?)
      self.children_seated_option(2).click()         
    end 

    # children seated option 3
    if !(flight.children_seated_option_3.nil?)
      self.children_seated_option(3).click()        
    end 

    # children seated option 4
    if !(flight.children_seated_option_4.nil?)
      self.children_seated_option(4).click()         
    end    
        
    # children lap option 1    
    if !(flight.children_lap_option_1.nil?)
      self.children_lap_option(1).click()      
    end 

    # children lap option 2    
    if !(flight.children_lap_option_2.nil?)
      self.children_lap_option(2).click()        
    end 

    # children lap option 3
    if !(flight.children_lap_option_3.nil?)
      self.children_lap_option(3).click()    
    end 

    # children lap option 4
    if !(flight.children_lap_option_4.nil?)
      self.children_lap_option(4).click()        
    end        

    # fare class combobox
    if !(flight.fare_class.nil?)
      self.select_option(self.fare_class_combobox, flight.fare_class.to_s)       
    end 
    
    # show only non stop flights checkbox
    if !(flight.show_only_non_stop_flights.nil?)
      if (flight.show_only_non_stop_flights)
        self.show_only_non_stop_flights_checkbox.click()
      end    
    end   
     
    # show only refundable fares checkbox
    if !(flight.show_only_refundable_fares.nil?)
      if (flight.show_only_refundable_fares)
        self.show_only_refundable_fares_checkbox.click()
      end    
    end    

    # search only preferred airline checkbox
    if !(flight.search_only_preferred_airline.nil?)
      if (flight.search_only_preferred_airline)
        self.search_only_preferred_airline_checkbox.click()
      end
    end    

    sleep 2
    
    # Click on submit button
    self.search_flights_button.click() 
  end 
      
	def round_trip_option
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @round_trip_option = self.driver.find_element(:css => self.db_object.elements.find_by_name('round trip option').by_css_locator)
	  @round_trip_option if @round_trip_option.displayed?
	}
	end

	def one_way_option 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @one_way_option = self.driver.find_element(:css => self.db_object.elements.find_by_name('one way option').by_css_locator)
	  @one_way_option if @one_way_option.displayed?
	}
	end

	def multi_city_option 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @multi_city_option = self.driver.find_element(:css => self.db_object.elements.find_by_name('multi city option').by_css_locator)
	  @multi_city_option if @multi_city_option.displayed?
	}
	end

	def departure_city_textbox(index)
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @departure_city_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name("departure city textbox #{index}").by_id_locator)
	  @departure_city_textbox if @departure_city_textbox.displayed?
	}
	end

	def arrival_city_textbox(index)
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @arrival_city_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name("arrival city textbox #{index}").by_id_locator)
	  @arrival_city_textbox if @arrival_city_textbox.displayed?
	}
	end
	
	def departure_date_textbox(index) 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @departure_date_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name("departure date textbox #{index}").by_id_locator)
	  @departure_date_textbox if @departure_date_textbox.displayed?
	}	
	end
  
	def return_date_textbox 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @return_date_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('return date textbox').by_id_locator)
	  @return_date_textbox if @return_date_textbox.displayed?
	}	
	end  
	
	def departure_time_combobox(index)  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @departure_time_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name("departure time combobox #{index}").by_css_locator)
	  @departure_time_combobox if @departure_time_combobox.displayed?
	}	
	end

	def return_time_combobox  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @return_time_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('return time combobox').by_css_locator)
	  @return_time_combobox if @return_time_combobox.displayed?
	}	
	end  
  
	def search_flights_button 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @search_flights_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('search flights button').by_css_locator)
	  @search_flights_button if @search_flights_button.displayed?
	}	
	end	
  
	def add_another_flight_link 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @add_another_flight_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('add another flight link').by_css_locator)
	  @add_another_flight_link if @add_another_flight_link.displayed?
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
  
	def children_lap_option(index)
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @children_lap_option = self.driver.find_element(:css => self.db_object.elements.find_by_name("child lap option #{index}").by_css_locator)
	  @children_lap_option if @children_lap_option.displayed?
	}
	end 

	def fare_class_combobox 
	  wait = Selenium::WebDriver::Wait.new(:timeout => 30)
	  wait.until {  
    @fare_class_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('fare class combobox').by_css_locator)
	  @fare_class_combobox if @fare_class_combobox.displayed?
	}	
	end	     
      
  def show_only_non_stop_flights_checkbox  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @show_only_non_stop_flights_checkbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('show only non stop flights checkbox').by_id_locator)
	  @show_only_non_stop_flights_checkbox if @show_only_non_stop_flights_checkbox.displayed?
	}	
	end	 
      
	def show_only_refundable_fares_checkbox 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @show_only_refundable_fares_checkbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('show only refundable fares checkbox').by_id_locator)
	  @show_only_refundable_fares_checkbox if @show_only_refundable_fares_checkbox.displayed?
	}	
	end	 

	def search_only_preferred_airline_checkbox 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @search_only_preferred_airline_checkbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('search only preferred airline checkbox').by_id_locator)
	  @search_only_preferred_airline_checkbox if @search_only_preferred_airline_checkbox.displayed?
	}	
	end	  
  
  def airports_worldwide_departure_link 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @airports_worldwide_departure_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide departure link').by_css_locator)
	  @airports_worldwide_departure_link if @airports_worldwide_departure_link.displayed?
	}	
	end	
  
  def airports_worldwide_arrival_link 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @airports_worldwide_arrival_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide arrival link').by_css_locator)
	  @airports_worldwide_arrival_link if @airports_worldwide_arrival_link.displayed?
	}	
	end	
  
  def airports_worldwide_overlay_title 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @airports_worldwide_overlay_title = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide overlay title').by_css_locator)
	  @airports_worldwide_overlay_title if @airports_worldwide_overlay_title.displayed?
	}	
	end	
  
  def airports_worldwide_overlay_icon_close_button 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @airports_worldwide_overlay_icon_close_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide overlay icon close button').by_css_locator)
	  @airports_worldwide_overlay_icon_close_button if @airports_worldwide_overlay_icon_close_button.displayed?
	}	
	end	
  
  def airports_worldwide_overlay_us_airports_tab 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @airports_worldwide_overlay_us_airports_tab = self.driver.find_element(:id => self.db_object.elements.find_by_name('airports worldwide overlay us airports tab').by_id_locator)
	  @airports_worldwide_overlay_us_airports_tab if @airports_worldwide_overlay_us_airports_tab.displayed?
	}	
	end	
  
  def airports_worldwide_overlay_canadian_airports_tab 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @airports_worldwide_overlay_canadian_airports_tab = self.driver.find_element(:id => self.db_object.elements.find_by_name('airports worldwide overlay canadian airports tab').by_id_locator)
	  @airports_worldwide_overlay_canadian_airports_tab if @airports_worldwide_overlay_canadian_airports_tab.displayed?
	}	
	end	
  
  def airports_worldwide_overlay_intl_airports_tab 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @airports_worldwide_overlay_intl_airports_tab = self.driver.find_element(:id => self.db_object.elements.find_by_name('airports worldwide overlay intl airports tab').by_id_locator)
	  @airports_worldwide_overlay_intl_airports_tab if @airports_worldwide_overlay_intl_airports_tab.displayed?
	}	
	end	
  
  def airports_worldwide_overlay_us_airports_abecedary_letter_link 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @airports_worldwide_overlay_us_airports_abecedary_letter_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide overlay us airports abecedary letter link').by_css_locator)
	  @airports_worldwide_overlay_us_airports_abecedary_letter_link if @airports_worldwide_overlay_us_airports_abecedary_letter_link.displayed?
	}	
	end
  
  def airports_worldwide_overlay_intl_airports_abecedary_letter_link 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @airports_worldwide_overlay_intl_airports_abecedary_letter_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide overlay intl airports abecedary letter link').by_css_locator)
	  @airports_worldwide_overlay_intl_airports_abecedary_letter_link if @airports_worldwide_overlay_intl_airports_abecedary_letter_link.displayed?
	}	
	end
  
  def airports_worldwide_overlay_us_airports_code_link 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @airports_worldwide_overlay_us_airports_code_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide overlay us airports code link').by_css_locator)
	  @airports_worldwide_overlay_us_airports_code_link if @airports_worldwide_overlay_us_airports_code_link.displayed?
	}	
	end
  
  def airports_worldwide_overlay_canadian_airports_code_link 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @airports_worldwide_overlay_canadian_airports_code_link = self.driver.find_element(:id => self.db_object.elements.find_by_name('airports worldwide overlay canadian airports code link').by_id_locator)
	  @airports_worldwide_overlay_canadian_airports_code_link if @airports_worldwide_overlay_canadian_airports_code_link.displayed?
	}	
	end
  
    def airports_worldwide_overlay_intl_airports_code_link
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @airports_worldwide_overlay_intl_airports_code_link = self.driver.find_element(:id => self.db_object.elements.find_by_name('airports worldwide overlay intl airports code link').by_id_locator)
	  @airports_worldwide_overlay_intl_airports_code_link if @airports_worldwide_overlay_intl_airports_code_link.displayed?
	}	
	end
  
  def airports_worldwide_overlay_us_airports_abecedary_letter_title 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @airports_worldwide_overlay_us_airports_abecedary_letter_title = self.driver.find_element(:id => self.db_object.elements.find_by_name('airports worldwide overlay us airports abecedary letter title').by_id_locator)
	  @airports_worldwide_overlay_us_airports_abecedary_letter_title if @airports_worldwide_overlay_us_airports_abecedary_letter_title.displayed?
	}	
	end
  
  def airports_worldwide_overlay_intl_airports_abecedary_letter_title 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @airports_worldwide_overlay_intl_airports_abecedary_letter_title = self.driver.find_element(:id => self.db_object.elements.find_by_name('airports worldwide overlay intl airports abecedary letter title').by_id_locator)
	  @airports_worldwide_overlay_intl_airports_abecedary_letter_title if @airports_worldwide_overlay_intl_airports_abecedary_letter_title.displayed?
	}	
	end
  
  def airports_worldwide_overlay_us_airports_back_to_top_link 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @airports_worldwide_overlay_us_airports_back_to_top_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide overlay us airports back to top link').by_css_locator)
	  @airports_worldwide_overlay_us_airports_back_to_top_link if @airports_worldwide_overlay_us_airports_back_to_top_link.displayed?
	}	
	end
  
  def airports_worldwide_overlay_intl_airports_back_to_top_link 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @airports_worldwide_overlay_intl_airports_back_to_top_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide overlay intl airports back to top link').by_css_locator)
	  @airports_worldwide_overlay_intl_airports_back_to_top_link if @airports_worldwide_overlay_intl_airports_back_to_top_link.displayed?
	}	
	end
  
  def airports_worldwide_overlay_us_scrollpane
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @airports_worldwide_overlay_us_scrollpane = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide overlay us scrollpane').by_css_locator)
	  @airports_worldwide_overlay_us_scrollpane if @airports_worldwide_overlay_us_scrollpane.displayed?
	}	
	end
  
  def airports_worldwide_overlay_intl_scrollpane
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @airports_worldwide_overlay_intl_scrollpane = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide overlay intl scrollpane').by_css_locator)
	  @airports_worldwide_overlay_intl_scrollpane if @airports_worldwide_overlay_intl_scrollpane.displayed?
	}	
	end
  
  def show_only_refundable_fares_label
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @show_only_refundable_fares_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('show only refundable fares label').by_css_locator)
	  @show_only_refundable_fares_label if @show_only_refundable_fares_label.displayed?
	}	
	end
  
  def on_air_rate_card_alert_day_label
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @on_air_rate_card_alert_day_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('on air rate card alert day label').by_css_locator)
	  @on_air_rate_card_alert_day_label if @on_air_rate_card_alert_day_label.displayed?
	}	
	end
  
  def on_air_rate_card_alert_change_planes_label
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @on_air_rate_card_alert_change_planes_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('on air rate card alert change planes label').by_css_locator)
	  @on_air_rate_card_alert_change_planes_label if @on_air_rate_card_alert_change_planes_label.displayed?
	}	
	end
  
  def on_air_rate_card_alert_subject_to_government_approval_label
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @on_air_rate_card_alert_subject_to_government_approval_label = self.driver.find_elements(:css => self.db_object.elements.find_by_name('on air rate card alert subject to government approval label').by_css_locator)
	  @on_air_rate_card_alert_subject_to_government_approval_label if @on_air_rate_card_alert_subject_to_government_approval_label[0].displayed?
	}	
	end
  
  def log_in_on_the_rate_card_login_label
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @log_in_on_the_rate_card_login_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('log in on the rate card login label').by_css_locator)
	  @log_in_on_the_rate_card_login_label if @log_in_on_the_rate_card_login_label.displayed?
	}	
	end 
  
  def log_in_on_the_rate_card_rewards_label
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @log_in_on_the_rate_card_rewards_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('log in on the rate card rewards label').by_css_locator)
	  @log_in_on_the_rate_card_rewards_label if @log_in_on_the_rate_card_rewards_label.displayed?
	}	
	end
  
  def log_in_on_the_rate_card_log_in_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @log_in_on_the_rate_card_rewards_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('log in on the rate card log in button').by_css_locator)
	  @log_in_on_the_rate_card_rewards_label if @log_in_on_the_rate_card_rewards_label.displayed?
	}	
	end
end
