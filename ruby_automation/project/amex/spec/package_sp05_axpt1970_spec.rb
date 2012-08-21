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
require_relative '../pages/home_page'
require_relative '../db/models/database_model'

describe AMEX_Package do
  describe Sprint_05 do  
    describe "Package: AXPT-1970 - DP Search | As a customer I want the ability to specify my departure and arrival" do    
      driver = nil
      page = nil 
      package = Package.find_by_name('one adult at least in each room')
      feature = Feature.find_by_name('edit itinerary on dp search feature') 
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
      
      # it "There will be no cookie sharing from AMEX home page to advanced search page." do
        # page = HomePage.new(driver, RSpec.configuration.env)
        # page.visit()
        # page.enter_airport(page.departure_city_textbox,package.departure_city)
        # sleep 2
        # page.enter_airport(page.arrival_city_textbox,package.arrival_city)                    
        # page.departure_date_textbox.send_keys(eval(package.departure_date)) 
        # page.return_date_textbox.send_keys(eval(package.return_date)) 
        # page.home_flight_and_hotel_search_button.click()          
        # page = PackageSearchPage.new(driver, RSpec.configuration.env)          
        # page.visit()
        # departure_city_text_value = driver.execute_script("return arguments[0].value" , page.departure_city_textbox)
        # arrival_city_text_value = driver.execute_script("return arguments[0].value" , page.arrival_city_textbox)
        # departure_city_text_value.should be_empty()
        # arrival_city_text_value.should be_empty() 
        # driver.manage.delete_all_cookies()        
      # end         
      
      it "Input can be an airport code or a city name. Must specify both a departure and an arrival"do
        page = PackageSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        # Check with airport code
        page.departure_city_textbox.send_keys(feature.verifications.find_by_name('departure airport code text').text)
        page.arrival_city_textbox.send_keys(feature.verifications.find_by_name('arrival airport code text').text)
        page.departure_date_textbox.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
        page.return_date_textbox.send_keys(eval('(Time.now + (20 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
        page.search_button.click()
        page = PackageResultsPage.new(driver, RSpec.configuration.env) 
        page.first_dp_hotel_card.should be_present()
        departure_airport_code_value = driver.execute_script("return arguments[0].value" , page.departure_city_textbox())
        arrival_airport_code_value = driver.execute_script("return arguments[0].value" , page.arrival_city_textbox())
        departure_airport_code_value.should eq(feature.verifications.find_by_name('departure airport code text').text) 
        arrival_airport_code_value.should eq(feature.verifications.find_by_name('arrival airport code text').text) 
        page.start_a_new_search_link.click()
        # Check with city name
        page = PackageSearchPage.new(driver, RSpec.configuration.env)        
        driver.execute_script("arguments[0].value = ''" , page.departure_city_textbox)
        driver.execute_script("arguments[0].value = ''" , page.arrival_city_textbox)        
        page.departure_city_textbox.send_keys(feature.verifications.find_by_name('departure city name text').text)
        sleep 1
        page.arrival_city_textbox.send_keys(feature.verifications.find_by_name('arrival city name text').text)
        sleep 1
        page.departure_date_textbox.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
        page.return_date_textbox.send_keys(eval('(Time.now + (20 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
        page.search_button.click()
        page = PackageResultsPage.new(driver, RSpec.configuration.env) 
        page.first_dp_hotel_card.should be_present()
        departure_city_name_value = driver.execute_script("return arguments[0].value" , page.departure_city_textbox())
        arrival_city_name_value = driver.execute_script("return arguments[0].value" , page.arrival_city_textbox())
        departure_city_name_value.should eq(feature.verifications.find_by_name('departure city name text').text) 
        arrival_city_name_value.should eq(feature.verifications.find_by_name('arrival city name text').text) 
      end
      
      it "The last itinerary I searched for from the advanced search page will be defaulted in the departure/arrival fields." do
        page.start_a_new_search_link.click()
        page = PackageSearchPage.new(driver, RSpec.configuration.env)
        departure_city_text_value = driver.execute_script("return arguments[0].value" , page.departure_city_textbox())
        arrival_city_text_value = driver.execute_script("return arguments[0].value" , page.arrival_city_textbox())
        departure_city_text_value.should eq("Boston Logan International Airport")
        arrival_city_text_value.should eq("Dayton International Airport")
        driver.manage.delete_all_cookies()            
      end 
      
      it "Can specify departure as an airport and arrival as a city or vice versa" do
        # Check with airport name and city name  
        driver.execute_script("arguments[0].value = ''" , page.departure_city_textbox)
        driver.execute_script("arguments[0].value = ''" , page.arrival_city_textbox)          
        page.departure_city_textbox.send_keys(feature.verifications.find_by_name('departure airport name text').text)
        sleep 1
        page.arrival_city_textbox.send_keys(feature.verifications.find_by_name('arrival airport code text').text)
        sleep 1        
        page.departure_date_textbox.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
        page.return_date_textbox.send_keys(eval('(Time.now + (20 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
        page.search_button.click()
        page = PackageResultsPage.new(driver, RSpec.configuration.env) 
        page.first_dp_hotel_card.should be_present()
        departure_airport_name_value = driver.execute_script("return arguments[0].value" , page.departure_city_textbox())
        sleep 1        
        arrival_city_name_value = driver.execute_script("return arguments[0].value" , page.arrival_city_textbox())
        sleep 1        
        departure_airport_name_value.should eq('Miami International Airport') 
        arrival_city_name_value.should eq('MDW') 
        driver.manage.delete_all_cookies()           
        page.start_a_new_search_link.click()        
        # Check with city name and airport name
        page = PackageSearchPage.new(driver, RSpec.configuration.env)
        driver.execute_script("arguments[0].value = ''" , page.departure_city_textbox)
        driver.execute_script("arguments[0].value = ''" , page.arrival_city_textbox)          
        page.departure_city_textbox.send_keys(feature.verifications.find_by_name('departure airport code text').text)
        sleep 1        
        page.arrival_city_textbox.send_keys(feature.verifications.find_by_name('arrival airport name text').text)                
        sleep 1        
        page.departure_date_textbox.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
        page.return_date_textbox.send_keys(eval('(Time.now + (20 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
        page.search_button.click()
        page = PackageResultsPage.new(driver, RSpec.configuration.env) 
        page.first_dp_hotel_card.should be_present()
        departure_city_name_value = driver.execute_script("return arguments[0].value" , page.departure_city_textbox())
        arrival_airport_name_value = driver.execute_script("return arguments[0].value" , page.arrival_city_textbox())
        departure_city_name_value.should eq('MIA') 
        arrival_airport_name_value.should eq('Chicago Midway Airport')  
      end 
    end  
  end
end