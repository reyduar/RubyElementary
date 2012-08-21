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
require_relative '../pages/flight_disambiguation_page'
require_relative '../db/models/database_model'

describe AMEX_Air do
  describe Week_50 do
    describe "Flight: AXPT-2096 - Provide ability to edit one way or round trip itinerary in search summary bar" do       
      driver = nil 
      page = nil 
      feature = Feature.find_by_name('edit itinerary on summary bar feature') 

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
      
      it "If the itinerary is one way or round trip there will be an outbound and return text box shown in edit mode
          The searched for airport code and airport name will be displayed in each box" do       
          page = FlightSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_flight('basic one way') 
          page = FlightResultsPage.new(driver, RSpec.configuration.env)       
          departure_city_text_value = driver.execute_script("return arguments[0].value" , page.departure_city_textbox)
          arrival_city_text_value = driver.execute_script("return arguments[0].value" , page.arrival_city_textbox) 
          departure_city_text_value.should eq(feature.verifications.find_by_name('departure city text').text)  
          arrival_city_text_value.should eq(feature.verifications.find_by_name('arrival city text').text)           
      end   
      
      it "Each entry box can be edited to input a new single airport code or city name" do
          page.departure_city_clear_button.click()
          page.arrival_city_clear_button.click()
          page.enter_airport(page.departure_city_textbox,feature.verifications.find_by_name('arrival city text').text)
          page.enter_airport(page.arrival_city_textbox,feature.verifications.find_by_name('departure city text').text)   
      end  
      
      it "Clicking the Update button with kick off a new air search using the newly input outbound and return" do       
          page.update_button.click() 
          departure_city_text_value = driver.execute_script("return arguments[0].value" , page.departure_city_textbox)
          arrival_city_text_value = driver.execute_script("return arguments[0].value" , page.arrival_city_textbox) 
          departure_city_text_value.should eq(feature.verifications.find_by_name('arrival city text').text)  
          arrival_city_text_value.should eq(feature.verifications.find_by_name('departure city text').text)        
      end
      
      it "If either origin or destination are ambiguous a page will display requiring the user to select the desired location
          from a suggestion list before the search can be done." do       
          page.departure_city_clear_button.click()
          page.arrival_city_clear_button.click()
          page.departure_city_textbox.send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)
          page.arrival_city_textbox.send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)        
          page.update_button.click() 
          page = FlightDisambiguationPage.new(driver, RSpec.configuration.env) 
          page.should be_text_present(feature.verifications.find_by_name('disambiguation page title').text)
          page.departure_city_disambiguation_option_button.click()
          page.arrival_city_disambiguation_option_button.click()
          page.update_flight_search_button.click()
          page = FlightResultsPage.new(driver, RSpec.configuration.env)  
          departure_city_text_value = driver.execute_script("return arguments[0].value" , page.departure_city_textbox)
          arrival_city_text_value = driver.execute_script("return arguments[0].value" , page.arrival_city_textbox) 
          departure_city_text_value.should eq(feature.verifications.find_by_name('departure city text').text)  
          arrival_city_text_value.should eq(feature.verifications.find_by_name('arrival city text').text)        
      end  
    end  
  end
end