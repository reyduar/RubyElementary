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
  describe Week_02 do
    describe "Car: AXPT-3425 - Provide ability to choose my pick up and drop off locations by address" do
      page = nil 
      driver = nil
      car_selected_messages_feature = Feature.find_by_name('car selected messages')      
         		  
		  before(:all) do
			  browser = RSpec.configuration.browser
			  case browser
			  when "firefox"
          driver = Selenium::WebDriver.for :firefox
			  else
          puts "Error: Case statment needs a valid browser string!"
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
                     
      it "If drop off is different, then the entry fields for drop off will allow the same location type options.
          Validation will exist to ensure that either the pick up, drop off, or both are an airport for any drop off different than pick up rental." do
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.different_dropoff_location_label.click()
        sleep 1
        page.pickup_search_city_airport_input.selected?.should be true
        page.dropoff_search_city_airport_input.selected?.should be true
        page.pickup_search_by_address_input.selected?.should_not be true
        page.dropoff_search_by_address_input.selected?.should_not be true           
        page.pickup_search_by_address_option_label.click()
        sleep 1
        page.pickup_country_combobox.should be_displayed()
        page.pickup_address.should be_displayed()
        page.pickup_city_address.should be_displayed()
        page.pickup_state_combobox.should be_displayed()
        page.pickup_zip.should be_displayed()                   
        page.should_not be_element_present(page, "dropoff country combobox", "css")
        page.should_not be_element_present(page, "dropoff address", "id")
        page.should_not be_element_present(page, "dropoff city address", "id")
        page.should_not be_element_present(page, "dropoff state combobox", "css")
        page.should_not be_element_present(page, "dropoff zip", "id")            
        page.pickup_search_city_airport_option_label.click()
        sleep 1
        page.dropoff_search_by_address_option_label.click()
        sleep 1        
        page.should_not be_element_present(page, "pickup country combobox", "css")
        page.should_not be_element_present(page, "pickup address", "id")
        page.should_not be_element_present(page, "pickup city address", "id")
        page.should_not be_element_present(page, "pickup state combobox", "css")
        page.should_not be_element_present(page, "pickup zip", "id")                         
        page.dropoff_country_combobox.should be_displayed()
        page.dropoff_address.should be_displayed()
        page.dropoff_city_address.should be_displayed()
        page.dropoff_state_combobox.should be_displayed()
        page.dropoff_zip.should be_displayed()               
      end 

      it "User is able to enter an address for the pick up location to search for car options." do
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()      
        page.book_a_car('address to city or airport')
        page.search_cars_button.click()
        page = CarResultsPage.new(driver, RSpec.configuration.env)        
        page.select_first_car.click()
      end

      it "User is able to enter an address for the drop off location to search for car options." do
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()      
        page.book_a_car('city or airport to address')
        page.search_cars_button.click()
        page = CarResultsPage.new(driver, RSpec.configuration.env) 
        if !(page.text_present?("No cars found for search request"))   
          page.select_first_car.click() 
        end                      
      end
	  end
	end	
end