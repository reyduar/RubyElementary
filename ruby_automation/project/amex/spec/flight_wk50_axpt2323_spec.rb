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

describe AMEX_Air do
  describe Week_50 do
    describe "Flight: AXPT-2323 - Provide ability to request refundable only fares on Air search form" do    
      driver = nil
      page = nil 
      feature = Feature.find_by_name('show only refundable fares') 
      
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
      
      it "On the Air search page there is a link to Airports below the entry boxes for airport/city.
          Refundable label: Show me only refundable fares (can be more expensive)" do
        page = FlightSearchPage.new(driver, RSpec.configuration.env)
        page.visit()       
        page.should be_element_present(page,"show only refundable fares checkbox", "id")
        page.show_only_refundable_fares_label.text().should eq(feature.verifications.find_by_name('show only refundable fares label text').text)  
      end     
                 
      it "The default will be un-checked so that all fare types are returned" do
         page.show_only_refundable_fares_checkbox.should_not be_selected()       
      end
                 
      it "If checked, specify in air search request only refundable fares are to be returned.
          if refundable options are available, air search results page will display with options returned.
          If there are no flights returned then 'No flights found for search request' will be displayed on air search results page." do  
        page.show_only_refundable_fares_checkbox.click()          
        page.book_a_flight('basic one way')
        page = FlightResultsPage.new(driver, RSpec.configuration.env)          
        page.should be_element_present(page,"flight results container", "css")
        page.should_not be_search_error_messages_present()  
      end 

      it "Refundable fare check box can be used in conjunction with any other modifier like cabin class, carrier preference or nonstop only." do
        page = FlightSearchPage.new(driver, RSpec.configuration.env)
        page.visit()   
        #  cabin class
        page.select_option(page.fare_class_combobox, 'First Class') 
        #  nonstop only    
        page.show_only_non_stop_flights_checkbox.click()
        #  carrier preference          
        page.search_only_preferred_airline_checkbox.click()
        #  only refundable
        page.show_only_refundable_fares_checkbox.click()          
        page.book_a_flight('basic one way')
        page = FlightResultsPage.new(driver, RSpec.configuration.env)          
        page.should be_element_present(page,"flight results container", "css")
        page.should_not be_search_error_messages_present()  
      end
    end  
  end
end