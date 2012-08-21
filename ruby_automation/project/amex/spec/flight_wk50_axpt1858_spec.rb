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
    describe "Flight: AXPT-1858 - Display Airline Baggage Explanation below matrix on air search page" do           
      driver = nil 
      page = nil 
      baggage_fee = BaggageFee.find_by_name('delta darwin') 
      feature = Feature.find_by_name('baggage fees feature') 
      
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
      
      it "Below the air matrix will be a link to baggage charges.
          Link text should be 'baggage charges'." do  
          page = FlightSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_flight('basic one way') 
          page = FlightResultsPage.new(driver, RSpec.configuration.env)
          page.baggage_charges_link.text().should eq(feature.verifications.find_by_name('baggage fees link text').text)  
      end 

      it  "When clicked the link will produce an overlay that shows a dropdown 
          so the customer can choose the airline whose fees they want to see. 
          The airline drop down list is single select.
          Once an airline is chosen the overlay is refreshed and shows the details of the chosen airline's baggage fees." do  
        page.baggage_charges_link.click()
        page.select_option(page.baggage_fees_combobox, baggage_fee.first_airline)    
        page.should be_text_present(feature.verifications.find_by_name('baggage fees detail text').text)
      end    
      
      it "The airline drop down list continues to appear at the top in case the customer wants to choose a different airline." do
        page.select_option(page.baggage_fees_combobox, baggage_fee.second_airline)  
        page.select_option(page.baggage_fees_combobox, baggage_fee.first_airline)    
        page.should be_text_present(feature.verifications.find_by_name('baggage fees detail text').text)
      end   

      it "If an airline is chosen that does not have baggage data stored a message should be displayed saying that 
          baggage fees may apply on this airline please contact them directly for further information." do
        page.select_option(page.baggage_fees_combobox, baggage_fee.third_airline) 
        page.baggage_fees_no_data_message.text().should eq(feature.verifications.find_by_name('baggage fees no data').text)   
      end     
      
      it "A button to dismiss the baggage fee overlay will exist to return the customer to the air matrix." do  
        page.baggage_fees_close_button.click()
        page.baggage_charges_link.click()
        page.baggage_fees_close_button.click()
      end 
    end    
  end
end