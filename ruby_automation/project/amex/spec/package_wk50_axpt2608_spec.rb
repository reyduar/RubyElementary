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
  describe Week_50 do
      driver = nil
      search_page = nil
      results_page = nil      
      disambiguation_page = nil       
      feature = Feature.find_by_name('edit itinerary on summary bar feature') 
      package_feature = Feature.find_by_name('dp search form - advanced search options') 
 
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
        driver.manage.delete_all_cookies()
        if example.failed?
          driver.save_screenshot("logs/screenshot_#{Time.now.strftime('%Y%m%d-%H%M%S')}.png")
        end
      end        
      
      after(:all) do
        driver.quit()
      end      
  
    describe "Package: AXPT-2608 - Provide ability to select location and disambiguation options if available" do
      describe "a. Users should be able to choose their preferred airport from a disambiguation list if there are options." do  
        it "There is a link at the top of the page to return to the search request without selecting any option. 
            The link takes the customer back always to the IZ search form with all of the search fields blank." do
          search_page = PackageSearchPage.new(driver, RSpec.configuration.env)
          search_page.visit()
          search_page.departure_city_textbox.send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)
          search_page.arrival_city_textbox.send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)      
          search_page.departure_date_textbox.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          search_page.return_date_textbox.send_keys(eval('(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))  
          search_page.search_button.click()           
          disambiguation_page = PackageDisambiguationPage.new(driver, RSpec.configuration.env)           
          sleep 5
          disambiguation_page.disambiguation_first_selection_in_all_options[0].should be_present() 
          disambiguation_page.back_to_home_link.click()          
          departure_city_text_value = driver.execute_script("return arguments[0].value" , search_page.departure_city_textbox)
          arrival_city_text_value = driver.execute_script("return arguments[0].value" , search_page.arrival_city_textbox)
          departure_date_text_value = driver.execute_script("return arguments[0].value" , search_page.departure_date_textbox)
          return_date_text_value = driver.execute_script("return arguments[0].value" , search_page.return_date_textbox)
          departure_city_text_value.should be_empty()
          arrival_city_text_value.should be_empty()
          departure_date_text_value.should be_empty()
          return_date_text_value.should be_empty()         
        end    
    
        it "Page title: Your Search Matches Multiple Destinations. 
            Each entry in the list has a city, state (US only), country and airport code." do 
          search_page = PackageSearchPage.new(driver, RSpec.configuration.env)
          search_page.visit()
          search_page.departure_city_textbox.send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)
          search_page.arrival_city_textbox.send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)      
          search_page.departure_date_textbox.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          search_page.return_date_textbox.send_keys(eval('(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))  
          search_page.search_button.click()  
          disambiguation_page = PackageDisambiguationPage.new(driver, RSpec.configuration.env)  
          sleep 5   
          disambiguation_page.should be_text_present(feature.verifications.find_by_name('disambiguation page title').text)         
          disambiguation_page.disambiguation_first_selection_in_all_options[0].should be_present()         
          disambiguation_page.disambiguation_first_selection_in_all_options[0].text().should be_include('Miami')
          disambiguation_page.disambiguation_first_selection_in_all_options[1].text().should be_include('Chicago')          
        end  

        it "When the search button is clicked, if one or both of the departure/arrival locations is ambiguous, 
            a page displays asking the customer to make a selection." do  
         search_page = PackageSearchPage.new(driver, RSpec.configuration.env)
         search_page.visit()
         search_page.departure_city_textbox.send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)
         search_page.arrival_city_textbox.send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)      
         search_page.departure_date_textbox.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
         search_page.return_date_textbox.send_keys(eval('(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))  
         search_page.search_button.click()     
         disambiguation_page = PackageDisambiguationPage.new(driver, RSpec.configuration.env)
         sleep 5         
         disambiguation_page.should be_text_present_wait(feature.verifications.find_by_name('disambiguation page title').text, 120)
         departure_matches=0
         arrival_matches=0
         disambiguation_page.disambiguation_destinations_list_titles.each { |destinations_title|
          if !(destinations_title.text().empty?)
              destinations_title.text.should be_include("Please choose your")          
              destinations_title.text.should be_include("destination from the list below")
              if(destinations_title.text.include?("departure"))
                departure_matches += 1
              end
              if(destinations_title.text.include?("arrival"))
                arrival_matches += 1
              end
          end }
         departure_matches.should eq(1)
         arrival_matches.should eq(1)                   
        end        

        it "The page lists the disambiguation options for each unclear departure/arrival, grouped together, and radio buttons to select them.
            The user is required to select a single radio button option for each disambiguation group before clicking the search button.
            If a selection is missing in any of the groupings, the page remains with an error telling the user to select an option in each grouping." do 
          search_page = PackageSearchPage.new(driver, RSpec.configuration.env)
          search_page.visit()
          search_page.departure_city_textbox.send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)
          search_page.arrival_city_textbox.send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)      
          search_page.departure_date_textbox.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          search_page.return_date_textbox.send_keys(eval('(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))  
          search_page.search_button.click()  
          disambiguation_page = PackageDisambiguationPage.new(driver, RSpec.configuration.env)  
          sleep 5          
          disambiguation_page.disambiguation_first_selection_in_all_options[0].should be_present()         
          disambiguation_page.disambiguation_first_selection_in_all_options[0].click()
          disambiguation_page.update_package_search_button.click() 
          disambiguation_page.disambiguation_message_error_label.should be_present()
          disambiguation_page.disambiguation_message_error_label.text().should eq(feature.verifications.find_by_name('disambiguation clarify your search error message').text)          
        end
        
        it "Once all necessary selections are made, the search button can be clicked to kick off the air search." do
          search_page = PackageSearchPage.new(driver, RSpec.configuration.env)
          search_page.visit()
          search_page.departure_city_textbox.send_keys(feature.verifications.find_by_name('departure city ambiguous text').text)
          search_page.arrival_city_textbox.send_keys(feature.verifications.find_by_name('arrival city ambiguous text').text)      
          search_page.departure_date_textbox.send_keys(eval('(Time.now + (5 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          search_page.return_date_textbox.send_keys(eval('(Time.now + (6 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))  
          search_page.search_button.click()     
          disambiguation_page = PackageDisambiguationPage.new(driver, RSpec.configuration.env)
          sleep 5          
          disambiguation_page.disambiguation_first_selection_in_all_options.each { |first_option|
            first_option.click()
          }
          disambiguation_page.update_package_search_button.click() 
          results_page = PackageResultsPage.new(driver, RSpec.configuration.env) 
          sleep 5            
          results_page.package_results_page_head_title.text().should eq(package_feature.verifications.find_by_name('on package results page verification text').text)              
        end
      end          
    end
  end
end