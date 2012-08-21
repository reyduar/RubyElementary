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
require_relative '../db/models/database_model'

describe AMEX_Package do
  describe Week_02 do
    describe "Package: AXPT-3300 - DP Search Summary: Customer should be able to see the number of guests I searched for and the option to change it" do    
      driver = nil
      page = nil 
      feature = Feature.find_by_name('package number of travelers feature')
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
        if example.failed?
          driver.save_screenshot("logs/screenshot_#{Time.now.strftime('%Y%m%d-%H%M%S')}.png")
        end
      end        
      
      after(:all) do
        driver.quit()
      end   
      
      it "The DP Search Summary bar has the number of total guests searched for as a link.
          The number is the total number of guests in all rooms." do                  
        page = PackageSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_package("mixed to verify summary")
        page = PackageResultsPage.new(driver, RSpec.configuration.env)  
        initial_results_url = driver.current_url         
        page.travelers_count_link.text().should eq(feature.verifications.find_by_name('number of travelers link text for 6').text)                  
      end 

      it "When clicked, a drop down appears allowing the change of the number and/or type of guest in each room. 
          If children are added, then ages are mandatory." do          
          # Validating previous entered search values
          page.travelers_count_link.click()
          sleep 1 
          page.room_1_adults_combobox.text().should eq("1") 
          page.room_2_adults_combobox.text().should eq("0") 
          page.room_3_adults_combobox.text().should eq("1") 
          page.room_4_adults_combobox.text().should eq("0")           
          page.room_1_seniors_combobox.text().should eq("0") 
          page.room_2_seniors_combobox.text().should eq("1") 
          page.room_3_seniors_combobox.text().should eq("0") 
          page.room_4_seniors_combobox.text().should eq("1")           
          page.room_1_children_combobox.text().should eq("1") 
          page.room_2_children_combobox.text().should eq("1") 
          page.room_3_children_combobox.text().should eq("0") 
          page.room_4_children_combobox.text().should eq("0")           
          page.children_age_combobox(1,1).text().should eq("<2") 
          page.children_age_combobox(2,1).text().should eq("<2") 
          page.children_seated_option_input(1,1).should_not be_selected() 
          page.children_lap_option_input(1,1).should be_selected()       
          page.children_seated_option_input(2,1).should be_selected()      
          page.children_lap_option_input(2,1).should_not be_selected()                      
          # Changing by other different valid values
          page.select_option(page.room_1_adults_combobox, "0")
          page.select_option(page.room_2_adults_combobox, "1")
          page.select_option(page.room_3_adults_combobox, "0")
          page.select_option(page.room_4_adults_combobox, "1") 
          sleep 1          
          page.select_option(page.room_1_seniors_combobox, "1")
          page.select_option(page.room_2_seniors_combobox, "0")
          page.select_option(page.room_3_seniors_combobox, "1")
          page.select_option(page.room_4_seniors_combobox, "0")               
          sleep 1
          page.select_option(page.room_1_children_combobox, "0")
          page.select_option(page.room_2_children_combobox, "0")
          page.select_option(page.room_3_children_combobox, "1")
          page.select_option(page.room_4_children_combobox, "1")                      
          sleep 1
          page.children_seated_option(4,1).click()   
          sleep 1
          page.travelers_count_link.click()
          sleep 1
          page.travelers_count_link.text().should eq(feature.verifications.find_by_name('number of travelers link text for 6').text)  
          page.travelers_count_link.click()
          page.room_1_adults_combobox.text().should eq("0") 
          page.room_2_adults_combobox.text().should eq("1") 
          page.room_3_adults_combobox.text().should eq("0") 
          page.room_4_adults_combobox.text().should eq("1")           
          page.room_1_seniors_combobox.text().should eq("1") 
          page.room_2_seniors_combobox.text().should eq("0") 
          page.room_3_seniors_combobox.text().should eq("1") 
          page.room_4_seniors_combobox.text().should eq("0")           
          page.room_1_children_combobox.text().should eq("0") 
          page.room_2_children_combobox.text().should eq("0") 
          page.room_3_children_combobox.text().should eq("1") 
          page.room_4_children_combobox.text().should eq("1")           
          page.children_age_combobox(3,1).text().should eq("<2") 
          page.children_age_combobox(4,1).text().should eq("<2") 
          page.children_seated_option_input(3,1).should_not be_selected() 
          page.children_lap_option_input(3,1).should be_selected()       
          page.children_seated_option_input(4,1).should be_selected()      
          page.children_lap_option_input(4,1).should_not be_selected()  
          sleep 1            
      end
      
      it "If the user decreases the number of guests, the rule of having a min of 1 adult or senior in a room still applies.
          Clicking 'Update' kicks off a new hotel search with the new parameters.
          No search results are presented upon a failed validation, only the messages.
          All error messages are displayed in the search results page, below the summary bar." do 
        page.select_option(page.room_1_adults_combobox, "0")
        page.select_option(page.room_2_adults_combobox, "1")
        page.select_option(page.room_3_adults_combobox, "0")
        page.select_option(page.room_4_adults_combobox, "1") 
        sleep 1          
        page.select_option(page.room_1_seniors_combobox, "1")
        page.select_option(page.room_2_seniors_combobox, "0")
        page.select_option(page.room_3_seniors_combobox, "0")
        page.select_option(page.room_4_seniors_combobox, "0")               
        sleep 1
        page.select_option(page.room_1_children_combobox, "0")
        page.select_option(page.room_2_children_combobox, "0")
        page.select_option(page.room_3_children_combobox, "0")
        page.select_option(page.room_4_children_combobox, "0")                      
        sleep 1              
        page.update_button.click()
        sleep 1
        # Clicking 'Update' kicks off a new hotel search with the new parameters.
        page.should_not be_my_element_present(page, "results package cards", "css")
        page = nil
        page = PackageResultsPage.new(driver, RSpec.configuration.env) 
        # No search results are presented upon a failed validation, only the messages.
        page.should_not be_my_element_present(page, "results package cards", "css")
        # Verify error message        
        page.result_error_messages[0].text.should eq(feature.verifications.find_by_name('1 adult or senior per room error message text').text)  
      end       
      
      it "If the user increases the number of guests per room the max of 6 guest occupancy still applies." do 
        page.select_option(page.number_of_rooms_link, "1 Room")
        page.select_option(page.room_1_adults_combobox, "6")     
        page.select_option(page.room_1_seniors_combobox, "1")
        sleep 1  
        page.update_button.click()
        sleep 5
        page.result_error_messages[0].text.should eq(feature.verifications.find_by_name('maximum guests per room error message text').text)  
      end         
      
      it "Validate error message [There must be at least one adult or senior per Infant in lap]" do
        page.select_option(page.number_of_rooms_link, "1 Room")
        page.select_option(page.room_1_adults_combobox, "0") 
        sleep 1          
        page.select_option(page.room_1_seniors_combobox, "0")              
        sleep 1
        page.select_option(page.room_1_children_combobox, "1")      
        sleep 1
        page.update_button.click()      
        sleep 5     
        page.result_error_messages[0].text.should eq(feature.verifications.find_by_name('1 adult or senior per room error message text').text)            
        page.result_error_messages[1].text.should eq(feature.verifications.find_by_name('adult or senior per infant in lap error message text').text)  
      end
      
      it "If the number of guests is adjusted to zero an error results when searching." do 
        page.select_option(page.number_of_rooms_link, "4 Rooms") 
        sleep 1
        page.travelers_count_link.click()
        sleep 1        
        page.select_option(page.room_1_adults_combobox, "0")
        page.select_option(page.room_2_adults_combobox, "0")
        page.select_option(page.room_3_adults_combobox, "0")
        page.select_option(page.room_4_adults_combobox, "0") 
        sleep 1          
        page.select_option(page.room_1_seniors_combobox, "0")
        page.select_option(page.room_2_seniors_combobox, "0")
        page.select_option(page.room_3_seniors_combobox, "0")
        page.select_option(page.room_4_seniors_combobox, "0")               
        sleep 1
        page.select_option(page.room_1_children_combobox, "0")
        page.select_option(page.room_2_children_combobox, "0")
        page.select_option(page.room_3_children_combobox, "0")
        page.select_option(page.room_4_children_combobox, "0")                      
        sleep 1              
        page.update_button.click()  
        sleep 5        
        page.result_error_messages[0].text.should eq(feature.verifications.find_by_name('1 adult or senior per room error message text').text)  
      end          
       
      it "It is not possible to change the number of rooms this way. User needs to click the rooms link to modify number of rooms." do                  
        page.select_option(page.number_of_rooms_link, "1 Room")
        sleep 1
        page.number_of_rooms_link.text().should eq("1 Room") 
        page.select_option(page.number_of_rooms_link, "2 Rooms")
        sleep 1
        page.number_of_rooms_link.text().should eq("2 Rooms")         
        page.select_option(page.number_of_rooms_link, "3 Rooms")
        sleep 1
        page.number_of_rooms_link.text().should eq("3 Rooms")  
        page.select_option(page.number_of_rooms_link, "4 Rooms")
        sleep 1
        page.number_of_rooms_link.text().should eq("4 Rooms")                      
      end       
    end  
  end
end