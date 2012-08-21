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
    describe "Flight: AXPT-2097 - Display number of travelers edit link in the air search summary bar" do       
      driver = nil
      page = nil 
      feature = Feature.find_by_name('number of travelers') 

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
      
      it "The number of travelers will appear in the search summary bar as a link." do       
          page = FlightSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_flight('round trip 2 adult 2 senior 4 children') 
          page = FlightResultsPage.new(driver, RSpec.configuration.env)   
          page.number_of_travelers_link.text().should eq(feature.verifications.find_by_name('number of travelers link text for 8').text)            
      end   
      
      it "Clicking on the link will expand a box on the page with drop downs for all traveler types:
          adult, children, seniors, lap infant, seat infant. This information is persisted from the original search." do
          page.number_of_travelers_link.click()
          page.adults_combobox.text().should eq(feature.verifications.find_by_name('adults combobox value for 8').text) 
          page.seniors_combobox.text().should eq(feature.verifications.find_by_name('seniors combobox value for 8').text) 
          page.children_combobox.text().should eq(feature.verifications.find_by_name('children combobox value for 8').text)  
          page.children_age_combobox(1).text().should eq(feature.verifications.find_by_name('children age combobox 1 value for 8').text) 
          page.children_age_combobox(2).text().should eq(feature.verifications.find_by_name('children age combobox 2 value for 8').text) 
          page.children_age_combobox(3).text().should eq(feature.verifications.find_by_name('children age combobox 3 value for 8').text) 
          page.children_age_combobox(4).text().should eq(feature.verifications.find_by_name('children age combobox 4 value for 8').text) 
          page.children_seated_option_input(1).should_not be_selected() 
          page.children_lap_option_input(1).should be_selected()       
          page.children_seated_option_input(3).should be_selected()      
          page.children_lap_option_input(3).should_not be_selected()        
      end  
      
      it "It will be possible to select from the drop downs the appropriate number of travelers now needed on the search.
          Clicking on the update button within the search summary bar will kick off a new air search for the new parameters entered.
          Max number of passengers allowed is 9, including lap and seated infants." do 
          page.select_option(page.adults_combobox, '4')
          page.select_option(page.seniors_combobox, '4')
          page.select_option(page.children_combobox, '4')     
          page.update_button.click() 
          page.search_error_messages.each_with_index { |error_message,index|  error_message.text().should eq(feature.verifications.find_by_name('max number of passengers error message').text)}   
      end
      
      it "Each lap infant must have an accompanying adult or senior.
          At least 1 adult or 1 senior must be on the itinerary." do
          page.number_of_travelers_link.click()
          page.select_option(page.adults_combobox, '0')
          page.select_option(page.seniors_combobox, '0')
          page.update_button.click()       
          verifications = eval(feature.verifications.find_by_name('lap infant accompanying error messages').text)
          page.search_error_messages.each_with_index { |error_message,index|  error_message.text().should eq(verifications[index])}   
      end

      it "There can be multiple seated infants per adult or senior and/or multiple children per adult or senior." do      
          # multiple children per adult
          page.number_of_travelers_link.click()
          page.select_option(page.adults_combobox, '1')
          page.select_option(page.seniors_combobox, '0')
          page.select_option(page.children_combobox, '8')
          page.update_button.click() 
          page = nil
          page = FlightResultsPage.new(driver, RSpec.configuration.env)       
          page.should_not be_search_error_messages_present() 
          # multiple children per senior
          page.number_of_travelers_link.click()
          page.select_option(page.adults_combobox, '0')
          page.select_option(page.seniors_combobox, '1')
          page.select_option(page.children_combobox, '8') 
          page.update_button.click()       
          page = nil      
          page = FlightResultsPage.new(driver, RSpec.configuration.env)       
          page = FlightResultsPage.new(driver, RSpec.configuration.env)       
          page.should_not be_search_error_messages_present()      
      end  
    end  
  end
end