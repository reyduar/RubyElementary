require 'rubygems'
require 'selenium-webdriver'
require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require 'spec_helper'
require_relative '../pages/hotel_search_page'
require_relative '../pages/hotel_results_page'
require_relative '../pages/hotel_description_page'
require_relative '../db/models/database_model'

describe AMEX_Hotel do
  describe Week_02 do
    describe "Hotel: AXPT-3365 - Provide user with the ability to return to the Hotel search results" do    
      driver = nil
      page = nil
      first_result_title_names = []
      bridge = Selenium::WebDriver::Navigation   
      feature = Feature.find_by_name('information expanded hotel property card')
      
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
      it "On the hotel details page there is a link to return to hotel search." do
        page = HotelSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_hotel('sort results hotel search')
        page = HotelResultsPage.new(driver, RSpec.configuration.env)
        page.results_hotel_names.each_with_index { |title_name,index|
          if !(title_name.text().empty?)
              first_result_title_names[index] = title_name.text().upcase
          end } 
        page.show_hotel_highlights_button.click
        page.hotel_card_more_description_link.click
        page = HotelDescriptionPage.new(driver, RSpec.configuration.env)
        page.back_to_search_results_link.should be_present()
        page.back_to_search_results_link.text().should eq(feature.verifications.find_by_name('back to search link text').text)
      end 
      it "If clicked, the customer returns to previous hotel search results in List view." do
        page.back_to_search_results_link.click
        page = HotelResultsPage.new(driver, RSpec.configuration.env)
        page.results_hotel_names.each_with_index { |back_result_title_name,index|
          if !(back_result_title_name.text().empty?)
              first_result_title_names[index].should eq(back_result_title_name.text().upcase)
          end } 
      end
      it "The customer returns to default Best value sort view." do
        page.sort_by_combobox.should be_present()
        page.sort_by_combobox.text().should eq(feature.verifications.find_by_name('default combo value text').text) 
      end
    end  
  end
end