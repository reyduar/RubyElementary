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
require_relative '../pages/car_search_page'
require_relative '../db/models/database_model'

describe AMEX_Package do
  describe Week_50 do
      driver = nil
      page = nil 
      package = Package.find_by_name('one adult at least in each room')
      feature = Feature.find_by_name('dp search form - advanced search options')
      verifications = nil
      
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
  
    describe "Package: AXPT-2607 - Provide ability to select departure and destination locations in DP search form" do
      describe "a. Users should be able to specify their departure and arrival." do          
        it "There is no cookie sharing from AMEX home page to advanced search page." do
          home_page = HomePage.new(driver, RSpec.configuration.env)
          home_page.visit()
          home_page.enter_airport(home_page.departure_city_textbox,package.departure_city)
          home_page.enter_airport(home_page.arrival_city_textbox,package.arrival_city)                    
          home_page.departure_date_textbox.send_keys(eval(package.departure_date)) 
          home_page.return_date_textbox.send_keys(eval(package.return_date)) 
          home_page.home_flight_and_hotel_search_button.click()          
          package_search_page = PackageSearchPage.new(driver, RSpec.configuration.env)          
          package_search_page.visit()
          departure_city_text_value = driver.execute_script("return arguments[0].value" , package_search_page.departure_city_textbox)
          arrival_city_text_value = driver.execute_script("return arguments[0].value" , package_search_page.arrival_city_textbox)
          departure_city_text_value.should be_empty()
          arrival_city_text_value.should be_empty() 
          driver.manage.delete_all_cookies()        
        end             
      
        it "The last itinerary searched for from the advanced search page is defaulted in the departure/arrival fields. 
            If no last search exists, then the fields are blank." do      
          package_search_page = PackageSearchPage.new(driver, RSpec.configuration.env)
          package_search_page.visit()
          package_search_page.book_a_package("one adult at least in each room")
          car_search_page = CarSearchPage.new(driver, RSpec.configuration.env)
          car_search_page.visit()
          package_search_page.visit()
          departure_city_text_value = driver.execute_script("return arguments[0].value" , package_search_page.departure_city_textbox)
          arrival_city_text_value = driver.execute_script("return arguments[0].value" , package_search_page.arrival_city_textbox)
          departure_city_text_value.should eq("Miami International Airport, FL, US (MIA)")
          arrival_city_text_value.should eq("Chicago Midway Airport, IL, US (MDW)")       
          driver.manage.delete_all_cookies() 
        end 

        it "There is validation that both a departure and an arrival are selected." do
        # No Departure city
          page = PackageSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_package("no departure city")
          page.should be_text_present(feature.verifications.find_by_name('no departure city error message text').text)           
          
        # No Arrival city
          page = PackageSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_package("no arrival city")        
          page.should be_text_present(feature.verifications.find_by_name('no arrival city error message text').text)               
          driver.manage.delete_all_cookies() 
        end
                
        it "Input can be an airport code OR a city name. Departure as an airport and arrival as a city or vice versa can be specified.
            NOTE: Disambiguation is NOT in scope for this story." do
        # departure city and arrival code
          page = PackageSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_package("departure city and arrival code")
          page.should_not be_text_present(feature.verifications.find_by_name('no departure city error message text').text)           
          page.should_not be_text_present(feature.verifications.find_by_name('no arrival city error message text').text) 
          driver.manage.delete_all_cookies() 
          
        # departure code and arrival city
          page = PackageSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_package("departure code and arrival city")        
          page.should_not be_text_present(feature.verifications.find_by_name('no departure city error message text').text)           
          page.should_not be_text_present(feature.verifications.find_by_name('no arrival city error message text').text)              
          driver.manage.delete_all_cookies() 
        end 

        it "Search page subtitle: Where Are You Going?" do
          page = PackageSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.where_are_you_going_subtitle_text_element.text.should eq(feature.verifications.find_by_name('where are you going subtitle text').text)                                   
        end    

        it "Error handling: [Your departure location cannot be the same as your arrival location]" do        
          page = PackageSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_package("same departure and arrival city")        
          page.should be_text_present(feature.verifications.find_by_name('same departure and arrival city error message text').text)                                                 
          driver.manage.delete_all_cookies() 
        end           
      end     

      describe "b. Users should be able to have autocomplete to assist them with entering locations." do        
        it "As typing begins in any location entry box, the autocomplete kicks in.
            The auto complete options offered for DP include airports and cities ONLY." do
          page = PackageSearchPage.new(driver, RSpec.configuration.env)          
          page.visit()       
          page.book_a_package("autocomplete cities")
          page = PackageResultsPage.new(driver, RSpec.configuration.env)
          page.package_results_page_head_title.text.should eq(feature.verifications.find_by_name('on package results page verification text').text)              
          driver.manage.delete_all_cookies() 
        end
            
        it "If there are no matches to display and no similar matches to display, then auto complete does not offer any options." do
          page = PackageSearchPage.new(driver, RSpec.configuration.env)          
          page.visit()       
          page.book_a_package("wrong cities")
          page.should_not be_text_present(feature.verifications.find_by_name('on package results page verification text').text)          
        end      
      end      
    end
  end
end