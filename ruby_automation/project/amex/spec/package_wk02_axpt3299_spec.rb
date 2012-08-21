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
  
    describe "Package: AXPT-3299 - DP Search Summary: Customer should be able to see the number of rooms searched for and the option to change it" do 
      it "The DP Search Summary bar has the number of hotel rooms searched for as a link." do
        page = PackageSearchPage.new(driver, RSpec.configuration.env)
        initial_results_url = driver.current_url
        page.visit()
        page.book_a_package("dp search summary")
        page = PackageResultsPage.new(driver, RSpec.configuration.env)        
        page.room_text_link.should be_present()
        page.room_text_link.text().should eq(feature.verifications.find_by_name('room 1 text').text) 
      end       
      
      it "When clicked, a drop down appears allowing the change of the number of rooms from 1 to 4." do
        page.room_text_link.click       
        # page.room_link_selection_option(1).text().should eq(feature.verifications.find_by_name('room 1 text').text) 
        # page.room_link_selection_option(2).text().should eq(feature.verifications.find_by_name('room 2 text').text) 
        # page.room_link_selection_option(3).text().should eq(feature.verifications.find_by_name('room 3 text').text) 
        # page.room_link_selection_option(4).text().should eq(feature.verifications.find_by_name('room 4 text').text)       
      end
        
      it "If the user decreases the number of rooms, then the guests from the removed room as chosen in the search are removed from the booking." do
        page.select_option(page.room_text_link, "4 Rooms") 
        sleep 1
        page.select_option(page.room_1_adults_combobox, "3") 
        page.select_option(page.room_2_adults_combobox, "3") 
        page.select_option(page.room_3_adults_combobox, "3") 
        page.select_option(page.room_4_adults_combobox, "3")         
        page.select_option(page.room_1_seniors_combobox, "1") 
        page.select_option(page.room_2_seniors_combobox, "1") 
        page.select_option(page.room_3_seniors_combobox, "1") 
        page.select_option(page.room_4_seniors_combobox, "1")  
        # total guest booking 
        guest_total = page.travelers_count_link.text().to_i
        page.travelers_count_link.text().to_i.should eq(16)
        page.room_text_link.click
        #########################################
        page.select_option(page.room_text_link, "3 Rooms") 
        page.travelers_count_link.text().to_i.should be < guest_total
        page.travelers_count_link.text().to_i.should eq(12)
        page.room_text_link.click
        #########################################
        page.select_option(page.room_text_link, "2 Rooms") 
        page.travelers_count_link.text().to_i.should be < guest_total
        page.travelers_count_link.text().to_i.should eq(8)
        page.room_text_link.click
        #########################################
        page.select_option(page.room_text_link, "1 Room") 
        page.travelers_count_link.text().to_i.should be < guest_total
        page.travelers_count_link.text().to_i.should eq(4)
      end
        
      it "If the user increases the number of rooms on clicking the new room number, the guests' box opens up with the newly added room showing 0 guests." do
        #Room 2
        page.room_text_link.click
        page.select_option(page.room_text_link, "2 Rooms") 
        page.room_2_adults_combobox.text().to_i.should eq(0)
        page.room_2_seniors_combobox.text().to_i.should eq(0)
        page.room_2_children_combobox.text().to_i.should eq(0)
        #Room 3
        page.room_text_link.click
        page.select_option(page.room_text_link, "3 Rooms") 
        page.room_3_adults_combobox.text().to_i.should eq(0)
        page.room_3_seniors_combobox.text().to_i.should eq(0)
        page.room_3_children_combobox.text().to_i.should eq(0)
        #Room 4
        page.room_text_link.click
        page.select_option(page.room_text_link, "4 Rooms") 
        page.room_4_adults_combobox.text().to_i.should eq(0)
        page.room_4_seniors_combobox.text().to_i.should eq(0)
        page.room_4_children_combobox.text().to_i.should eq(0)
      end
        
      it "Clicking 'Update' kicks off a new hotel search with the new parameters. All rooms must have at least 1 adult or senior guest associated to it or the search fails." do
        page = PackageSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_package("dp search summary")
        page = PackageResultsPage.new(driver, RSpec.configuration.env) 
        page.room_text_link.click
        page.select_option(page.room_text_link, "2 Rooms") 
        page.room_text_link.click
        page.select_option(page.room_text_link, "1 Room") 
        page.room_1_adults_combobox.text().to_i.should eq(2)
        page.room_1_seniors_combobox.text().to_i.should eq(0)
        page.room_1_adults_combobox.click
        page.select_option(page.room_1_adults_combobox, "3") 
        page.select_option(page.room_1_seniors_combobox, "1") 
        page.update_button.click
        page = nil
        page = PackageResultsPage.new(driver, RSpec.configuration.env)           
        page.room_text_link.click
        page.select_option(page.room_text_link, "2 Rooms") 
        page.room_text_link.click
        page.select_option(page.room_text_link, "1 Room") 
        page.room_1_adults_combobox.text().to_i.should eq(3)
        page.room_1_seniors_combobox.text().to_i.should eq(1)          
        sleep 2
        driver.current_url.should_not eq(initial_results_url)
        page.select_option(page.room_1_adults_combobox, "0") 
        page.select_option(page.room_1_seniors_combobox, "0") 
        page.update_button.click
        page = nil
        page = PackageResultsPage.new(driver, RSpec.configuration.env) 
        page.result_error_messages[0].should be_present()
        page.result_error_messages[0].text().should eq(feature.verifications.find_by_name('at least one adult or one senior error message text').text)                     
        sleep 2
        driver.current_url.should_not eq(initial_results_url)         
      end
        
      it "All error messages are displayed in the search results page, below the summary bar.
          No search results are presented upon a failed validation, only the messages." do
        page = PackageSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_package("dp search summary")
        page = PackageResultsPage.new(driver, RSpec.configuration.env)  
        page.first_dp_hotel_card.should be_present()
        page.room_text_link.click
        page.select_option(page.room_text_link, "2 Rooms") 
        page.room_text_link.click
        page.select_option(page.room_text_link, "1 Room") 
        page.select_option(page.room_1_adults_combobox, "6") 
        page.select_option(page.room_1_seniors_combobox, "1") 
        page.update_button.click          
        page.result_error_messages[0].should be_present()
        page.result_error_messages[0].text().should eq(feature.verifications.find_by_name('maximum number of guests per room is 6 error message text').text)           
        page.should_not be_my_element_present(page, "first dp hotel card", "css")  
      end
    end
  end
end