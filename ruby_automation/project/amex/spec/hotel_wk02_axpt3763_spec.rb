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
require_relative '../pages/hotel_checkout_page'
require_relative '../db/models/database_model'

describe AMEX_Hotel do
  describe Week_02 do
    describe "Hotel: AXPT-3763 - Provide ability to select hotel to purchase in property card" do    
      driver = nil
      page = nil
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
      it "On the property card there is a 'Select' button." do
        page = HotelSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_hotel('basic hotel search')
        page = HotelResultsPage.new(driver, RSpec.configuration.env)
        page.hotel_card_select_button.should be_present()
        page.hotel_card_select_button.text().should eq(feature.verifications.find_by_name('select button text').text)
      end 
      it "On click, a Hotel shop for the specific hotel property is kicked off. This returns all available rates at the property." do
        page.hotel_card_select_button.click
        page = HotelCheckoutPage.new(driver, RSpec.configuration.env)
        page.checkout_title.should be_present()
        page.checkout_title.text().should eq(feature.verifications.find_by_name('checkout title text').text) 
      end
      it "Successful hotel shop lands the customer on the Hotel details page on the 'Rooms and Rates' tab." do
         page.more_details_link.click
         page = HotelDescriptionPage.new(driver, RSpec.configuration.env)
         page.rooms_and_rates_tab.should be_present()
         page.rooms_and_rates_tab.click
         page.lowest_rate_guaranteed_tab.text().should eq(feature.verifications.find_by_name('Lowest Rate guaranteed text').text)
      end
    end  
  end
end