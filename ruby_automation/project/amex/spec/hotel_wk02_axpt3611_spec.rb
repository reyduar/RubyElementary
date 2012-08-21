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
    describe "Hotel: AXPT-3611 - Complete links from Hotel Card to Details page" do    
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
      it "Link 'More details' to Hotel details page, with 'Rooms & Rates' tab displaying by default." do
        page = HotelSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_hotel('sort results hotel search')
        page = HotelResultsPage.new(driver, RSpec.configuration.env)
        page.hotel_card_more_details_link.should be_present()
        page.hotel_card_more_details_link.click
        page = HotelDescriptionPage.new(driver, RSpec.configuration.env)
        page.rooms_and_rates_tab.should be_present()
        page.lowest_rate_guaranteed_tab.text().should eq(feature.verifications.find_by_name('Lowest Rate guaranteed text').text)
      end 
    end  
  end
end