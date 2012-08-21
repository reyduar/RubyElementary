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
    describe "Car: AXPT-3071 - Provide ability to see Car Rental rules and Policies" do       
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

      it "There is a link to Car Rental Policies below the Car matrix in the Car search result page" do       
        feature = Feature.find_by_name('search cars results')
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        # Make a valid search
        page.book_a_car('same location basic w/o discount')
        page.search_cars_button.click()
        page = CarResultsPage.new(driver, RSpec.configuration.env)
        # Check for link
        # There is a link to Car Rental Policies below the Car matrix in the Car search result page
        page.rental_policies_link
        # Check for this text:
        page.text_visible?(feature.verifications.find_by_name('car rental policy text').text).should == true
        page.text_visible?(feature.verifications.find_by_name('quick compare text').text).should == true
        page.rental_policies_link.text.should == feature.verifications.find_by_name('car rental policy link text').text
        # Test overlay dialog
        page.rental_policies_link.click
        page.rental_policies_dialog
        # There is a "Close" button that, when clicked, it closes the overlay.
        page.element_present?(page,'car results rental policies dialog','css').should == true
        page.rental_policies_dialog_close_btn.click
        sleep 3
        page.element_present?(page,'car results rental policies dialog','css').should == false
        # There is a cross button at the top of the window that, when clicked, it closes the overlay.
        page.rental_policies_link.click
        page.element_present?(page,'car results rental policies dialog','css').should == true
        page.rental_policies_dialog_close_cross.click
        sleep 3
        page.element_present?(page,'car results rental policies dialog','css').should == false
      end   
    end
  end
end
