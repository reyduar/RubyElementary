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
    describe "Car: AXPT-3431 - Provide ability to see a breakdown of taxes and fees in the Car Review Page" do       
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
    
      it 'User is able to see the total of the taxes and fees within the Review Car section in the review page
          and user is click in an expandable link that will show all fees and taxes broken down
          and an option to to collapse the taxes and fees section when done is displayed' do
          feature = Feature.find_by_name('car taxes')
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('same location basic w/o discount')
          page.search_cars_button.click()
          page = CarResultsPage.new(driver, RSpec.configuration.env)
          # Select a car
          page.select_first_car.click()
          page = CarSelectedPage.new(driver, RSpec.configuration.env)
          # See the total taxes
          page.should be_text_present(feature.verifications.find_by_name('tax and fee text').text)
          # click on tax and fee text
          page.tax_fee_link.click()
          # Check for detailed tax break down
          page.tax_fee_dialog
          # Check for close button and try it
          page.tax_fee_dialog_close_icon.click()
      end
    end
  end
end
