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
require_relative '../pages/hotel_description_page'
require_relative '../db/models/database_model'

describe AMEX_Hotel do
  describe Week_02 do
    describe "Hotel: AXPT-3584 - Provide user with options to change his room choice" do    
      driver = nil
      page = nil
      
      bridge = Selenium::WebDriver::Navigation   
      feature = Feature.find_by_name('details room property card')
      
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
      it "Under the summary of the room and the photos and reviews, the Rooms and Rates will be listed.
          All hotel rates available will be listed, there is at least 1 for all properties." do
        page = HotelSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_hotel('sort results hotel search')
        page = HotelResultsPage.new(driver, RSpec.configuration.env)
        page.hotel_card_more_details_link.click
        page = HotelDescriptionPage.new(driver, RSpec.configuration.env)
        count_card = 0
        page.lowest_rate_guaranteed_results_detail_cars.each { |card_detail|
          card_detail.should be_present()
          count_card += 1
         } 
         count_card.should be > 0
      end 
         
      it "For every rate that appears in the list there is a description of the room and a select button." do
        page.description_room_details_label.should be_present()
        page.room_details_label.should be_present()
        page.book_button.should be_present()
        page.room_details_label.text().should eq(feature.verifications.find_by_name('room details text').text) 
        page.book_button.text().should eq(feature.verifications.find_by_name('book button text').text) 
      end
      
      it "Any availability failures at this point will keep the customer on the details page with a note to select a different room." do
        page.room_combobox.click
        page.room_combobox_selection_options[3].click()
        page.update_button.click
        page.rooms_and_rates_tab.click
        page.book_button.click
        if (page.booking_the_selected_room_error_message.present?)
          page.rooms_and_rates_tab.should be_present
          page.booking_the_selected_room_error_message.text().should eq(feature.verifications.find_by_name('room error message text').text) 
        else
          page.room_details_label.should be_present()
        end
      end
      
      it "Scope of this story is to send the rate rules request and get a response. Success will be demonstrated by seeing the spinner and 
          displaying the error message if it applies." do
        driver.execute_script("arguments[0].value = ''" , page.check_out_date_calendar) 
        page.check_out_date_calendar.send_keys(eval('(Time.now + (40 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
        page.room_combobox.click
        page.room_combobox_selection_options[0].click()
        page.update_button.click
        page.number_of_days_error_message.should be_present()
        page.number_of_days_error_message.text().should eq(feature.verifications.find_by_name('number of days error message text').text) 
       end
    end  
  end
end