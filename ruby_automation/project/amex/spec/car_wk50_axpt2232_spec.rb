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
    describe "Car: AXPT-2232 - Provide ability to choose my pick up and drop off locations for One way or Round trip Car Rental" do
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

      it "On the search form there will be a radio button that allows selection of drop off same as pick up (round trip rental) 
          or drop off different than pick up (one way rental). AND
          There will be entry boxes for the car pick up/drop off locations
          Default will be a round trip rental
          " do          
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.car_search_rental_option.present?
          # There will be entry boxes for the car pick up/drop off locations
          page.pickup_city_textbox.present?
          page.different_dropoff_location.click()
          page.dropoff_city_textbox.present?
      end
      
      it "Default will be a round trip rental" do          
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.dropoff_same_as_pickup.selected?
      end

      it "If the selection is change to a one way rental additional text entry fields will be needed to allow entry of the drop off location AND
          validation will exist that requires either the drop off, the pick up, or both to be at an airport location for any one way rental" do          
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.element_present?(page, 'dropoff city textbox', 'id').should be false
          page.different_dropoff_location.click()
          page.element_present?(page, 'dropoff city textbox', 'id').should be true
      end

        it  "Validation will exist that requires either the drop off, the pick up, or both to be at an airport location for any one way rental" do
          feature = Feature.find_by_name('search car errors')
          #Pick Up: Airport - Drop off: Airport - Allowed
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('2 airports')
          page.search_cars_button.click()
          page = CarResultsPage.new(driver, RSpec.configuration.env)
          page.should_not be_element_present(page, 'car errors', 'css')
          #page.element_present?(page, 'car errors', 'css').should == false
          #Pick Up Airport - Drop off: City - Allowed
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('1 airport pickup')
          page.search_cars_button.click()
          page = CarResultsPage.new(driver, RSpec.configuration.env)
          page.should_not be_element_present(page, 'car errors', 'css')
          #Pick Up City- Drop off: Airport- Allowed
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('1 airport dropoff')
          page.search_cars_button.click()
          page = CarResultsPage.new(driver, RSpec.configuration.env)
          page.should_not be_element_present(page, 'car errors', 'css')
          #Pick Up: City - Drop off: City - Not Allowed
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('2 cities', false)
          page.search_cars_button.click()
          page.should be_element_present(page, 'car errors', 'css')
          page.car_errors.text().should == feature.verifications.find_by_name('airport needed error').text
          #Pick Up: City - Drop off: Address- Not Allowed
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('city and address', false)
          page.search_cars_button.click()
          page.should be_element_present(page, 'car errors', 'css')
          page.car_errors.text().should == feature.verifications.find_by_name('airport needed error').text
        end

        it 'Check error handling for invalid location' do
          feature = Feature.find_by_name('search car errors')
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('1 airport, 1 invalid location', false)
          page.search_cars_button.click()
          page.car_errors.text().should == feature.verifications.find_by_name('invalid location error').text
        end
      
       it 'If drop off is different, then the entry fields for drop off will allow the same location type options
           AND check for Search page subtitle: Where Will You Pick Up The Car?
           AND check for Radio button labels for rental type
           AND check for options default values' do
         feature = Feature.find_by_name('search cars elements')
         page = CarSearchPage.new(driver, RSpec.configuration.env)
         page.visit()
         # Check Default Values. Pick-Up field: Airport
         page.pickup_search_city_airport_input.selected?.should be true
         # Check Default Values. Drop-Off field: Same as Pick-Up
         page.dropoff_same_as_pickup_input.selected?.should be true
         # Check if allow the same location type options
         page.different_dropoff_location.click()
         page.pickup_input_options.text.should == page.dropoff_input_options.text
         # Check Subtitle
         page.pickup_subtitle.text.should == feature.verifications.find_by_name('search subtitle').text
         # Check label Drop-off location same as pick-up
         page.dropoff_same_as_pickup_label.text.should == feature.verifications.find_by_name('dropoff = pickup label').text
         # Check label Different drop-off location
         page.rental_type.text.include?(feature.verifications.find_by_name('dropoff != pickup label').text).should be true
         # ASK for this:
         # Pick-Up label: Pick-Up
         # Drop-Off label: Drop-Off         
       end
    end  
  end
end
