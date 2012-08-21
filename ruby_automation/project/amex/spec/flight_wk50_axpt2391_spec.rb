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
    describe "Flight: AXPT-2391 - Provide specific slice information for different types of air search" do    
      driver = nil
      page = nil 
      feature = Feature.find_by_name('slice flight type titles')
      verifications = nil
      
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
      
      it "Make a One Way search and validate that each slice in the result page is labeled in the correct way." do         
        page = FlightSearchPage.new(driver, RSpec.configuration.env)
        page.visit()       
        page.book_a_flight('basic one way') 
        page = FlightResultsPage.new(driver, RSpec.configuration.env)  
        verifications = eval(feature.verifications.find_by_name('slice titles for one way').text)         
        page.slice_flight_type_titles.each_with_index { |slice_title,index|  slice_title.text().should eq(verifications[index])}              
      end
      
      it "One Way: Label for every search type remains even when the user expand and collapse the flight details of the slice" do
        page.slice_show_hide_flight_details_buttons.each { |button|  button.click()}        
        sleep 1
        page.slice_flight_type_titles.each_with_index { |slice_title,index|  slice_title.text().should eq(verifications[index])}  
        page.slice_show_hide_flight_details_buttons.each { |button|  button.click()}  
        sleep 1
        page.slice_flight_type_titles.each_with_index { |slice_title,index|  slice_title.text().should eq(verifications[index])} 
        page = nil        
      end
              
      it "Make a Round Trip search and validate that each slice in the result page is labeled in the correct way." do         
        page = FlightSearchPage.new(driver, RSpec.configuration.env)
        page.visit()       
        page.book_a_flight('basic round trip') 
        page = FlightResultsPage.new(driver, RSpec.configuration.env)  
        verifications = eval(feature.verifications.find_by_name('slice titles for round trip').text)         
        page.slice_flight_type_titles.each_with_index { |slice_title,index|  slice_title.text().should eq(verifications[index])}              
      end

      it "Round Trip: Label for every search type remains even when the user expand and collapse the flight details of the slice" do
        page.slice_show_hide_flight_details_buttons.each { |button|  button.click()}        
        sleep 1
        page.slice_flight_type_titles.each_with_index { |slice_title,index|  slice_title.text().should eq(verifications[index])}  
        page.slice_show_hide_flight_details_buttons.each { |button|  button.click()}  
        sleep 1
        page.slice_flight_type_titles.each_with_index { |slice_title,index|  slice_title.text().should eq(verifications[index])}        
        page = nil          
      end      
      
      it "Make a Multi City search and validate that each slice in the result page is labeled in the correct way." do         
        page = FlightSearchPage.new(driver, RSpec.configuration.env)
        page.visit()       
        page.book_a_flight('basic multi city 2') 
        page = FlightResultsPage.new(driver, RSpec.configuration.env)  
        verifications = eval(feature.verifications.find_by_name('slice titles for multi city').text)         
        page.slice_flight_type_titles.each_with_index { |slice_title,index|  slice_title.text().should eq(verifications[index])}  
      end   

      it "Multi City: Label for every search type remains even when the user expand and collapse the flight details of the slice" do
        page.slice_show_hide_flight_details_buttons.each { |button|  button.click()}        
        sleep 1
        page.slice_flight_type_titles.each_with_index { |slice_title,index|  slice_title.text().should eq(verifications[index])}  
        page.slice_show_hide_flight_details_buttons.each { |button|  button.click()}  
        sleep 1
        page.slice_flight_type_titles.each_with_index { |slice_title,index|  slice_title.text().should eq(verifications[index])}      
      end      
    end  
  end
end