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
  describe Sprint_05 do
    describe "Package: AXPT-3807 - Provide ability to see the hotel selected" do    
      driver = nil
      page = nil 
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
      it "On the initial DP Search results (View All Hotels) page, if the 'See All Flights' button is selected the customer lands on 
          the 'View All Flights page'."do
        page = PackageSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_package("round trip flight rate card alert")
        page = PackageResultsPage.new(driver, RSpec.configuration.env) 
        # Check View All Hotels
        page.hotel_rate_card_show_hotel_highlights_labels.each_with_index { |hotel_label,index| 
         hotel_label.text().should eq(feature.verifications.find_by_name('hotel rate card show hotel highlights text').text)
        }
        page.see_all_flights_button.click()
        page.view_hide_roundtrip_flight_details_labels.each_with_index { |flight_label,index|
          flight_label.text().should eq(feature.verifications.find_by_name('view roundtrip flight details text').text)
        }
      end
      
      it "Once on the 'View All Flights page' there is a Your Hotel section with the summary of the hotel selected."do
        page.hotel_rate_card_dp_hotel_selected.should be_present()
        page.hotel_rate_card_your_room_details_label.text().should eq(feature.verifications.find_by_name('hotel rate card your room details text').text)
      end
      
      it "IZ will choose the hotel based on the hotel in the lowest priced package found in the initial DP search result."do
        page.see_all_hotels_button.click()
        initial_DP_search_result = page.hotel_rate_card_hotel_first_name_best_value.text().split(" ").first
        page.see_all_flights_button.click()
        page.hotel_rate_card_your_dp_hotel_name_selected.text().split(" ").first.should be_include(initial_DP_search_result)
      end
      
      it "Summary is similar to the hotel card but not the same. It includes: 1. Hotel Image" do
        page.hotel_rate_card_your_dp_hotel_selected_img.should be_present()
      end
      
      it "Summary is similar to the hotel card but not the same. It includes: 2. Hotel Name and Address" do
        page.hotel_rate_card_your_dp_hotel_name_selected.should be_present()
        page.hotel_rate_card_your_dp_hotel_selected_address.should be_present()
      end
      
      it "Summary is similar to the hotel card but not the same. It includes: 3. Number of rooms" do
        page.hotel_rate_card_your_dp_hotel_selected_number_of_rooms.should be_present()
      end
      
      it "Summary is similar to the hotel card but not the same. It includes: 4. Check in/Check out dates and number of nights. 
          Check in/check out dates have a calendar icon next to them" do
        page.hotel_rate_card_your_dp_hotel_selected_number_of_nights.should be_present()
        page.hotel_rate_card_your_dp_hotel_selected_check_in_date.should be_present()
        page.hotel_rate_card_your_dp_hotel_selected_check_out_date.should be_present()
        # Check calendar icon
        in_calendar_icon = page.hotel_rate_card_your_dp_hotel_selected_check_in_calendar_icon.attribute("src").split("/").last
        out_calendar_icon = page.hotel_rate_card_your_dp_hotel_selected_check_out_calendar_icon.attribute("src").split("/").last
        in_calendar_icon.should eq(feature.verifications.find_by_name('date check in src text').text)
        out_calendar_icon.should eq(feature.verifications.find_by_name('date check out src text').text)
      end
      
      it "Summary is similar to the hotel card but not the same. It includes: 5. Room description." do
        page.hotel_rate_card_your_dp_hotel_selected_room_description.should be_present()
      end
      
      it "If needed, there is a 'More Details' link for the room description. It will only appear 
	        if the description text is long enough that is cropped off. If the link appears, clicking it would simply 
          expand the hotel card to show the remainder of the room description. (room description size, 2 lines)" do
        pending("this funcionality is not implemented yet on the page.")
      end
      
      it "The only thing that's expanding is the room description by clicking on 'More Details' link. If it's expanded, put a 
         'Less Details' link to collapse the description." do
        pending("this funcionality is not implemented yet on the page.")
      end
    end  
  end
end