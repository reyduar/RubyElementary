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
  describe Week_50 do
      driver = nil
      page = nil 
      package = Package.find_by_name('advanced search options elements')
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
  
    describe "Package: AXPT-2604 - Provide advanced search options on DP search form" do
      describe "a. User should be able to select the number and type of people and number of rooms." do          
        it "There's a section named 'How many rooms and travelers?"  do
          page = PackageSearchPage.new(driver, RSpec.configuration.env)
          page.visit()       
          page.how_many_rooms_and_travelers_label.text().should eq(feature.verifications.find_by_name('how many rooms section text').text)      
        end      
      
        it "3. Default is 2 adult travelers and 1 room." do
          page.rooms_combobox_selected_option.text.should eq((1).to_s)          
          page.adults_combobox_selected_option(1).text.should eq((2).to_s)
        end
        
        it "2. Maximum of 4 rooms can be requested." do
          page.select_option(page.rooms_combobox, (5).to_s)
          page.rooms_combobox_selected_option.text.should_not eq((5).to_s)
        end        

        it "1. There is a dropdown for 'Rooms' where for each room it is required to specify number of travelers." do
          page.select_option(page.rooms_combobox, package.rooms.to_s)
        end
        
        it "Adults drop down allows selection of 0-6" do
          page.select_option(page.adults_combobox(1), (6).to_s)
          page.select_option(page.adults_combobox(2), (6).to_s)
          page.select_option(page.adults_combobox(3), (6).to_s)
          page.select_option(page.adults_combobox(4), (6).to_s)
          page.select_option(page.adults_combobox(1), (0).to_s)
          page.select_option(page.adults_combobox(2), (0).to_s)
          page.select_option(page.adults_combobox(3), (0).to_s)
          page.select_option(page.adults_combobox(4), (0).to_s)          
        end

        it "Seniors drop down allows selection of 0-6." do
          page.select_option(page.seniors_combobox(1), (6).to_s)
          page.select_option(page.seniors_combobox(2), (6).to_s)
          page.select_option(page.seniors_combobox(3), (6).to_s)
          page.select_option(page.seniors_combobox(4), (6).to_s)        
          page.select_option(page.seniors_combobox(1), (0).to_s)
          page.select_option(page.seniors_combobox(2), (0).to_s)
          page.select_option(page.seniors_combobox(3), (0).to_s)
          page.select_option(page.seniors_combobox(4), (0).to_s)            
        end

        it "Children drop down allows selection of 0-5." do
          page.select_option(page.children_combobox(1), (5).to_s)
          page.select_option(page.children_combobox(2), (5).to_s)
          page.select_option(page.children_combobox(3), (5).to_s)
          page.select_option(page.children_combobox(4), (5).to_s)        
          page.select_option(page.children_combobox(1), (0).to_s)
          page.select_option(page.children_combobox(2), (0).to_s)
          page.select_option(page.children_combobox(3), (0).to_s)
          page.select_option(page.children_combobox(4), (0).to_s)                       
          page.select_option(page.children_combobox(1), (5).to_s)
          page.select_option(page.children_combobox(2), (5).to_s)
          page.select_option(page.children_combobox(3), (5).to_s)
          page.select_option(page.children_combobox(4), (5).to_s)           
        end  

        it "The number of children selected in the drop down will trigger that same number of age boxes to appear.
            Valid ages to input are (<2-17)." do 
          page.select_option(page.children_age_combobox(1,1), (17).to_s)
          page.select_option(page.children_age_combobox(1,2), (17).to_s)
          page.select_option(page.children_age_combobox(1,3), (17).to_s)
          page.select_option(page.children_age_combobox(1,4), (17).to_s)          
          page.select_option(page.children_age_combobox(1,5), (17).to_s)            
          page.select_option(page.children_age_combobox(1,1), '<2')
          page.select_option(page.children_age_combobox(1,2), '<2')
          page.select_option(page.children_age_combobox(1,3), '<2')
          page.select_option(page.children_age_combobox(1,4), '<2')          
          page.select_option(page.children_age_combobox(1,5), '<2')            
          page.select_option(page.children_age_combobox(2,1), (17).to_s)
          page.select_option(page.children_age_combobox(2,2), (17).to_s)
          page.select_option(page.children_age_combobox(2,3), (17).to_s)
          page.select_option(page.children_age_combobox(2,4), (17).to_s)          
          page.select_option(page.children_age_combobox(2,5), (17).to_s)  
          page.select_option(page.children_age_combobox(2,1), '<2')
          page.select_option(page.children_age_combobox(2,2), '<2')
          page.select_option(page.children_age_combobox(2,3), '<2')
          page.select_option(page.children_age_combobox(2,4), '<2')    
          page.select_option(page.children_age_combobox(2,5), '<2')  
          page.select_option(page.children_age_combobox(3,1), (17).to_s)
          page.select_option(page.children_age_combobox(3,2), (17).to_s)
          page.select_option(page.children_age_combobox(3,3), (17).to_s)
          page.select_option(page.children_age_combobox(3,4), (17).to_s)          
          page.select_option(page.children_age_combobox(3,5), (17).to_s)           
          page.select_option(page.children_age_combobox(3,1), '<2')
          page.select_option(page.children_age_combobox(3,2), '<2')
          page.select_option(page.children_age_combobox(3,3), '<2')
          page.select_option(page.children_age_combobox(3,4), '<2')    
          page.select_option(page.children_age_combobox(3,5), '<2')             
          page.select_option(page.children_age_combobox(4,1), (17).to_s)
          page.select_option(page.children_age_combobox(4,2), (17).to_s)
          page.select_option(page.children_age_combobox(4,3), (17).to_s)
          page.select_option(page.children_age_combobox(4,4), (17).to_s)          
          page.select_option(page.children_age_combobox(4,5), (17).to_s)                       
          page.select_option(page.children_age_combobox(4,1), '<2')
          page.select_option(page.children_age_combobox(4,2), '<2')
          page.select_option(page.children_age_combobox(4,3), '<2')
          page.select_option(page.children_age_combobox(4,4), '<2')              
          page.select_option(page.children_age_combobox(4,5), '<2')                  
        end 

        it "There are 2 selections for 0-2 years old. One radio button for 0-2 infant in lap and one for 0-2 infant in seat.
            Default radio button selected is In Lap." do 
          # One radio button for 0-2 infant in lap. Default radio button selected is In Lap.
          page.children_lap_option_input(1,1).should be_selected() 
          page.children_lap_option_input(1,2).should be_selected() 
          page.children_lap_option_input(1,3).should be_selected() 
          page.children_lap_option_input(1,4).should be_selected() 
          page.children_lap_option_input(1,5).should be_selected()           
          page.children_lap_option_input(2,1).should be_selected() 
          page.children_lap_option_input(2,2).should be_selected() 
          page.children_lap_option_input(2,3).should be_selected() 
          page.children_lap_option_input(2,4).should be_selected() 
          page.children_lap_option_input(2,5).should be_selected()             
          page.children_lap_option_input(3,1).should be_selected() 
          page.children_lap_option_input(3,2).should be_selected() 
          page.children_lap_option_input(3,3).should be_selected() 
          page.children_lap_option_input(3,4).should be_selected() 
          page.children_lap_option_input(3,5).should be_selected()                       
          page.children_lap_option_input(4,1).should be_selected() 
          page.children_lap_option_input(4,2).should be_selected() 
          page.children_lap_option_input(4,3).should be_selected() 
          page.children_lap_option_input(4,4).should be_selected() 
          page.children_lap_option_input(4,5).should be_selected()             
          # and one for 0-2 infant in seat.
          page.children_seated_option(1,1).click()
          page.children_seated_option(1,2).click()
          page.children_seated_option(1,3).click()
          page.children_seated_option(1,4).click()
          page.children_seated_option(1,5).click()                              
          page.children_seated_option(2,1).click()
          page.children_seated_option(2,2).click()
          page.children_seated_option(2,3).click()
          page.children_seated_option(2,4).click()
          page.children_seated_option(2,5).click()           
          page.children_seated_option(3,1).click()
          page.children_seated_option(3,2).click()
          page.children_seated_option(3,3).click()
          page.children_seated_option(3,4).click()
          page.children_seated_option(3,5).click()           
          page.children_seated_option(4,1).click()
          page.children_seated_option(4,2).click()
          page.children_seated_option(4,3).click()
          page.children_seated_option(4,4).click()
          page.children_seated_option(4,5).click()           
          page.children_lap_option_input(1,1).should_not be_selected() 
          page.children_lap_option_input(1,2).should_not be_selected() 
          page.children_lap_option_input(1,3).should_not be_selected() 
          page.children_lap_option_input(1,4).should_not be_selected() 
          page.children_lap_option_input(1,5).should_not be_selected()           
          page.children_lap_option_input(2,1).should_not be_selected() 
          page.children_lap_option_input(2,2).should_not be_selected() 
          page.children_lap_option_input(2,3).should_not be_selected() 
          page.children_lap_option_input(2,4).should_not be_selected() 
          page.children_lap_option_input(2,5).should_not be_selected()             
          page.children_lap_option_input(3,1).should_not be_selected() 
          page.children_lap_option_input(3,2).should_not be_selected() 
          page.children_lap_option_input(3,3).should_not be_selected() 
          page.children_lap_option_input(3,4).should_not be_selected() 
          page.children_lap_option_input(3,5).should_not be_selected()                       
          page.children_lap_option_input(4,1).should_not be_selected() 
          page.children_lap_option_input(4,2).should_not be_selected() 
          page.children_lap_option_input(4,3).should_not be_selected() 
          page.children_lap_option_input(4,4).should_not be_selected() 
          page.children_lap_option_input(4,5).should_not be_selected()          

          # Hide controls validation
          page.select_option(page.children_age_combobox(1,1), (17).to_s)
          page.select_option(page.children_age_combobox(1,2), (17).to_s)
          page.select_option(page.children_age_combobox(1,3), (17).to_s)
          page.select_option(page.children_age_combobox(1,4), (17).to_s)          
          page.select_option(page.children_age_combobox(1,5), (17).to_s)                      
          page.select_option(page.children_age_combobox(2,1), (17).to_s)
          page.select_option(page.children_age_combobox(2,2), (17).to_s)
          page.select_option(page.children_age_combobox(2,3), (17).to_s)
          page.select_option(page.children_age_combobox(2,4), (17).to_s)          
          page.select_option(page.children_age_combobox(2,5), (17).to_s)  
          page.select_option(page.children_age_combobox(3,1), (17).to_s)
          page.select_option(page.children_age_combobox(3,2), (17).to_s)
          page.select_option(page.children_age_combobox(3,3), (17).to_s)
          page.select_option(page.children_age_combobox(3,4), (17).to_s)          
          page.select_option(page.children_age_combobox(3,5), (17).to_s)                       
          page.select_option(page.children_age_combobox(4,1), (17).to_s)
          page.select_option(page.children_age_combobox(4,2), (17).to_s)
          page.select_option(page.children_age_combobox(4,3), (17).to_s)
          page.select_option(page.children_age_combobox(4,4), (17).to_s)          
          page.select_option(page.children_age_combobox(4,5), (17).to_s)           
          page.should_not be_element_present(page, "room 1 - child in lap option 1", "css") 
          page.should_not be_element_present(page, "room 1 - child in lap option 2", "css") 
          page.should_not be_element_present(page, "room 1 - child in lap option 3", "css") 
          page.should_not be_element_present(page, "room 1 - child in lap option 4", "css") 
          page.should_not be_element_present(page, "room 1 - child in lap option 5", "css")           
          page.should_not be_element_present(page, "room 2 - child in lap option 1", "css") 
          page.should_not be_element_present(page, "room 2 - child in lap option 2", "css") 
          page.should_not be_element_present(page, "room 2 - child in lap option 3", "css") 
          page.should_not be_element_present(page, "room 2 - child in lap option 4", "css") 
          page.should_not be_element_present(page, "room 2 - child in lap option 5", "css") 
          page.should_not be_element_present(page, "room 3 - child in lap option 1", "css") 
          page.should_not be_element_present(page, "room 3 - child in lap option 2", "css") 
          page.should_not be_element_present(page, "room 3 - child in lap option 3", "css") 
          page.should_not be_element_present(page, "room 3 - child in lap option 4", "css") 
          page.should_not be_element_present(page, "room 3 - child in lap option 5", "css") 
          page.should_not be_element_present(page, "room 4 - child in lap option 1", "css") 
          page.should_not be_element_present(page, "room 4 - child in lap option 2", "css") 
          page.should_not be_element_present(page, "room 4 - child in lap option 3", "css") 
          page.should_not be_element_present(page, "room 4 - child in lap option 4", "css") 
          page.should_not be_element_present(page, "room 4 - child in lap option 5", "css")           
          page.should_not be_element_present(page, "room 1 - child in seat option 1", "css") 
          page.should_not be_element_present(page, "room 1 - child in seat option 2", "css") 
          page.should_not be_element_present(page, "room 1 - child in seat option 3", "css") 
          page.should_not be_element_present(page, "room 1 - child in seat option 4", "css") 
          page.should_not be_element_present(page, "room 1 - child in seat option 5", "css")        
          page.should_not be_element_present(page, "room 2 - child in seat option 1", "css") 
          page.should_not be_element_present(page, "room 2 - child in seat option 2", "css") 
          page.should_not be_element_present(page, "room 2 - child in seat option 3", "css") 
          page.should_not be_element_present(page, "room 2 - child in seat option 4", "css") 
          page.should_not be_element_present(page, "room 2 - child in seat option 5", "css") 
          page.should_not be_element_present(page, "room 3 - child in seat option 1", "css") 
          page.should_not be_element_present(page, "room 3 - child in seat option 2", "css") 
          page.should_not be_element_present(page, "room 3 - child in seat option 3", "css") 
          page.should_not be_element_present(page, "room 3 - child in seat option 4", "css") 
          page.should_not be_element_present(page, "room 3 - child in seat option 5", "css") 
          page.should_not be_element_present(page, "room 4 - child in seat option 1", "css") 
          page.should_not be_element_present(page, "room 4 - child in seat option 2", "css") 
          page.should_not be_element_present(page, "room 4 - child in seat option 3", "css") 
          page.should_not be_element_present(page, "room 4 - child in seat option 4", "css") 
          page.should_not be_element_present(page, "room 4 - child in seat option 5", "css")                    
        end
        
        it "Validation requires at least one adult OR one senior in each room." do
          # one adult per room
          page = PackageSearchPage.new(driver, RSpec.configuration.env)          
          page.visit()       
          page.book_a_package("one adult at least in each room")
          page = PackageResultsPage.new(driver, RSpec.configuration.env)
          sleep 2
          page.package_results_page_head_title.text.should eq(feature.verifications.find_by_name('on package results page verification text').text)
          # one senior per room
          page = PackageSearchPage.new(driver, RSpec.configuration.env)          
          page.visit()       
          page.book_a_package("one senior at least in each room")
          page = PackageResultsPage.new(driver, RSpec.configuration.env)
          page.package_results_page_head_title.text.should eq(feature.verifications.find_by_name('on package results page verification text').text)        
          # only children per room
          page = PackageSearchPage.new(driver, RSpec.configuration.env)          
          page.visit()       
          page.book_a_package("only children in each room")
          page.should be_text_present(feature.verifications.find_by_name('at least one adult or one senior per room error message text').text)           
        end 
        
        it "Validation requires 1 adult or senior per Infant in lap." do
          # one adult Infant in lap.
          page = PackageSearchPage.new(driver, RSpec.configuration.env)          
          page.visit()       
          page.book_a_package("one adult at least per Infant in lap")
          page.should be_text_present(feature.verifications.find_by_name('at least one adult or one senior per infant in lap error message text').text)
          # one senior Infant in lap.
          page = PackageSearchPage.new(driver, RSpec.configuration.env)          
          page.visit()       
          page.book_a_package("one senior at least per Infant in lap")
          page.should be_text_present(feature.verifications.find_by_name('at least one adult or one senior per infant in lap error message text').text)             
        end
               
        it "Validation limits per room occupancy to 6." do
          page = PackageSearchPage.new(driver, RSpec.configuration.env)          
          page.visit()       
          page.book_a_package("six people max per room")
          page.should be_text_present(feature.verifications.find_by_name('maximum number of guests per room error message text').text)         
        end        
        
        it "Validation limits the total number of travelers to 9, including infants in lap and in a seat across all rooms." do
          page = PackageSearchPage.new(driver, RSpec.configuration.env)          
          page.visit()       
          page.book_a_package("nine people max all rooms")
          page.should be_text_present(feature.verifications.find_by_name('maximum number of travelers error message text').text)         
        end    
       end  
            
      describe "c. Users should be able to see the option to get help in DP Search Form" do 
        it "The link 'Need Help' will always appear at various places on the search form designated by a '?'.
            For DP, the Help Link is only for How many Rooms and Travelers.
            When clicked, it presents the user with help on the given field or topic." do
          page = PackageSearchPage.new(driver, RSpec.configuration.env)          
          page.visit()       
          page.how_many_rooms_and_travelers_help_link.click()
          page.help_popup_text_paragraphs[0].should be_displayed()        
        end 
                        
        it "There is a way to exit the help overlay once finished." do 
          page = nil
          page = PackageSearchPage.new(driver, RSpec.configuration.env)  
          page.help_popup_close_button.click()
          sleep 2
          page.should_not be_element_present(page, "help popup text paragraphs", "css")
        end  
      end        
    end
  end
end