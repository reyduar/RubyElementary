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
require_relative '../pages/car_selected_page'
require_relative '../db/models/database_model'

describe AMEX_Car do
  describe Week_50 do
    describe "Car: AXPT-3434 - Provide ability to have the option to 
              change my car in the Car Review Page" do       
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
    
      it "User is able to see a link to change car AND User clicks the change car link and is taken back 
          to the car search result page" do
          
          # Note: According to the task, "Any filters or sorts that 
          # existed when the customer last visited the search results 
          # will not be applied. Filter example: Car Class, Car Company
          # User must see car results based on the original criteria
          
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          #page.book_a_car('NOLA and AVIS w/o discount')
          # STD SEARCH
          page.book_a_car('same location basic w/o discount')          
          page.search_cars_button.click()
          page = CarResultsPage.new(driver, RSpec.configuration.env)
          # Select a type of car
          page.car_type_first_cell.click()
          # Count how many cars there are for this type (check company filter)
          before_change_car_matches = Integer(page.matches_cars_text.text.split()[0])
          # Select the car from the first car card
          page.select_first_car.click()
          page = CarSelectedPage.new(driver, RSpec.configuration.env)
          # Look for the link
          page.change_car_link.present?
          # Click in the link
          page.change_car_link.click()
          # Check page URL
          feature = Feature.find_by_name('change car')
          current_url = driver.current_url
          current_url.include?(feature.verifications.find_by_name('change car url').text).should be true
          page = CarResultsPage.new(driver, RSpec.configuration.env)
          after_change_car_matches = Integer(page.matches_cars_text.text.split()[0])
          # Check if filters are still being applied
          after_change_car_matches.should be > before_change_car_matches
      end
    end
  end
end
