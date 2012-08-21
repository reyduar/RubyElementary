require 'rubygems'
require 'selenium-webdriver'
require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require 'spec_helper'
require_relative '../pages/flight_search_page'
require_relative '../pages/flight_results_page'
require_relative '../pages/flight_disambiguation_page'
require_relative '../db/models/database_model'

describe AMEX_Air do
  describe Week_50 do
    describe "Flight: AXPT-2425 - Display disambiguation page if multiple options exists for locations specified in air search form" do    
      driver = nil
      page = nil 
      feature = Feature.find_by_name('edit itinerary on summary bar feature')      
      
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
      
      it "When the search button is clicked if one or more of the departure/arrival locations is ambiguous a page will display 
         asking for the customer to make a selection." do
         # Round Trip search
         page = FlightSearchPage.new(driver, RSpec.configuration.env)
         page.visit()
         page.round_trip_option.click() 
         page.departure_city_textbox(1).send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)
         page.arrival_city_textbox(1).send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)      
         page.departure_date_textbox(1).send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
         page.return_date_textbox.send_keys(eval('(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))  
         page.search_flights_button.click()     
         page = FlightDisambiguationPage.new(driver, RSpec.configuration.env)
         page.should be_text_present(feature.verifications.find_by_name('disambiguation page title').text)
         departure_matches=0
         arrival_matches=0
         page.disambiguation_destinations_list_titles.each { |destinations_title|
          if !(destinations_title.text().empty?)
              if(destinations_title.text.include?("departure"))
                departure_matches += 1
              end
              if(destinations_title.text.include?("arrival"))
                arrival_matches += 1
              end
          end }
         departure_matches.should eq(1)
         arrival_matches.should eq(1)
         # One way search
         page = FlightSearchPage.new(driver, RSpec.configuration.env)
         page.visit()
         page.one_way_option.click() 
         page.departure_city_textbox(1).send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)
         page.arrival_city_textbox(1).send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)      
         page.departure_date_textbox(1).send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
         page.search_flights_button.click()     
         page = FlightDisambiguationPage.new(driver, RSpec.configuration.env)
         page.should be_text_present(feature.verifications.find_by_name('disambiguation page title').text)
         departure_matches=0
         arrival_matches=0
         page.disambiguation_destinations_list_titles.each { |destinations_title|
          if !(destinations_title.text().empty?)
              if(destinations_title.text.include?("departure"))
                departure_matches += 1
              end
              if(destinations_title.text.include?("arrival"))
                arrival_matches += 1
              end
          end }
         departure_matches.should eq(1)
         arrival_matches.should eq(1)
         # Multi city search
         page = FlightSearchPage.new(driver, RSpec.configuration.env)
         page.visit()
         page.multi_city_option.click() 
         page.departure_city_textbox(1).send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)
         page.arrival_city_textbox(1).send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)  
         page.departure_city_textbox(2).send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)
         page.arrival_city_textbox(2).send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)    
         page.departure_city_textbox(3).send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)
         page.arrival_city_textbox(3).send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)             
         page.departure_date_textbox(1).send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
         page.departure_date_textbox(2).send_keys(eval('(Time.now + (6 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
         page.departure_date_textbox(3).send_keys(eval('(Time.now + (8 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
         page.search_flights_button.click() 
         page = FlightDisambiguationPage.new(driver, RSpec.configuration.env)         
         page.should be_text_present(feature.verifications.find_by_name('disambiguation page title').text)
         departure_matches=0
         arrival_matches=0
         page.disambiguation_destinations_list_titles.each { |destinations_title|
          if !(destinations_title.text().empty?)
              if(destinations_title.text.include?("departure"))
                departure_matches += 1
              end
              if(destinations_title.text.include?("arrival"))
                arrival_matches += 1
              end
          end }
         departure_matches.should eq(3)
         arrival_matches.should eq(3)
      end    
      it "The page will list the disambiguation options for each unclear departure/arrival grouped together with a radio button.
          The user will be required to select a single radio button option for each disambiguation group before clicking the search button." do
         # Round Trip search
         page = FlightSearchPage.new(driver, RSpec.configuration.env)
         page.visit()
         page.round_trip_option.click() 
         page.departure_city_textbox(1).send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)
         page.arrival_city_textbox(1).send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)      
         page.departure_date_textbox(1).send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
         page.return_date_textbox.send_keys(eval('(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))  
         page.search_flights_button.click()  
         page = FlightDisambiguationPage.new(driver, RSpec.configuration.env)  
         page.disambiguation_first_selection_in_all_options.should be_present()         
         page.disambiguation_first_selection_in_all_options[0].click()
         page.update_flight_search_button.click() 
         page.disambiguation_message_error_label.should be_present()
         page.disambiguation_message_error_label.text().should eq(feature.verifications.find_by_name('disambiguation clarify your search error message').text)
         # One way search
         page = FlightSearchPage.new(driver, RSpec.configuration.env)
         page.visit()
         page.one_way_option.click()
         page.departure_city_textbox(1).send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)
         page.arrival_city_textbox(1).send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)      
         page.departure_date_textbox(1).send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
         page.search_flights_button.click()  
         page = FlightDisambiguationPage.new(driver, RSpec.configuration.env)   
         page.disambiguation_first_selection_in_all_options.should be_present()         
         page.disambiguation_first_selection_in_all_options[0].click()
         page.update_flight_search_button.click() 
         page.disambiguation_message_error_label.should be_present()
         page.disambiguation_message_error_label.text().should eq(feature.verifications.find_by_name('disambiguation clarify your search error message').text)
         # Multi city search
         page = FlightSearchPage.new(driver, RSpec.configuration.env)
         page.visit()
         page.multi_city_option.click() 
         page.departure_city_textbox(1).send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)
         page.arrival_city_textbox(1).send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)  
         page.departure_city_textbox(2).send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)
         page.arrival_city_textbox(2).send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)    
         page.departure_city_textbox(3).send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)
         page.arrival_city_textbox(3).send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)             
         page.departure_date_textbox(1).send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
         page.departure_date_textbox(2).send_keys(eval('(Time.now + (6 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
         page.departure_date_textbox(3).send_keys(eval('(Time.now + (8 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
         page.search_flights_button.click()  
         page = FlightDisambiguationPage.new(driver, RSpec.configuration.env) 
         page.disambiguation_first_selection_in_all_options.should be_present()         
         page.disambiguation_first_selection_in_all_options[0].click()
         page.update_flight_search_button.click() 
         page.disambiguation_message_error_label.should be_present()
         page.disambiguation_message_error_label.text().should eq(feature.verifications.find_by_name('disambiguation clarify your search error message').text)
      end 
      it "if a selection is missing in any of the groupings the page will remain with an error telling the user to select an option in each grouping" do
         # Round Trip search
         page = FlightSearchPage.new(driver, RSpec.configuration.env)
         page.visit()
         page.round_trip_option.click() 
         page.departure_city_textbox(1).send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)
         page.arrival_city_textbox(1).send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)      
         page.departure_date_textbox(1).send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
         page.return_date_textbox.send_keys(eval('(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))  
         page.search_flights_button.click()  
         page = FlightDisambiguationPage.new(driver, RSpec.configuration.env)          
         page.disambiguation_first_selection_in_all_options[0].click()
         page.disambiguation_first_selection_in_all_options[1].click()
         page.update_flight_search_button.click() 
         page = FlightResultsPage.new(driver, RSpec.configuration.env)  
         page.quick_compare_air_title.should be_present()
         page.quick_compare_air_title.text().should eq(feature.verifications.find_by_name('quick compare title').text)
         # One way search
         page = FlightSearchPage.new(driver, RSpec.configuration.env)
         page.visit()
         page.one_way_option.click() 
         page.departure_city_textbox(1).send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)
         page.arrival_city_textbox(1).send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)      
         page.departure_date_textbox(1).send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
         page.search_flights_button.click()  
         page = FlightDisambiguationPage.new(driver, RSpec.configuration.env)          
         page.disambiguation_first_selection_in_all_options.each { |first_option|
            first_option.click()
         }
         page.update_flight_search_button.click() 
         page = FlightResultsPage.new(driver, RSpec.configuration.env)  
         page.quick_compare_air_title.should be_present()
         page.quick_compare_air_title.text().should eq(feature.verifications.find_by_name('quick compare title').text)
         # Multi city search
         page = FlightSearchPage.new(driver, RSpec.configuration.env)
         page.visit()
         page.multi_city_option.click() 
         page.departure_city_textbox(1).send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)
         page.arrival_city_textbox(1).send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)  
         page.departure_city_textbox(2).send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)
         page.arrival_city_textbox(2).send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)    
         page.departure_city_textbox(3).send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)
         page.arrival_city_textbox(3).send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)             
         page.departure_date_textbox(1).send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
         page.departure_date_textbox(2).send_keys(eval('(Time.now + (6 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
         page.departure_date_textbox(3).send_keys(eval('(Time.now + (8 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
         page.search_flights_button.click()  
         page = FlightDisambiguationPage.new(driver, RSpec.configuration.env)          
         page.disambiguation_first_selection_in_all_options.each { |first_option|
            first_option.click()
         }
         page.update_flight_search_button.click() 
         page = FlightResultsPage.new(driver, RSpec.configuration.env)  
         page.quick_compare_air_title.should be_present()
         page.quick_compare_air_title.text().should eq(feature.verifications.find_by_name('quick compare title').text)
      end 
    end  
  end
end