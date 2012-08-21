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
    describe "Car: AXPT-2890 - Discount Code Option in Search form (Invalid Discount code)" do    
      driver = nil  
     
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
        
      it "If the discount code is invalid for the search conducted the 
          search results will still display and show all vendors will a 
          warning that the discount code requested was not applied. The 
          warning should read: 'The discount code you entered was invalid 
          and not applied to this search'." do
        page = CarSearchPage.new(driver, 'QAFirefox')
        page.visit()
        page.book_a_car('same location trip invalid coupon')
        page.search_cars_button.click()
        page = CarResultsPage.new(driver, 'QAFirefox')
        feature = Feature.find_by_name('invalid coupon car')
        page.should be_text_present(feature.verifications.find_by_name('invalid coupon car text').text)
      end  
      
      it "If the discount code is not applicable for the search conducted 
          the search results will still display and show all vendors will a 
          warning that the discount code requested was not applied. The 
          warning should read: 'The discount code you entered could not be 
          applied, we are showing alternate available rentals for your 
          selected time/date'." do
        page = CarSearchPage.new(driver, 'QAFirefox')
        page.visit()
        page.book_a_car('same location trip NA coupon')
        page.search_cars_button.click()
        page = CarResultsPage.new(driver, 'QAFirefox')
        feature = Feature.find_by_name('N.A coupon car')
        page.should be_text_present(feature.verifications.find_by_name('not applicable coupon car text').text)
      end     
    end   
  end
end