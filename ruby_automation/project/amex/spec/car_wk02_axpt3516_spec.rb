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
  describe Week_02 do
    describe "Car: AXPT-3516 - On Car Search form, provide users with access to a list of Airports Worldwide" do    
      driver = nil
      page = nil 
      feature = Feature.find_by_name('list of airports worldwide') 
      
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
      
      it "On the Car search page there is a link to Airports below the entry boxes for airport/city." do
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.different_dropoff_location_label.click();
        page.airports_worldwide_pickup_link.should be_displayed()
        page.airports_worldwide_dropoff_link.should be_displayed()       
      end
      
      it "When clicked, an overlay appears that lists cities in alphabetical order along with their airport code.
         There is a Cancel button (X) to exit the airport list without making an airport selection. 
         No airport codes are then transferred nor populate the search form." do        
        page.should_not be_element_present(page, "airports worldwide overlay title", "id")
        page.airports_worldwide_departure_link.click()
        page.airports_worldwide_overlay_title.should be_present()
        page.airports_worldwide_overlay_icon_close_button.click()
        departure_city_text_value = driver.execute_script("return arguments[0].value" , page.pickup_city_textbox)
        departure_city_text_value.should be_empty()
      end
          
      it "The airport code is itself a link that returns the customer to the search form with the airport code clicked 
          populated in the origin or destination box. If the Airport link is clicked below the Origin box then the 
          Origin box is populated with the airport." do
        # verifications departure city textbox
        page.airports_worldwide_departure_link.click()
        page.airports_worldwide_overlay_us_airports_tab.click()
        page.airports_worldwide_overlay_us_airports_abecedary_letter_link.click()     
        page.airports_worldwide_overlay_us_airports_code_link.click()
        departure_city_text_value = driver.execute_script("return arguments[0].value" , page.pickup_city_textbox)
        departure_city_text_value.should eq(feature.verifications.find_by_name('us airport selected full name').text)
        page.airports_worldwide_departure_link.click()
        page.airports_worldwide_overlay_canadian_airports_tab.click()
        page.airports_worldwide_overlay_canadian_airports_code_link.click()
        departure_city_text_value = driver.execute_script("return arguments[0].value" , page.pickup_city_textbox)
        departure_city_text_value.should eq(feature.verifications.find_by_name('canadian airport selected full name').text)
        page.airports_worldwide_departure_link.click()
        page.airports_worldwide_overlay_intl_airports_tab.click()
        page.airports_worldwide_overlay_intl_airports_abecedary_letter_link.click()
        page.airports_worldwide_overlay_intl_airports_code_link.click()
        departure_city_text_value = driver.execute_script("return arguments[0].value" , page.pickup_city_textbox)
        departure_city_text_value.should eq(feature.verifications.find_by_name('intl airport selected full name').text)
      end
            
      it "If the Airport list was accessed by clicking the Airport link below Destination, 
          then clicking the airport code from the list populates the destination box." do
        # verifications arrival city textbox
        page.airports_worldwide_arrival_link.click()
        page.airports_worldwide_overlay_us_airports_tab.click()
        page.airports_worldwide_overlay_us_airports_abecedary_letter_link.click()
        page.airports_worldwide_overlay_us_airports_code_link.click()
        arrival_city_text_value = driver.execute_script("return arguments[0].value" , page.dropoff_city_textbox)
        arrival_city_text_value.should eq(feature.verifications.find_by_name('us airport selected full name').text)
        page.airports_worldwide_arrival_link.click()
        page.airports_worldwide_overlay_canadian_airports_tab.click()
        page.airports_worldwide_overlay_canadian_airports_code_link.click()
        arrival_city_text_value = driver.execute_script("return arguments[0].value" , page.dropoff_city_textbox)
        arrival_city_text_value.should eq(feature.verifications.find_by_name('canadian airport selected full name').text)
        page.airports_worldwide_arrival_link.click()
        page.airports_worldwide_overlay_intl_airports_tab.click()
        page.airports_worldwide_overlay_intl_airports_abecedary_letter_link.click()
        page.airports_worldwide_overlay_intl_airports_code_link.click()
        arrival_city_text_value = driver.execute_script("return arguments[0].value" , page.dropoff_city_textbox)
        arrival_city_text_value.should eq(feature.verifications.find_by_name('intl airport selected full name').text)
      end   
     
      it "Airport list is segregated into US airports, Canadian airports and International airports." do
        page.airports_worldwide_departure_link.click()
        page.airports_worldwide_overlay_us_airports_tab.should be_present()
        page.airports_worldwide_overlay_canadian_airports_tab.should be_present()
        page.airports_worldwide_overlay_intl_airports_tab.should be_present()
        page.airports_worldwide_overlay_icon_close_button.click()
      end
        
      it "There is a Back To Top link on each tab that allows the customer to return immediately to the top of the tab if he had scrolled down." do
        page.airports_worldwide_departure_link.click()
        page.airports_worldwide_overlay_us_airports_abecedary_letter_link.click()
        page.airports_worldwide_overlay_us_airports_back_to_top_link.click()
        page.airports_worldwide_overlay_us_scrollpane.attribute("style").should eq('height: 80px; top: 0px;')
        page.airports_worldwide_overlay_intl_airports_tab.click()
        page.airports_worldwide_overlay_intl_airports_abecedary_letter_link.click()
        page.airports_worldwide_overlay_intl_airports_back_to_top_link.click()
        page.airports_worldwide_overlay_intl_scrollpane.attribute("style").should eq('height: 80px; top: 0px;')             
      end
    end  
  end
end