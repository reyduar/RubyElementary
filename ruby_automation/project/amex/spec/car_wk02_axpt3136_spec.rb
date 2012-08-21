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
    describe "Car: AXPT-3136 - Provide ability to select a car from the matrix" do
      driver = nil
      feature = Feature.find_by_name('search cars results') 
         		  
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
      # Scenario 1:
      # Multiple Cars: There are multiple cars for the same class at that price (Example: Economy) 
      it "The result list only display car options that match the criteria." do       
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_car('same location basic w/o discount')
        page.search_cars_button.click() 
        page = CarResultsPage.new(driver, RSpec.configuration.env)
        # Click Economy link
        page.car_matrix_column_car_types_links[0].click
        # Check economy car type text
        page.car_results_car_type_titles.each { |title_name|
        if !(title_name.text().empty?)
            title_name.text().should eq(feature.verifications.find_by_name('economy car type text').text)  
        end } 
        # Click first cell banner rental company 
        page.car_matrix_head_car_rental_company_links[0].click
        banner_img = page.car_matrix_first_banner_cell_img.attribute("src").split("/").last  
        # Check image car rental company
        page.car_results_first_banner_rental_company_img.attribute("src").split("/").last.should eq(banner_img)
      end       
      
     # Scenario 2:
     # Basic Flow: Car Selection
      it "Availability and Pricing is checked for the car option required.
            User is able to get to the car checkout page." do
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_car('same location basic w/o discount')
        page.search_cars_button.click() 
        page = CarResultsPage.new(driver, RSpec.configuration.env)
        price_cell = page.car_matrix_first_cells_prices[0].text().split("$").last 
        page.car_matrix_first_cells_prices[0].click
        page = CarSelectedPage.new(driver, RSpec.configuration.env)
        # Validate the review booking text      
        /\d{3}/.match(price_cell).to_s.should == /\d{3}/.match(page.estimated_cost_number.text()).to_s
        page.review_your_car_label.text().should eq(feature.verifications.find_by_name('review your car text').text)         
      end 
	  end
	end	
end