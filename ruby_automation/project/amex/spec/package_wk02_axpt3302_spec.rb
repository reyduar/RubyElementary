require 'rubygems'
require 'selenium-webdriver'
require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require 'spec_helper'
require_relative '../pages/package_search_page'
require_relative '../pages/package_results_page'
require_relative '../pages/package_disambiguation_page'
require_relative '../db/models/database_model'

describe AMEX_Package do
  describe Week_02 do
    driver = nil
    page = nil   
    initial_results_url = nil    
    feature = Feature.find_by_name('dp search summary bar') 
    
    verifications = nil
    initial_results_url = nil
    
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
      driver.manage.delete_all_cookies()
      if example.failed?
        driver.save_screenshot("logs/screenshot_#{Time.now.strftime('%Y%m%d-%H%M%S')}.png")
      end
    end        
    
    after(:all) do
      driver.quit()
    end      
  
    describe "Package: AXPT-3302 - DP Search Summary: Customer should be able to see my origin and destination in edit mode" do 
         it "On the DP search summary bar, the origin and destination of my search (city name and airport code) is shown in edit mode.
             Each entry box can be edited to input a new single airport code or city name." do
          page = PackageSearchPage.new(driver, RSpec.configuration.env)
          initial_results_url = driver.current_url
          page.visit()
          page.book_a_package("dp search summary")
          page = PackageResultsPage.new(driver, RSpec.configuration.env)   
          page.departure_city_textbox.should be_present()
          page.arrival_city_textbox.should be_present()        
          page.arrival_city_clean_text_input.click
          page.departure_city_clean_text_input.click
          departure_city_text_value = driver.execute_script("return arguments[0].value" , page.departure_city_textbox)
          arrival_city_text_value = driver.execute_script("return arguments[0].value" , page.arrival_city_textbox)
          departure_city_text_value.should eq("")
          arrival_city_text_value.should eq("")
          page.departure_city_textbox.send_keys(feature.verifications.find_by_name('departure city text').text)
          page.departure_city_textbox.send_keys(:arrow_down) 
          page.departure_city_textbox.send_keys(:tab) 
          page.arrival_city_textbox.send_keys(feature.verifications.find_by_name('arrival city text').text)
          page.arrival_city_textbox.send_keys(:arrow_down) 
          page.arrival_city_textbox.send_keys(:tab)
          departure_city_text_value = driver.execute_script("return arguments[0].value" , page.departure_city_textbox)
          departure_city_text_value.should eq(feature.verifications.find_by_name('departure city text').text)
          arrival_city_text_value = driver.execute_script("return arguments[0].value" , page.arrival_city_textbox)
          arrival_city_text_value.should eq(feature.verifications.find_by_name('arrival city text').text)
        end
        
        it "Clicking the 'Update' button kicks off a new DP search using the newly input outbound and/or return." do
          page.update_button.click   
          page = nil
          page = PackageResultsPage.new(driver, RSpec.configuration.env)             
          sleep 2
          driver.current_url.should_not eq(initial_results_url)
        end
        
        it "The customer sees the interstitial page before seeing the new results." do         
          # Turn on interstitial
          driver.execute_script("document.getElementsByClassName('_jq-loading-content')[0].style.display='block'")
          sleep 2
          # Check for text in the interstitial
          page.text_visible?(feature.verifications.find_by_name('interstitial main text').text)==true
        end
        
        it "Any field validation issues leave the customer on the search summary bar with instructions to re-try.
            If the search produces no results the customer stays on the search results page and sees an error." do 
          page.departure_city_clean_text_input.click
          page.arrival_city_textbox.send_keys(feature.verifications.find_by_name('wrong cities text').text)
          page.update_button.click
          page = nil
          page = PackageResultsPage.new(driver, RSpec.configuration.env)            
          page.result_error_messages.should be_present()
          page.result_error_messages.text().should eq(feature.verifications.find_by_name('invalid location error').text)                     
        end
        
        it "Entering an ambiguous location for either origin or destination will take the customer to the disambiguation page for location selection." do
          page.arrival_city_clean_text_input.click
          page.departure_city_clean_text_input.click
          page.departure_city_textbox.send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)
          page.arrival_city_textbox.send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)
          page.update_button.click
          page = nil
          page = PackageDisambiguationPage.new(driver, RSpec.configuration.env)
          page.disambiguation_page_title.text().should eq(feature.verifications.find_by_name('disambiguation page title text').text)    
          page.disambiguation_first_selection_in_all_options.each { |first_option|
            first_option.click()
         }
          page.update_package_search_button.click
          page = nil
          page = PackageResultsPage.new(driver, RSpec.configuration.env)  
          page.first_dp_hotel_card.should be_present()
        end

        it "All error messages are displayed in the search results page, below the summary bar.
            No search results are presented upon a failed validation, only the messages." do
          page.arrival_city_clean_text_input.click
          page.departure_city_clean_text_input.click
          page.update_button.click
          page = nil
          page = PackageResultsPage.new(driver, RSpec.configuration.env)            
          page.results_error_messages.should be_present()
          page.results_error_messages[0].text().should eq(feature.verifications.find_by_name('enter an departure location error').text) 
          page.results_error_messages[1].text().should eq(feature.verifications.find_by_name('enter an arrival location error').text) 
          page.results_error_messages[2].text().should eq(feature.verifications.find_by_name('invalid location error').text) 
          page.wait_for_element_not_present(page, "first dp hotel card", "css")  
        end
     end
  end
end