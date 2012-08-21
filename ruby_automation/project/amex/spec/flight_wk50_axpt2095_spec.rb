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
    describe "Flight: AXPT-2095 - Display cabin class edit link in the air search summary bar" do    
      driver = nil  
      page = nil 
      feature = Feature.find_by_name('fare class link feature') 
      
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
      
      it "The cabin class (Economy, Business, First) selected from the original search will be persisted 
          and appear as a link in the air search summary bar" do
          page = FlightSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_flight('basic one way - first class') 
          page = FlightResultsPage.new(driver, RSpec.configuration.env)     
          page.fare_class_link.text().should eq(feature.verifications.find_by_name('fare class link text 1').text)
      end   
      
      it "If the link is clicked it will expand to show a cabin class drop down with the 3 cabins shown
          It will be possible to select an alternate cabin to the one originally selected 
          or click out of the expanded box to retain the original value" do   
          page.fare_class_link.click()
          page.select_option(page.fare_class_link, feature.verifications.find_by_name('fare class link text 2').text)
          page.fare_class_link.text().should eq(feature.verifications.find_by_name('fare class link text 2').text)      
          page.select_option(page.fare_class_link, feature.verifications.find_by_name('fare class link text 3').text) 
          page.fare_class_link.text().should eq(feature.verifications.find_by_name('fare class link text 3').text)         
          page.select_option(page.fare_class_link, feature.verifications.find_by_name('fare class link text 1').text) 
          page.fare_class_link.text().should eq(feature.verifications.find_by_name('fare class link text 1').text)         
      end    
         
      it "If the link is clicked it will expand to show a cabin class drop down with the 3 cabins shown
          It will be possible to select an alternate cabin to the one originally selected 
          or click out of the expanded box to retain the original value" do   
          page.select_option(page.fare_class_link, feature.verifications.find_by_name('fare class link text 2').text)
          page.fare_class_link.text().should eq(feature.verifications.find_by_name('fare class link text 2').text)      
          page.select_option(page.fare_class_link, feature.verifications.find_by_name('fare class link text 3').text) 
          page.fare_class_link.text().should eq(feature.verifications.find_by_name('fare class link text 3').text)         
          page.select_option(page.fare_class_link, feature.verifications.find_by_name('fare class link text 1').text) 
          page.fare_class_link.text().should eq(feature.verifications.find_by_name('fare class link text 1').text)         
      end 
       
      it "Clicking on the update button will kick off a new air search using the newly selected search parameter" do  
          page.select_option(page.fare_class_link, feature.verifications.find_by_name('fare class link text 2').text)
          page.fare_class_link.text().should eq(feature.verifications.find_by_name('fare class link text 2').text)      
          page.update_button.click() 
          page.fare_class_link.text().should eq(feature.verifications.find_by_name('fare class link text 2').text)     
      end    
    end    
  end
end