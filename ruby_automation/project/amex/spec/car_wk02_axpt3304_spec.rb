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
    describe "Car: AXPT-3304 - Provide ability to select a car itinerary" do
      driver = nil
      car_itinerary_feature = Feature.find_by_name('car itinerary feature')
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
                     
      it 'Car rate cards display a Select button' do
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_car('same location basic w/o discount')
        page.search_cars_button.click()    
        page = CarResultsPage.new(driver, RSpec.configuration.env) 
        # Select the first car
        page.select_first_car.click()
        page = CarSelectedPage.new(driver, RSpec.configuration.env)          
        # Validate the review booking text          
        page.text_visible?(car_selected_messages_feature.verifications.find_by_name('car selected title text').text).should == true             
      end    
	  end
	end	
end