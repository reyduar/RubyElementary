require 'rubygems'
require 'selenium-webdriver'
require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require 'spec_helper'
require_relative '../pages/car_search_page'
require_relative '../pages/car_results_page'
require_relative '../db/models/database_model'


describe AMEX_Car do
  describe Week_52 do
    describe "Car: AXPT-3109 - Display strikethrough pricing on Matrix total amount" do       
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

      it "Display a strike through price for the total" do       
        feature = Feature.find_by_name('search cars results')
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        # Make a search with AVIS discount
        page.book_a_car('NOLA and AVIS discount')
        page.search_cars_button.click()
        page = CarResultsPage.new(driver, RSpec.configuration.env)
        # Check for strike through price on Total Matrix
        page.strikethrough_on_total_matrix.present?
      end   
    end
  end
end
