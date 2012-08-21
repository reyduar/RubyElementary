require 'rubygems'
require 'selenium-webdriver'
require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require 'spec_helper'
require_relative '../pages/hotel_search_page'
require_relative '../pages/hotel_results_page'
require_relative '../pages/hotel_disambiguation_page'
require_relative '../db/models/database_model'

describe AMEX_Hotel do
  describe Week_50 do
    describe "Hotel: AXPT-2959 - Provide ability to modify destination in Hotel Search Summary Bar" do    
      driver = nil
      page = nil 
      initial_results_url = nil
      feature = Feature.find_by_name('sort function on hotel search results') 
      
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
      it "If the searched for destination was a city or landmark, the location field appears in edit mode in the search summary bar.
          The entry box can be edited to input a new city or landmark." do
        page = HotelSearchPage.new(driver, RSpec.configuration.env)
        initial_results_url = driver.current_url
        page.visit()
        page.book_a_hotel('hotel search summary')
        page = HotelResultsPage.new(driver, RSpec.configuration.env)   
        page.destination_textbox.should be_present()
        driver.execute_script("arguments[0].value = ''" , page.destination_textbox)    
        destination_text_value = driver.execute_script("return arguments[0].value" , page.destination_textbox)
        destination_text_value.should eq("")
        page.destination_textbox.send_keys(feature.verifications.find_by_name('edit hotel destination text').text)
        page.destination_textbox.send_keys(:arrow_down) 
        page.destination_textbox.send_keys(:tab) 
        destination_text_value = driver.execute_script("return arguments[0].value" , page.destination_textbox)
        destination_text_value.should eq(feature.verifications.find_by_name('edit hotel destination text').text)
      end 
      
      it "Clicking the Update button kicks off a new hotel search using the newly input city or landmark location." do
        page.update_button.click   
        page = nil
        page = HotelResultsPage.new(driver, RSpec.configuration.env)             
        sleep 2
        driver.current_url.should_not eq(initial_results_url)
      end
      
      it "If the new location is ambiguous a page will display requiring the user to select the desired location before the search can be done." do
        driver.execute_script("arguments[0].value = ''" , page.destination_textbox)    
        page.destination_textbox.send_keys(feature.verifications.find_by_name('edit hotel destination ambiguous text').text)
        page.update_button.click  
        page = HotelDisambiguationPage.new(driver, RSpec.configuration.env)           
        page.disambiguation_page_title.text().should eq(feature.verifications.find_by_name('disambiguation page title').text)
      end
    end  
  end
end
