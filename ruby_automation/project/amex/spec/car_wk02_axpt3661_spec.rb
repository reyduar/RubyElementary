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
    describe "Car: AXPT-3661 - Provide ability to see an option to get help in the Car review page" do
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
                     
      it "The user is able to see a label with the customer service phone number in the progress bar:
          'Need Help? 1-800-297-2977'" do
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_car('same location basic w/o discount')
        page.search_cars_button.click()    
        page = CarResultsPage.new(driver, RSpec.configuration.env) 
        page.select_first_car.click()
        page = CarSelectedPage.new(driver, RSpec.configuration.env)                  
        page.progress_bar_help_text_label.text.strip.should eq("Call us: 1-800-297-2977 Need Help?")             
      end      
      
      it "The user is able to see a Help With This Page link below the progress bar. Link name: 'Help With This Page'" do         
        page.help_with_this_page_link.text.strip.should eq("Help with this page")             
      end         
	  end
	end	
end