require 'rubygems'
require 'selenium-webdriver'
require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require 'spec_helper'
require_relative '../pages/flight_search_page'
require_relative '../pages/flight_results_page'
require_relative '../db/models/database_model'
require_relative '../pages/car_search_page'

describe AMEX_Air do
  describe Week_50 do
    describe "Flight: AXPT-2696 - Default the 'What type of flight do you need?' and 'Where are you going?' values from last search, using a cookie" do    
      driver = nil
      page_car,page_flight = nil 
            
      before(:all) do
        browser = RSpec.configuration.browser 
        case browser
          when "firefox"
            driver = Selenium::WebDriver.for :firefox 
          else
          puts "Error: Case statement needs a valid browser string!"
        end    
      end 
      
      after(:each) do
        if example.failed?
          driver.save_screenshot("logs/screenshot_#{Time.now.strftime('%Y%m%d-%H%M%S')}.png")
        end
      end        
      
      after(:all) do
        driver.quit()
      end   
      
      it "User submits a search and the values under 'What type of flight do you need?' and 'Where are you going?' 
         sections are saved in a cookie. User has the ability to see the defaulted value in the search form after closing and reopening 
         the browser." do
        # Cookies - Round Trip search
        page_car = CarSearchPage.new(driver, RSpec.configuration.env)
        page_flight = FlightSearchPage.new(driver, RSpec.configuration.env)
        page_flight.visit()
        page_flight.book_a_flight('basic round trip rate card alert')
        page_car.visit()
        page_flight.visit()
        departure_city_text_value = driver.execute_script("return arguments[0].value" , page_flight.departure_city_textbox(1))
        arrival_city_text_value = driver.execute_script("return arguments[0].value" , page_flight.arrival_city_textbox(1))
        flight = Flight.find_by_name('basic round trip rate card alert')
        departure_city_text_value.should eq(flight.departure_city_1)
        arrival_city_text_value.should eq(flight.arrival_city_1)
        # Cookies - One way search 
        page_flight.visit() 
        driver.execute_script("arguments[0].value = ''" , page_flight.departure_city_textbox(1))
        driver.execute_script("arguments[0].value = ''" , page_flight.arrival_city_textbox(1))
        page_flight.book_a_flight('one way - matrix options')
        page_car.visit()
        page_flight.visit()  
        departure_city_text_value = driver.execute_script("return arguments[0].value" , page_flight.departure_city_textbox(1))
        arrival_city_text_value = driver.execute_script("return arguments[0].value" , page_flight.arrival_city_textbox(1))
        flight = Flight.find_by_name('one way - matrix options')
        departure_city_text_value.should eq(flight.departure_city_1)
        arrival_city_text_value.should eq(flight.arrival_city_1)
        # Cookies - Multi city search
        page_flight.visit()       
        driver.execute_script("arguments[0].value = ''" , page_flight.departure_city_textbox(1))
        driver.execute_script("arguments[0].value = ''" , page_flight.arrival_city_textbox(1))
        page_flight.book_a_flight('basic multi city')
        page_car.visit()
        page_flight.visit()  
        departure_city_text_value = driver.execute_script("return arguments[0].value" , page_flight.departure_city_textbox(1))
        arrival_city_text_value = driver.execute_script("return arguments[0].value" , page_flight.arrival_city_textbox(1))
        flight = Flight.find_by_name('basic multi city')
        departure_city_text_value.should eq(flight.departure_city_1)
        arrival_city_text_value.should eq(flight.arrival_city_1)
      end     
    end  
  end
end