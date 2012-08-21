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

class PackageSearchPage < BasePage   
  def initialize(driver, test_env)   
    @db_object = Page.find_by_name('package search page')
    @url = Environment.find_by_name(test_env).base_url + Page.find_by_name('package search page').url
    @title = Page.find_by_name('package search page').title
    @driver = driver 
  end  
  
  def book_a_package(dataset_name)
    package = Package.find_by_name(dataset_name)
        
    # departure city textbox    
    if !(package.departure_city.nil?)
      self.enter_airport(self.departure_city_textbox,package.departure_city)     
    end
    
    # arrival city textbox
    if !(package.arrival_city.nil?)
      self.enter_airport(self.arrival_city_textbox,package.arrival_city)             
    end

    # departure date textbox
    if !(package.departure_date.nil?)
      self.departure_date_textbox.send_keys(eval(package.departure_date))  
    end 
   
    # return date textbox
    if !(package.return_date.nil?)
      self.return_date_textbox.send_keys(eval(package.return_date)) 
    end   
    
    # departure time combobox
    if !(package.departure_time.nil?)
      self.select_option(self.departure_time_combobox, package.departure_time.to_s)
    end         
  
    # return time combobox
    if !(package.return_time.nil?)
      self.select_option(self.return_time_combobox, package.return_time.to_s) 
    end       
             
    # rooms combobox
    if !(package.rooms.nil?)
      if package.rooms > 0
        self.select_option(self.rooms_combobox, package.rooms.to_s)       
      end  
    end  
             
    # adults combobox 1
    if !(package.adults_1.nil?)
      if package.adults_1 > 0
        self.select_option(self.adults_combobox(1), package.adults_1.to_s)       
      end  
    end  

    # adults combobox 2
    if !(package.adults_2.nil?)
      if package.adults_2 > 0
        self.select_option(self.adults_combobox(2), package.adults_2.to_s)       
      end  
    end  
    
    # adults combobox 3
    if !(package.adults_3.nil?)
      if package.adults_3 > 0
        self.select_option(self.adults_combobox(3), package.adults_3.to_s)       
      end  
    end  

    # adults combobox 4
    if !(package.adults_4.nil?)
      if package.adults_4 > 0
        self.select_option(self.adults_combobox(4), package.adults_4.to_s)       
      end  
    end      
    
    # seniors combobox 1
    if !(package.seniors_1.nil?)
      if package.seniors_1 > 0
        self.select_option(self.seniors_combobox(1), package.seniors_1.to_s)         
      end  
    end  

    # seniors combobox 2
    if !(package.seniors_2.nil?)
      if package.seniors_2 > 0
        self.select_option(self.seniors_combobox(2), package.seniors_2.to_s)         
      end  
    end  
    
    # seniors combobox 3
    if !(package.seniors_3.nil?)
      if package.seniors_3 > 0
        self.select_option(self.seniors_combobox(3), package.seniors_3.to_s)         
      end  
    end  

    # seniors combobox 4
    if !(package.seniors_4.nil?)
      if package.seniors_4 > 0
        self.select_option(self.seniors_combobox(4), package.seniors_4.to_s)         
      end  
    end      
    
    # children combobox 1    
    if !(package.children_1.nil?)
      if package.children_1 > 0
        self.select_option(self.children_combobox(1), package.children_1.to_s)         
      end  
    end  

    # children combobox 2   
    if !(package.children_2.nil?)
      if package.children_2 > 0
        self.select_option(self.children_combobox(2), package.children_2.to_s)         
      end  
    end  
    
    # children combobox 3   
    if !(package.children_3.nil?)
      if package.children_3 > 0
        self.select_option(self.children_combobox(3), package.children_3.to_s)         
      end  
    end  

    # children combobox 4   
    if !(package.children_4.nil?)
      if package.children_4 > 0
        self.select_option(self.children_combobox(4), package.children_4.to_s)         
      end  
    end      
    
    # room 1 - children age combobox 1    
    if !(package.room_1_children_age_1.nil?)
      if package.room_1_children_age_1 > 0
        if package.room_1_children_age_1 > 1
          self.select_option(self.children_age_combobox(1,1), package.room_1_children_age_1.to_s) 
        else
          self.select_option(self.children_age_combobox(1,1), "<2") 
        end                
      end  
    end 

    # room 1 - children age combobox 2    
    if !(package.room_1_children_age_2.nil?)
      if package.room_1_children_age_2 > 0
        if package.room_1_children_age_2 > 1
          self.select_option(self.children_age_combobox(1,2), package.room_1_children_age_2.to_s) 
        else
          self.select_option(self.children_age_combobox(1,2), "<2") 
        end                
      end  
    end 
    
    # room 1 - children age combobox 3   
    if !(package.room_1_children_age_3.nil?)
      if package.room_1_children_age_3 > 0
        if package.room_1_children_age_3 > 1
          self.select_option(self.children_age_combobox(1,3), package.room_1_children_age_3.to_s) 
        else
          self.select_option(self.children_age_combobox(1,3), "<2") 
        end                
      end  
    end 

    # room 1 - children age combobox 4  
    if !(package.room_1_children_age_4.nil?)
      if package.room_1_children_age_4 > 0
        if package.room_1_children_age_4 > 1
          self.select_option(self.children_age_combobox(1,4), package.room_1_children_age_4.to_s) 
        else
          self.select_option(self.children_age_combobox(1,4), "<2") 
        end                
      end  
    end    

    # room 1 - children age combobox 5  
    if !(package.room_1_children_age_5.nil?)
      if package.room_1_children_age_5 > 0
        if package.room_1_children_age_5 > 1
          self.select_option(self.children_age_combobox(1,5), package.room_1_children_age_5.to_s) 
        else
          self.select_option(self.children_age_combobox(1,5), "<2") 
        end                
      end  
    end    
    
    # room 2 - children age combobox 1    
    if !(package.room_2_children_age_1.nil?)
      if package.room_2_children_age_1 > 0
        if package.room_2_children_age_1 > 1
          self.select_option(self.children_age_combobox(2,1), package.room_2_children_age_1.to_s) 
        else
          self.select_option(self.children_age_combobox(2,1), "<2") 
        end                
      end  
    end 

    # room 2 - children age combobox 2    
    if !(package.room_2_children_age_2.nil?)
      if package.room_2_children_age_2 > 0
        if package.room_2_children_age_2 > 1
          self.select_option(self.children_age_combobox(2,2), package.room_2_children_age_2.to_s) 
        else
          self.select_option(self.children_age_combobox(2,2), "<2") 
        end                
      end  
    end 
    
    # room 2 - children age combobox 3   
    if !(package.room_2_children_age_3.nil?)
      if package.room_2_children_age_3 > 0
        if package.room_2_children_age_3 > 1
          self.select_option(self.children_age_combobox(2,3), package.room_2_children_age_3.to_s) 
        else
          self.select_option(self.children_age_combobox(2,3), "<2") 
        end                
      end  
    end 

    # room 2 - children age combobox 4  
    if !(package.room_2_children_age_4.nil?)
      if package.room_2_children_age_4 > 0
        if package.room_2_children_age_4 > 1
          self.select_option(self.children_age_combobox(2,4), package.room_2_children_age_4.to_s) 
        els
          self.select_option(self.children_age_combobox(2,4), "<2") 
        end                
      end  
    end    

    # room 2 - children age combobox 5  
    if !(package.room_2_children_age_5.nil?)
      if package.room_2_children_age_5 > 0
        if package.room_2_children_age_5 > 1
          self.select_option(self.children_age_combobox(2,5), package.room_2_children_age_5.to_s) 
        else
          self.select_option(self.children_age_combobox(2,5), "<2") 
        end                
      end  
    end    

    # room 3 - children age combobox 1    
    if !(package.room_3_children_age_1.nil?)
      if package.room_3_children_age_1 > 0
        if package.room_3_children_age_1 > 1
          self.select_option(self.children_age_combobox(3,1), package.room_3_children_age_1.to_s) 
        else
          self.select_option(self.children_age_combobox(3,1), "<2") 
        end                
      end  
    end 

    # room 3 - children age combobox 2    
    if !(package.room_3_children_age_2.nil?)
      if package.room_3_children_age_2 > 0
        if package.room_3_children_age_2 > 1
          self.select_option(self.children_age_combobox(3,2), package.room_3_children_age_2.to_s) 
        else
          self.select_option(self.children_age_combobox(3,2), "<2") 
        end                
      end  
    end 
    
    # room 3 - children age combobox 3   
    if !(package.room_3_children_age_3.nil?)
      if package.room_3_children_age_3 > 0
        if package.room_3_children_age_3 > 1
          self.select_option(self.children_age_combobox(3,3), package.room_3_children_age_3.to_s) 
        else
          self.select_option(self.children_age_combobox(3,3), "<2") 
        end                
      end  
    end 

    # room 3 - children age combobox 4  
    if !(package.room_3_children_age_4.nil?)
      if package.room_3_children_age_4 > 0
        if package.room_3_children_age_4 > 1
          self.select_option(self.children_age_combobox(3,4), package.room_3_children_age_4.to_s) 
        els
          self.select_option(self.children_age_combobox(3,4), "<2") 
        end                
      end  
    end    

    # room 3 - children age combobox 5  
    if !(package.room_3_children_age_5.nil?)
      if package.room_3_children_age_5 > 0
        if package.room_3_children_age_5 > 1
          self.select_option(self.children_age_combobox(3,5), package.room_3_children_age_5.to_s) 
        else
          self.select_option(self.children_age_combobox(3,5), "<2") 
        end                
      end  
    end    

    # room 4 - children age combobox 1    
    if !(package.room_4_children_age_1.nil?)
      if package.room_4_children_age_1 > 0
        if package.room_4_children_age_1 > 1
          self.select_option(self.children_age_combobox(4,1), package.room_4_children_age_1.to_s) 
        else
          self.select_option(self.children_age_combobox(4,1), "<2") 
        end                
      end  
    end 

    # room 4 - children age combobox 2    
    if !(package.room_4_children_age_2.nil?)
      if package.room_4_children_age_2 > 0
        if package.room_4_children_age_2 > 1
          self.select_option(self.children_age_combobox(4,2), package.room_4_children_age_2.to_s) 
        else
          self.select_option(self.children_age_combobox(4,2), "<2") 
        end                
      end  
    end 
    
    # room 4 - children age combobox 3   
    if !(package.room_4_children_age_3.nil?)
      if package.room_4_children_age_3 > 0
        if package.room_4_children_age_3 > 1
          self.select_option(self.children_age_combobox(4,3), package.room_4_children_age_3.to_s) 
        else
          self.select_option(self.children_age_combobox(4,3), "<2") 
        end                
      end  
    end 

    # room 4 - children age combobox 4  
    if !(package.room_4_children_age_4.nil?)
      if package.room_4_children_age_4 > 0
        if package.room_4_children_age_4 > 1
          self.select_option(self.children_age_combobox(4,4), package.room_4_children_age_4.to_s) 
        els
          self.select_option(self.children_age_combobox(4,4), "<2") 
        end                
      end  
    end    

    # room 4 - children age combobox 5  
    if !(package.room_4_children_age_5.nil?)
      if package.room_4_children_age_5 > 0
        if package.room_4_children_age_5 > 1
          self.select_option(self.children_age_combobox(4,5), package.room_4_children_age_5.to_s) 
        else
          self.select_option(self.children_age_combobox(4,5), "<2") 
        end                
      end  
    end    
    
    # room 1 - children seated option 1    
    if !(package.room_1_children_seated_option_1.nil?)
      self.children_seated_option(1,1).click()         
    end 

    # room 1 - children seated option 2    
    if !(package.room_1_children_seated_option_2.nil?)
      self.children_seated_option(1,2).click()         
    end 

    # room 1 - children seated option 3
    if !(package.room_1_children_seated_option_3.nil?)
      self.children_seated_option(1,3).click()        
    end 

    # room 1 - children seated option 4
    if !(package.room_1_children_seated_option_4.nil?)
      self.children_seated_option(1,4).click()         
    end    
        
    # room 1 - children seated option 5
    if !(package.room_1_children_seated_option_5.nil?)
      self.children_seated_option(1,5).click()         
    end       
    
    # room 2 - children seated option 1    
    if !(package.room_2_children_seated_option_1.nil?)
      self.children_seated_option(2,1).click()         
    end 

    # room 2 - children seated option 2    
    if !(package.room_2_children_seated_option_2.nil?)
      self.children_seated_option(2,2).click()         
    end 

    # room 2 - children seated option 3
    if !(package.room_2_children_seated_option_3.nil?)
      self.children_seated_option(2,3).click()        
    end 

    # room 2 - children seated option 4
    if !(package.room_2_children_seated_option_4.nil?)
      self.children_seated_option(2,4).click()         
    end    
        
    # room 2 - children seated option 5
    if !(package.room_2_children_seated_option_5.nil?)
      self.children_seated_option(2,5).click()         
    end         

    # room 3 - children seated option 1    
    if !(package.room_3_children_seated_option_1.nil?)
      self.children_seated_option(3,1).click()         
    end 

    # room 3 - children seated option 2    
    if !(package.room_3_children_seated_option_2.nil?)
      self.children_seated_option(3,2).click()         
    end 

    # room 3 - children seated option 3
    if !(package.room_3_children_seated_option_3.nil?)
      self.children_seated_option(3,3).click()        
    end 

    # room 3 - children seated option 4
    if !(package.room_3_children_seated_option_4.nil?)
      self.children_seated_option(3,4).click()         
    end    
        
    # room 3 - children seated option 5
    if !(package.room_3_children_seated_option_5.nil?)
      self.children_seated_option(3,5).click()         
    end   

    # room 4 - children seated option 1    
    if !(package.room_4_children_seated_option_1.nil?)
      self.children_seated_option(4,1).click()         
    end 

    # room 4 - children seated option 2    
    if !(package.room_4_children_seated_option_2.nil?)
      self.children_seated_option(4,2).click()         
    end 

    # room 4 - children seated option 3
    if !(package.room_4_children_seated_option_3.nil?)
      self.children_seated_option(4,3).click()        
    end 

    # room 4 - children seated option 4
    if !(package.room_4_children_seated_option_4.nil?)
      self.children_seated_option(4,4).click()         
    end    
        
    # room 4 - children seated option 5
    if !(package.room_4_children_seated_option_5.nil?)
      self.children_seated_option(4,5).click()         
    end   
    
    # room 1 - children lap option 1    
    if !(package.room_1_children_lap_option_1.nil?)
      self.children_lap_option(1,1).click()      
    end 

    # room 1 - children lap option 2    
    if !(package.room_1_children_lap_option_2.nil?)
      self.children_lap_option(1,2).click()        
    end 

    # room 1 - children lap option 3
    if !(package.room_1_children_lap_option_3.nil?)
      self.children_lap_option(1,3).click()    
    end 

    # room 1 - children lap option 4
    if !(package.room_1_children_lap_option_4.nil?)
      self.children_lap_option(1,4).click()        
    end        
    
    # room 1 - children lap option 5
    if !(package.room_1_children_lap_option_5.nil?)
      self.children_lap_option(1,5).click()        
    end       

    # room 2 - children lap option 1    
    if !(package.room_2_children_lap_option_1.nil?)
      self.children_lap_option(2,1).click()      
    end 

    # room 2 - children lap option 2    
    if !(package.room_2_children_lap_option_2.nil?)
      self.children_lap_option(2,2).click()        
    end 

    # room 2 - children lap option 3
    if !(package.room_2_children_lap_option_3.nil?)
      self.children_lap_option(2,3).click()    
    end 

    # room 2 - children lap option 4
    if !(package.room_2_children_lap_option_4.nil?)
      self.children_lap_option(2,4).click()        
    end        
    
    # room 2 - children lap option 5
    if !(package.room_2_children_lap_option_5.nil?)
      self.children_lap_option(2,5).click()        
    end         

    # room 3 - children lap option 1    
    if !(package.room_3_children_lap_option_1.nil?)
      self.children_lap_option(3,1).click()      
    end 

    # room 3 - children lap option 2    
    if !(package.room_3_children_lap_option_2.nil?)
      self.children_lap_option(3,2).click()        
    end 

    # room 3 - children lap option 3
    if !(package.room_3_children_lap_option_3.nil?)
      self.children_lap_option(3,3).click()    
    end 

    # room 3 - children lap option 4
    if !(package.room_3_children_lap_option_4.nil?)
      self.children_lap_option(3,4).click()        
    end        
    
    # room 3 - children lap option 5
    if !(package.room_3_children_lap_option_5.nil?)
      self.children_lap_option(3,5).click()        
    end       
    
    # room 4 - children lap option 1    
    if !(package.room_4_children_lap_option_1.nil?)
      self.children_lap_option(4,1).click()      
    end 

    # room 4 - children lap option 2    
    if !(package.room_4_children_lap_option_2.nil?)
      self.children_lap_option(4,2).click()        
    end 

    # room 4 - children lap option 3
    if !(package.room_4_children_lap_option_3.nil?)
      self.children_lap_option(4,3).click()    
    end 

    # room 4 - children lap option 4
    if !(package.room_4_children_lap_option_4.nil?)
      self.children_lap_option(4,4).click()        
    end        
    
    # room 4 - children lap option 5
    if !(package.room_4_children_lap_option_5.nil?)
      self.children_lap_option(4,5).click()        
    end       
        
    # show only non stop flights checkbox
    if !(package.show_only_non_stop_flights.nil?)
      if (package.show_only_non_stop_flights)
        self.show_only_non_stop_flights_checkbox.click()
      end    
    end   
     
    sleep 2
    
    # Click on submit button
    self.search_button.click() 
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
	
	def departure_date_textbox
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @departure_date_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name("departure date textbox").by_id_locator)
	  @departure_date_textbox if @departure_date_textbox.displayed?
	}	
	end
    
    def date_calendar
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @date_calendar = self.driver.find_element(:id => self.db_object.elements.find_by_name('date calendar').by_id_locator)
	  @date_calendar if @date_calendar.displayed?
	}	
	end

    def date_calendar_next
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @date_calendar_next = self.driver.find_element(:css => self.db_object.elements.find_by_name('date calendar next icon').by_css_locator)
	  @date_calendar_next if @date_calendar_next.displayed?
	}	
	end


	def departure_time_combobox
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @departure_time_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name("departure time combobox").by_css_locator)
	  @departure_time_combobox if @departure_time_combobox.displayed?
	}	
	end
    
	def return_date_textbox 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @return_date_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('return date textbox').by_id_locator)
	  @return_date_textbox if @return_date_textbox.displayed?
	}	
	end  
	
	def return_time_combobox  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @return_time_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('return time combobox').by_css_locator)
	  @return_time_combobox if @return_time_combobox.displayed?
	}	
	end  
    
	def search_button 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @search_flights_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('search button').by_css_locator)
	  @search_flights_button if @search_flights_button.displayed?
	}	
	end	
  
	def rooms_combobox 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @rooms_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('rooms combobox').by_css_locator)
	  @rooms_combobox if @rooms_combobox.displayed?
	}	
	end	  
  
	def rooms_combobox_selected_option
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @rooms_combobox_selected_option = self.driver.find_element(:css => self.db_object.elements.find_by_name('rooms combobox selected option').by_css_locator)
	  @rooms_combobox_selected_option if @rooms_combobox_selected_option.displayed?
	}	
	end	    
    
	def adults_combobox(index) 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @adults_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name("adults combobox #{index}").by_css_locator)
	  @adults_combobox if @adults_combobox.displayed?
	}	
	end
  
	def adults_combobox_selected_option(index) 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @adults_combobox_selected_option = self.driver.find_element(:css => self.db_object.elements.find_by_name("adults combobox selected option #{index}").by_css_locator)
	  @adults_combobox_selected_option if @adults_combobox_selected_option.displayed?
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
    @children_age_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name("room #{room} - age of child combobox #{index}").by_css_locator)
	  @children_age_combobox if @children_age_combobox.displayed?
	}	
	end	 
  
	def children_seated_option(room,index) 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @children_seated_option = self.driver.find_element(:css => self.db_object.elements.find_by_name("room #{room} - child in seat option #{index}").by_css_locator)
	  @children_seated_option if @children_seated_option.displayed?
	}
	end  
  
	def children_seated_option_input(room,index)
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @children_seated_option_input = self.driver.find_element(:id => self.db_object.elements.find_by_name("room #{room} - child in seat option input #{index}").by_id_locator)
	  @children_seated_option_input if @children_seated_option_input.displayed?
	}
	end     
  
	def children_lap_option(room,index) 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @children_lap_option = self.driver.find_element(:css => self.db_object.elements.find_by_name("room #{room} - child in lap option #{index}").by_css_locator)
	  @children_lap_option if @children_lap_option.displayed?
	}
	end 
  
	def children_lap_option_input(room,index) 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @children_lap_option_input = self.driver.find_element(:id => self.db_object.elements.find_by_name("room #{room} - child in lap option input #{index}").by_id_locator)
	  @children_lap_option_input if @children_lap_option_input.displayed?
	}
	end     

  def show_only_non_stop_flights_checkbox  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @show_only_non_stop_flights_checkbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('show only non-stop flights checkbox').by_id_locator)
	  @show_only_non_stop_flights_checkbox if @show_only_non_stop_flights_checkbox.displayed?
	}	
	end	  
  
  def how_many_rooms_and_travelers_label
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @how_many_rooms_and_travelers_label = self.driver.find_elements(:css => self.db_object.elements.find_by_name('how many rooms and travelers labels').by_css_locator)[0]
	  @how_many_rooms_and_travelers_label if @how_many_rooms_and_travelers_label.displayed?
	}	
	end  
    
  def how_many_rooms_and_travelers_help_link
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @how_many_rooms_and_travelers_help_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('how many rooms and travelers help link').by_css_locator)
	  @how_many_rooms_and_travelers_help_link if @how_many_rooms_and_travelers_help_link.displayed?
	}	
	end    
 
  def help_popup_close_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @help_popup_close_button = self.driver.find_elements(:css => self.db_object.elements.find_by_name('help popup close button').by_css_locator)[0]
	  @help_popup_close_button if @help_popup_close_button.displayed?
	}	
	end  
  
  def help_popup_text_paragraphs
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @help_popup_text_paragraphs = self.driver.find_elements(:css => self.db_object.elements.find_by_name('help popup text paragraphs').by_css_locator)
    @help_popup_text_paragraphs if @help_popup_text_paragraphs[0].displayed?
  }
  end   
   
  def help_popup_innerhtml_element
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @help_popup_innerhtml_element = self.driver.find_element(:css => self.db_object.elements.find_by_name('help popup innerhtml element').by_css_locator)
	  @help_popup_innerhtml_element if @help_popup_innerhtml_element.displayed?
	}	
	end

  def where_are_you_going_subtitle_text_element
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @where_are_you_going_subtitle_text_element = self.driver.find_element(:css => self.db_object.elements.find_by_name('where are you going subtitle text element').by_css_locator)
	  @where_are_you_going_subtitle_text_element if @where_are_you_going_subtitle_text_element.displayed?
	}	
	end

  def search_error_messages
  	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @search_error_messages = self.driver.find_element(:css => self.db_object.elements.find_by_name('package search error messages').by_css_locator)
	  @search_error_messages if @search_error_messages.displayed?
	}	
  end  

  def airports_overlay_departure_link 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @airports_worldwide_departure_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports overlay departure link').by_css_locator)
	  @airports_worldwide_departure_link if @airports_worldwide_departure_link.displayed?
	}	
	end	
  
  def airports_overlay_arrival_link 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @airports_worldwide_arrival_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports overlay arrival link').by_css_locator)
	  @airports_worldwide_arrival_link if @airports_worldwide_arrival_link.displayed?
	}	
	end	 

end
