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

TIMEOUT = RSpec.configuration.timeout

class HotelSearchPage < BasePage   
  def initialize(driver, test_env)   
    @db_object = Page.find_by_name('hotel search page')
    @url = Environment.find_by_name(test_env).base_url + Page.find_by_name('hotel search page').url
    @title = Page.find_by_name('hotel search page').title
    @driver = driver 
  end  
  
  def book_a_hotel(dataset_name)
    hotel = Hotel.find_by_name(dataset_name)
    
    # by city or landmark option
    if !(hotel.by_city_or_landmark_option.nil?)
      self.by_city_or_landmark_option.click()        
    end 
    
     # by address option
    if !(hotel.by_address_option.nil?)
      self.by_address_option.click()        
    end 
        
    # destination textbox    
    if !(hotel.destination.nil?)
      self.enter_airport(self.destination_textbox,hotel.destination)     
    end
    
    sleep 1
   
    # check in date textbox
    if !(hotel.check_in_date.nil?)
      self.check_in_date_textbox.send_keys(eval(hotel.check_in_date))  
    end 
   
    # check out date textbox
    if !(hotel.check_out_date.nil?)
      self.check_out_date_textbox.send_keys(eval(hotel.check_out_date)) 
    end   
    
    # rooms combobox
    if !(hotel.rooms.nil?)
      if hotel.rooms > 0
        self.select_option(self.rooms_combobox, hotel.rooms.to_s)       
      end  
    end  
             
    # adults combobox 1
    if !(hotel.adults_1.nil?)
      if hotel.adults_1 > 0
        self.select_option(self.adults_combobox(1), hotel.adults_1.to_s)       
      end  
    end  

    # adults combobox 2
    if !(hotel.adults_2.nil?)
      if hotel.adults_2 > 0
        self.select_option(self.adults_combobox(2), hotel.adults_2.to_s)       
      end  
    end  
    
    # adults combobox 3
    if !(hotel.adults_3.nil?)
      if hotel.adults_3 > 0
        self.select_option(self.adults_combobox(3), hotel.adults_3.to_s)       
      end  
    end  

    # adults combobox 4
    if !(hotel.adults_4.nil?)
      if hotel.adults_4 > 0
        self.select_option(self.adults_combobox(4), hotel.adults_4.to_s)       
      end  
    end      
    
    # children combobox 1    
    if !(hotel.children_1.nil?)
      if hotel.children_1 > 0
        self.select_option(self.children_combobox(1), hotel.children_1.to_s)         
      end  
    end  

    # children combobox 2   
    if !(hotel.children_2.nil?)
      if hotel.children_2 > 0
        self.select_option(self.children_combobox(2), hotel.children_2.to_s)         
      end  
    end  
    
    # children combobox 3   
    if !(hotel.children_3.nil?)
      if hotel.children_3 > 0
        self.select_option(self.children_combobox(3), hotel.children_3.to_s)         
      end  
    end  

    # children combobox 4   
    if !(hotel.children_4.nil?)
      if hotel.children_4 > 0
        self.select_option(self.children_combobox(4), hotel.children_4.to_s)         
      end  
    end      
    
    # room 1 - children age combobox 1    
    if !(hotel.room_1_children_age_1.nil?)
      if hotel.room_1_children_age_1 > 0
        if hotel.room_1_children_age_1 > 1
          self.select_option(self.children_age_combobox(1,1), hotel.room_1_children_age_1.to_s) 
        else
          self.select_option(self.children_age_combobox(1,1), "<2") 
        end                
      end  
    end 

    # room 1 - children age combobox 2    
    if !(hotel.room_1_children_age_2.nil?)
      if hotel.room_1_children_age_2 > 0
        if hotel.room_1_children_age_2 > 1
          self.select_option(self.children_age_combobox(1,2), hotel.room_1_children_age_2.to_s) 
        else
          self.select_option(self.children_age_combobox(1,2), "<2") 
        end                
      end  
    end 
    
    # room 1 - children age combobox 3   
    if !(hotel.room_1_children_age_3.nil?)
      if hotel.room_1_children_age_3 > 0
        if hotel.room_1_children_age_3 > 1
          self.select_option(self.children_age_combobox(1,3), hotel.room_1_children_age_3.to_s) 
        else
          self.select_option(self.children_age_combobox(1,3), "<2") 
        end                
      end  
    end 

    # room 1 - children age combobox 4  
    if !(hotel.room_1_children_age_4.nil?)
      if hotel.room_1_children_age_4 > 0
        if hotel.room_1_children_age_4 > 1
          self.select_option(self.children_age_combobox(1,4), hotel.room_1_children_age_4.to_s) 
        else
          self.select_option(self.children_age_combobox(1,4), "<2") 
        end                
      end  
    end    

    # room 1 - children age combobox 5  
    if !(hotel.room_1_children_age_5.nil?)
      if hotel.room_1_children_age_5 > 0
        if hotel.room_1_children_age_5 > 1
          self.select_option(self.children_age_combobox(1,5), hotel.room_1_children_age_5.to_s) 
        else
          self.select_option(self.children_age_combobox(1,5), "<2") 
        end                
      end  
    end    
    
    # room 2 - children age combobox 1    
    if !(hotel.room_2_children_age_1.nil?)
      if hotel.room_2_children_age_1 > 0
        if hotel.room_2_children_age_1 > 1
          self.select_option(self.children_age_combobox(2,1), hotel.room_2_children_age_1.to_s) 
        else
          self.select_option(self.children_age_combobox(2,1), "<2") 
        end                
      end  
    end 

    # room 2 - children age combobox 2    
    if !(hotel.room_2_children_age_2.nil?)
      if hotel.room_2_children_age_2 > 0
        if hotel.room_2_children_age_2 > 1
          self.select_option(self.children_age_combobox(2,2), hotel.room_2_children_age_2.to_s) 
        else
          self.select_option(self.children_age_combobox(2,2), "<2") 
        end                
      end  
    end 
    
    # room 2 - children age combobox 3   
    if !(hotel.room_2_children_age_3.nil?)
      if hotel.room_2_children_age_3 > 0
        if hotel.room_2_children_age_3 > 1
          self.select_option(self.children_age_combobox(2,3), hotel.room_2_children_age_3.to_s) 
        else
          self.select_option(self.children_age_combobox(2,3), "<2") 
        end                
      end  
    end 

    # room 2 - children age combobox 4  
    if !(hotel.room_2_children_age_4.nil?)
      if hotel.room_2_children_age_4 > 0
        if hotel.room_2_children_age_4 > 1
          self.select_option(self.children_age_combobox(2,4), hotel.room_2_children_age_4.to_s) 
        els
          self.select_option(self.children_age_combobox(2,4), "<2") 
        end                
      end  
    end    

    # room 2 - children age combobox 5  
    if !(hotel.room_2_children_age_5.nil?)
      if hotel.room_2_children_age_5 > 0
        if hotel.room_2_children_age_5 > 1
          self.select_option(self.children_age_combobox(2,5), hotel.room_2_children_age_5.to_s) 
        else
          self.select_option(self.children_age_combobox(2,5), "<2") 
        end                
      end  
    end    

    # room 3 - children age combobox 1    
    if !(hotel.room_3_children_age_1.nil?)
      if hotel.room_3_children_age_1 > 0
        if hotel.room_3_children_age_1 > 1
          self.select_option(self.children_age_combobox(3,1), hotel.room_3_children_age_1.to_s) 
        else
          self.select_option(self.children_age_combobox(3,1), "<2") 
        end                
      end  
    end 

    # room 3 - children age combobox 2    
    if !(hotel.room_3_children_age_2.nil?)
      if hotel.room_3_children_age_2 > 0
        if hotel.room_3_children_age_2 > 1
          self.select_option(self.children_age_combobox(3,2), hotel.room_3_children_age_2.to_s) 
        else
          self.select_option(self.children_age_combobox(3,2), "<2") 
        end                
      end  
    end 
    
    # room 3 - children age combobox 3   
    if !(hotel.room_3_children_age_3.nil?)
      if hotel.room_3_children_age_3 > 0
        if hotel.room_3_children_age_3 > 1
          self.select_option(self.children_age_combobox(3,3), hotel.room_3_children_age_3.to_s) 
        else
          self.select_option(self.children_age_combobox(3,3), "<2") 
        end                
      end  
    end 

    # room 3 - children age combobox 4  
    if !(hotel.room_3_children_age_4.nil?)
      if hotel.room_3_children_age_4 > 0
        if hotel.room_3_children_age_4 > 1
          self.select_option(self.children_age_combobox(3,4), hotel.room_3_children_age_4.to_s) 
        els
          self.select_option(self.children_age_combobox(3,4), "<2") 
        end                
      end  
    end    

    # room 3 - children age combobox 5  
    if !(hotel.room_3_children_age_5.nil?)
      if hotel.room_3_children_age_5 > 0
        if hotel.room_3_children_age_5 > 1
          self.select_option(self.children_age_combobox(3,5), hotel.room_3_children_age_5.to_s) 
        else
          self.select_option(self.children_age_combobox(3,5), "<2") 
        end                
      end  
    end    

    # room 4 - children age combobox 1    
    if !(hotel.room_4_children_age_1.nil?)
      if hotel.room_4_children_age_1 > 0
        if hotel.room_4_children_age_1 > 1
          self.select_option(self.children_age_combobox(4,1), hotel.room_4_children_age_1.to_s) 
        else
          self.select_option(self.children_age_combobox(4,1), "<2") 
        end                
      end  
    end 

    # room 4 - children age combobox 2    
    if !(hotel.room_4_children_age_2.nil?)
      if hotel.room_4_children_age_2 > 0
        if hotel.room_4_children_age_2 > 1
          self.select_option(self.children_age_combobox(4,2), hotel.room_4_children_age_2.to_s) 
        else
          self.select_option(self.children_age_combobox(4,2), "<2") 
        end                
      end  
    end 
    
    # room 4 - children age combobox 3   
    if !(hotel.room_4_children_age_3.nil?)
      if hotel.room_4_children_age_3 > 0
        if hotel.room_4_children_age_3 > 1
          self.select_option(self.children_age_combobox(4,3), hotel.room_4_children_age_3.to_s) 
        else
          self.select_option(self.children_age_combobox(4,3), "<2") 
        end                
      end  
    end 

    # room 4 - children age combobox 4  
    if !(hotel.room_4_children_age_4.nil?)
      if hotel.room_4_children_age_4 > 0
        if hotel.room_4_children_age_4 > 1
          self.select_option(self.children_age_combobox(4,4), hotel.room_4_children_age_4.to_s) 
        els
          self.select_option(self.children_age_combobox(4,4), "<2") 
        end                
      end  
    end    

    # room 4 - children age combobox 5  
    if !(hotel.room_4_children_age_5.nil?)
      if hotel.room_4_children_age_5 > 0
        if hotel.room_4_children_age_5 > 1
          self.select_option(self.children_age_combobox(4,5), hotel.room_4_children_age_5.to_s) 
        else
          self.select_option(self.children_age_combobox(4,5), "<2") 
        end                
      end  
    end    
    
    # room 1 - children seated option 1    
    if !(hotel.room_1_children_seated_option_1.nil?)
      self.children_seated_option(1,1).click()         
    end 

    # room 1 - children seated option 2    
    if !(hotel.room_1_children_seated_option_2.nil?)
      self.children_seated_option(1,2).click()         
    end 

    # room 1 - children seated option 3
    if !(hotel.room_1_children_seated_option_3.nil?)
      self.children_seated_option(1,3).click()        
    end 

    # room 1 - children seated option 4
    if !(hotel.room_1_children_seated_option_4.nil?)
      self.children_seated_option(1,4).click()         
    end    
        
    # room 1 - children seated option 5
    if !(hotel.room_1_children_seated_option_5.nil?)
      self.children_seated_option(1,5).click()         
    end       
    
    # room 2 - children seated option 1    
    if !(hotel.room_2_children_seated_option_1.nil?)
      self.children_seated_option(2,1).click()         
    end 

    # room 2 - children seated option 2    
    if !(hotel.room_2_children_seated_option_2.nil?)
      self.children_seated_option(2,2).click()         
    end 

    # room 2 - children seated option 3
    if !(hotel.room_2_children_seated_option_3.nil?)
      self.children_seated_option(2,3).click()        
    end 

    # room 2 - children seated option 4
    if !(hotel.room_2_children_seated_option_4.nil?)
      self.children_seated_option(2,4).click()         
    end    
        
    # room 2 - children seated option 5
    if !(hotel.room_2_children_seated_option_5.nil?)
      self.children_seated_option(2,5).click()         
    end         

    # room 3 - children seated option 1    
    if !(hotel.room_3_children_seated_option_1.nil?)
      self.children_seated_option(3,1).click()         
    end 

    # room 3 - children seated option 2    
    if !(hotel.room_3_children_seated_option_2.nil?)
      self.children_seated_option(3,2).click()         
    end 

    # room 3 - children seated option 3
    if !(hotel.room_3_children_seated_option_3.nil?)
      self.children_seated_option(3,3).click()        
    end 

    # room 3 - children seated option 4
    if !(hotel.room_3_children_seated_option_4.nil?)
      self.children_seated_option(3,4).click()         
    end    
        
    # room 3 - children seated option 5
    if !(hotel.room_3_children_seated_option_5.nil?)
      self.children_seated_option(3,5).click()         
    end   

    # room 4 - children seated option 1    
    if !(hotel.room_4_children_seated_option_1.nil?)
      self.children_seated_option(4,1).click()         
    end 

    # room 4 - children seated option 2    
    if !(hotel.room_4_children_seated_option_2.nil?)
      self.children_seated_option(4,2).click()         
    end 

    # room 4 - children seated option 3
    if !(hotel.room_4_children_seated_option_3.nil?)
      self.children_seated_option(4,3).click()        
    end 

    # room 4 - children seated option 4
    if !(hotel.room_4_children_seated_option_4.nil?)
      self.children_seated_option(4,4).click()         
    end    
        
    # room 4 - children seated option 5
    if !(hotel.room_4_children_seated_option_5.nil?)
      self.children_seated_option(4,5).click()         
    end   
    
    # room 1 - children lap option 1    
    if !(hotel.room_1_children_lap_option_1.nil?)
      self.children_lap_option(1,1).click()      
    end 

    # room 1 - children lap option 2    
    if !(hotel.room_1_children_lap_option_2.nil?)
      self.children_lap_option(1,2).click()        
    end 

    # room 1 - children lap option 3
    if !(hotel.room_1_children_lap_option_3.nil?)
      self.children_lap_option(1,3).click()    
    end 

    # room 1 - children lap option 4
    if !(hotel.room_1_children_lap_option_4.nil?)
      self.children_lap_option(1,4).click()        
    end        
    
    # room 1 - children lap option 5
    if !(hotel.room_1_children_lap_option_5.nil?)
      self.children_lap_option(1,5).click()        
    end       

    # room 2 - children lap option 1    
    if !(hotel.room_2_children_lap_option_1.nil?)
      self.children_lap_option(2,1).click()      
    end 

    # room 2 - children lap option 2    
    if !(hotel.room_2_children_lap_option_2.nil?)
      self.children_lap_option(2,2).click()        
    end 

    # room 2 - children lap option 3
    if !(hotel.room_2_children_lap_option_3.nil?)
      self.children_lap_option(2,3).click()    
    end 

    # room 2 - children lap option 4
    if !(hotel.room_2_children_lap_option_4.nil?)
      self.children_lap_option(2,4).click()        
    end        
    
    # room 2 - children lap option 5
    if !(hotel.room_2_children_lap_option_5.nil?)
      self.children_lap_option(2,5).click()        
    end         

    # room 3 - children lap option 1    
    if !(hotel.room_3_children_lap_option_1.nil?)
      self.children_lap_option(3,1).click()      
    end 

    # room 3 - children lap option 2    
    if !(hotel.room_3_children_lap_option_2.nil?)
      self.children_lap_option(3,2).click()        
    end 

    # room 3 - children lap option 3
    if !(hotel.room_3_children_lap_option_3.nil?)
      self.children_lap_option(3,3).click()    
    end 

    # room 3 - children lap option 4
    if !(hotel.room_3_children_lap_option_4.nil?)
      self.children_lap_option(3,4).click()        
    end        
    
    # room 3 - children lap option 5
    if !(hotel.room_3_children_lap_option_5.nil?)
      self.children_lap_option(3,5).click()        
    end       
    
    # room 4 - children lap option 1    
    if !(hotel.room_4_children_lap_option_1.nil?)
      self.children_lap_option(4,1).click()      
    end 

    # room 4 - children lap option 2    
    if !(hotel.room_4_children_lap_option_2.nil?)
      self.children_lap_option(4,2).click()        
    end 

    # room 4 - children lap option 3
    if !(hotel.room_4_children_lap_option_3.nil?)
      self.children_lap_option(4,3).click()    
    end 

    # room 4 - children lap option 4
    if !(hotel.room_4_children_lap_option_4.nil?)
      self.children_lap_option(4,4).click()        
    end        
    
    # room 4 - children lap option 5
    if !(hotel.room_4_children_lap_option_5.nil?)
      self.children_lap_option(4,5).click()        
    end       
    
    sleep 2
    
    # Click on submit button
    self.search_hotels_button.click() 
  end

  def by_city_or_landmark_option
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @by_city_or_landmark_option = self.driver.find_element(:css => self.db_object.elements.find_by_name('by city or landmark option').by_css_locator)
	  @by_city_or_landmark_option if @by_city_or_landmark_option.displayed?
	}
	end
  
  def by_address_option
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @by_address_option = self.driver.find_element(:css => self.db_object.elements.find_by_name('by address option').by_css_locator)
	  @by_address_option if @by_address_option.displayed?
	}
	end
  
	def destination_textbox
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @destination_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('destination').by_id_locator)
	  @destination_textbox if @destination_textbox.displayed?
	}
	end
  
	def check_in_date_textbox
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @check_in_date_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('check-in date').by_id_locator)
	  @check_in_date_textbox if @check_in_date_textbox.displayed?
	}
	end
	def check_out_date_textbox
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @check_out_date_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('check-out date').by_id_locator)
	  @check_out_date_textbox if @check_out_date_textbox.displayed?
	}
	end  
	def search_hotels_button 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @search_hotels_button = self.driver.find_element(:name => self.db_object.elements.find_by_name('search hotels button').by_name)
	  @search_hotels_button if @search_hotels_button.displayed?
	}	
	end	  
  
  def rooms_combobox 
	  wait = Selenium::WebDriver::Wait.new(:timeout => 60)
	  wait.until {  
    @rooms_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('rooms combobox').by_css_locator)
	  @rooms_combobox if @rooms_combobox.displayed?
	}	
	end	  
  
	def rooms_combobox_selected_option
	  wait = Selenium::WebDriver::Wait.new(:timeout => 60)
	  wait.until {  
    @rooms_combobox_selected_option = self.driver.find_element(:css => self.db_object.elements.find_by_name('rooms combobox selected option').by_css_locator)
	  @rooms_combobox_selected_option if @rooms_combobox_selected_option.displayed?
	}	
	end	    
    
	def adults_combobox(index) 
	  wait = Selenium::WebDriver::Wait.new(:timeout => 60)
	  wait.until {  
    @adults_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name("adults combobox #{index}").by_css_locator)
	  @adults_combobox if @adults_combobox.displayed?
	}	
	end
  
	def adults_combobox_selected_option(index) 
	  wait = Selenium::WebDriver::Wait.new(:timeout => 60)
	  wait.until {  
    @adults_combobox_selected_option = self.driver.find_element(:css => self.db_object.elements.find_by_name("adults combobox selected option #{index}").by_css_locator)
	  @adults_combobox_selected_option if @adults_combobox_selected_option.displayed?
	}	
	end  

	def seniors_combobox(index) 
	  wait = Selenium::WebDriver::Wait.new(:timeout => 60)
	  wait.until {  
    @seniors_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name("seniors combobox #{index}").by_css_locator)
	  @seniors_combobox if @seniors_combobox.displayed?
	}	
	end  
  
	def children_combobox(index) 
	  wait = Selenium::WebDriver::Wait.new(:timeout => 60)
	  wait.until {  
    @children_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name("children combobox #{index}").by_css_locator)
	  @children_combobox if @children_combobox.displayed?
	}	
	end  

	def children_age_combobox(room,index) 
	  wait = Selenium::WebDriver::Wait.new(:timeout => 60)
	  wait.until {  
    @children_age_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name("room #{room} - age of child combobox #{index}").by_css_locator)
	  @children_age_combobox if @children_age_combobox.displayed?
	}	
	end	 
  
	def children_seated_option(room,index) 
	  wait = Selenium::WebDriver::Wait.new(:timeout => 60)
	  wait.until {
	  @children_seated_option = self.driver.find_element(:css => self.db_object.elements.find_by_name("room #{room} - child in seat option #{index}").by_css_locator)
	  @children_seated_option if @children_seated_option.displayed?
	}
	end  
  
	def children_seated_option_input(room,index)
	  wait = Selenium::WebDriver::Wait.new(:timeout => 60)
	  wait.until {
	  @children_seated_option_input = self.driver.find_element(:id => self.db_object.elements.find_by_name("room #{room} - child in seat option input #{index}").by_id_locator)
	  @children_seated_option_input if @children_seated_option_input.displayed?
	}
	end     
  
	def children_lap_option(room,index) 
	  wait = Selenium::WebDriver::Wait.new(:timeout => 60)
	  wait.until {
	  @children_lap_option = self.driver.find_element(:css => self.db_object.elements.find_by_name("room #{room} - child in lap option #{index}").by_css_locator)
	  @children_lap_option if @children_lap_option.displayed?
	}
	end 
  
	def children_lap_option_input(room,index) 
	  wait = Selenium::WebDriver::Wait.new(:timeout => 60)
	  wait.until {
	  @children_lap_option_input = self.driver.find_element(:id => self.db_object.elements.find_by_name("room #{room} - child in lap option input #{index}").by_id_locator)
	  @children_lap_option_input if @children_lap_option_input.displayed?
	}
	end 
  
  def search_street_address_textbox
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @search_street_address_textbox = self.driver.find_element(:css => self.db_object.elements.find_by_name('search street address textbox').by_css_locator)
    @search_street_address_textbox if @search_street_address_textbox.displayed?
    }	
  end 
  
  def search_city_textbox
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @search_city_textbox = self.driver.find_element(:css => self.db_object.elements.find_by_name('search city textbox').by_css_locator)
    @search_city_textbox if @search_city_textbox.displayed?
    }	
  end 
    
  def search_zip_postal_code_textbox
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @search_zip_postal_code_textbox = self.driver.find_element(:css => self.db_object.elements.find_by_name('search zip postal code textbox').by_css_locator)
    @search_zip_postal_code_textbox if @search_zip_postal_code_textbox.displayed?
    }	
  end 
  
  def search_country_combobox
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @search_country_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('search country combobox').by_css_locator)
    @search_country_combobox if @search_country_combobox.displayed?
    }	
  end

  def search_state_combobox
   wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @search_state_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('search state combobox').by_css_locator)
    @search_state_combobox if @search_state_combobox.displayed?
    }	
  end  
  
  def search_error_messages 
  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @search_error_messages = self.driver.find_elements(:css => self.db_object.elements.find_by_name('search error messages').by_css_locator)
    @search_error_messages if @search_error_messages[0].displayed?
  }
  end   
  
   def login_in_button
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @login_in_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('login in button').by_css_locator)
    @login_in_button if @login_in_button.displayed?
    }	
  end
end


