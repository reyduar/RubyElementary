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
  describe Week_50 do
    describe "Car: AXPT-1864 - Car rate total price with discount applied" do       
      # NOTE: *rollover out of scope for Day 0 confirmed as per comment in AXPT-1194*
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

      it "If a discount code was applied there will be strikethrough 
          pricing to show the savings with the discount applied." do
          
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('NOLA and AVIS discount')
          page.search_cars_button.click()
          page = CarResultsPage.new(driver, RSpec.configuration.env)
          page.should be_element_present(page, 'car results old price in card', 'css')
      end

      it "On the car rate card the price will show as a total in USD" do       
          
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('NOLA and AVIS discount')
          page.search_cars_button.click()
          page = CarResultsPage.new(driver, RSpec.configuration.env)
          feature = Feature.find_by_name('car card rate')
          # Look for text
          page.car_results_total_price_label.text().should eq(feature.verifications.find_by_name('total cost label').text) 
          # Look for USD sign
          page.car_results_price_currency.text().should eq(feature.verifications.find_by_name('USD currency').text) 
      end  
    end  
  end
end