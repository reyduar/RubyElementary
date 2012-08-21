require 'rubygems'
require 'selenium-webdriver'
require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require 'spec_helper'
require_relative '../pages/car_search_page'
require_relative '../db/models/database_model'

describe AMEX_Car do
  describe Week_50 do
    describe "Car: AXPT-2913 - Display Car Search Summary bar validation errors in the Result Page" do       
      driver = nil
      page = nil 

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

      it "If there is a validation error in the summary bar, the user gets back to the search result page 
          with a corresponding error message (TBD)" do       
        feature = Feature.find_by_name('search car errors')
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        # Make an invalid search
        page.book_a_car('NOLA pick up date only')
        page.search_cars_button.click()
        # Check if we are in the same page
        driver.current_url.split("/").last.should == feature.verifications.find_by_name('same url').text
        # Check for the error message
        page.car_errors.present?
        # Check for the error text
        feature = Feature.find_by_name('car result errors')
        page.should be_text_present(feature.verifications.find_by_name('missing dropoff').text)
      end   
    end
  end
end
