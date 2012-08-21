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
  describe Sprint_05 do
    describe "Car: AXPT-3767 - Provide ability to see the cars that are pay later in the car rate cards of the result page" do    
      driver = nil
      page = nil    
      
      car_results_titles_banners_feature = Feature.find_by_name('car results titles banners')
      
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

      it "User is able to see a Book Now, Pay Later banner at the top of the rate card to the left of the vendor logo.
          Label: 'Book Now, Pay Later'" do
         #Navigate to search car
         page = CarSearchPage.new(driver, RSpec.configuration.env)
         page.visit()
         page.book_a_car('same location basic w/o discount')
         page.search_cars_button.click()
         page = CarResultsPage.new(driver, RSpec.configuration.env)     
         sleep 3         
         #Scan each card and take the banner       
         page.car_book_now_pay_later_titles_banners.each {|labels|                              
           #Validate banners' titles
           labels.text.should eq (car_results_titles_banners_feature.verifications.find_by_name('car book now pay later title banner').text)                     
         }                 
      end          
    end
  end
end