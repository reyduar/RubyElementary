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
require_relative '../pages/hotel_checkout_page'
require_relative '../db/models/database_model'

describe AMEX_Hotel do
  describe Sprint_05 do
    describe "Script_01" do    
      driver = nil
      page = nil 
      feature = Feature.find_by_name('search hotel in a variety of ways') 
      result_hotel_img = nil
      index_card = 0
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
      describe "AXPT-982: Hotel Details Rooms and Rates - As a customer I want a list view of other rates available at the hotel." do
        it "Remain on Search Results page for Henderson, NV. Scroll down to Green Valley Ranch (these rates have strike thru 
           pricing & multiple room types)" do
          page = HotelSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.destination_textbox.send_keys(feature.verifications.find_by_name('edit hotel destination text').text)
          page.destination_textbox.send_keys(:arrow_down) 
          page.destination_textbox.send_keys(:tab) 
          page.check_in_date_textbox.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          page.check_out_date_textbox.send_keys(eval('(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          page.search_hotels_button.click()
          page = HotelResultsPage.new(driver, RSpec.configuration.env) 
          page.hotel_card_titles.each_with_index { |card,index|
           if(card.text().include?("Green Valley"))
              page.results_hotel_cards[index].text().should be_include("Green Valley Ranch")
              index_card = index
            end
           } 
           page.results_hotel_cards[index_card].should be_present()
        end 
        
        it "Click More Details. Scroll up to view we are on Rooms & Rates tabs." do
          page.hotel_card_more_details_links[index_card].click()
          page = HotelDescriptionPage.new(driver, RSpec.configuration.env)
          page.rooms_and_rates_tab.should be_present()
          page.rooms_and_rates_tab.click()
          page.lowest_rate_guaranteed_tab.text().should eq("LOWEST RATE GUARANTEED")
        end 
        
        it "Show multiple rates, click on nightly rates tab." do
          page.see_nightly_rates_link.should be_present()
          page.see_nightly_rates_link.click()
          page.nightly_rates_tab_text.text().should eq("Nightly rates")
          page.nightly_rates_tab_close_button[0].click()
        end
        
        it "click on More link next to 'Book Now to Save'" do
          pending("this funcionality is not implemented yet on the page.")  
        end
        
        it "Click on Room Restrictions and Cancellaiton Policy" do
          page.room_restrictions_and_cancellation_policy_link.should be_present()
          page.room_restrictions_and_cancellation_policy_link.text().should eq("Room Restrictions and Cancellation Policy")
          page.room_restrictions_and_cancellation_policy_link.click()
          page.dialog_restrictions_and_cancellation_policy_title.should be_present()
          page.dialog_restrictions_and_cancellation_policy_title.text().should eq("Room Restrictions And Cancellation Policy")
          page.dialog_restrictions_and_cancellation_policy_title.send_keys(:escape)    
        end
      end 
      
      describe "AXPT-977: Hotel Details Map - As a customer I want to see the hotel plotted on a map" do
        it "Remain on Hotel Details page for Green Valley Ranch. Click on Map tab. Show both maps, and important 
           information & hotel policies under street view map.
           Comment: labels 'important information and hotel policies' were changed to Rooms & Rates tab" do
          page.map_tab.should be_present()
          page.map_tab.click()
          page.map_view_1_img.should be_present()
          page.map_view_2_img.should be_present()
          page.map_view_1_img.attribute("src").split("com").first.should be_include(feature.verifications.find_by_name('hotel map img src').text)
          page.map_view_2_img.attribute("src").split("com").first.should be_include(feature.verifications.find_by_name('hotel map img src').text)
        end
      end
      
      describe "AXPT-976: Hotel Details Description - As a customer I want to see a description of the hotel" do
        it "Remain on Hotel Details page for Green Valley Ranch. Click on Description tab. Show hotel name & description" do
          page.description_tab.should be_present()
          page.description_tab.click()
          page.description_tab_hotel_name_title.should be_present()
          page.description_tab_hotel_name_title.text().should eq(page.hotel_name_title.text())
          page.description_tab_hotel_description_general.should be_present()
        end
      end 
      
      describe "AXPT-975: Hotel Details Amenities - As a customer I want to see the amenities the hotel offers" do
        it "Remain on Hotel Details page for  Green Valley Ranch. Click on Amenities tab. Show list of amenities, scroll down 
           to view important information and hotel policies.
           Comment: labels 'important information and hotel policies' were changed to Rooms & Rates tab" do
          page.amenities_tab.should be_present()
          page.amenities_tab.click()
          page.list_of_amenities.should be_present()
        end
      end 
      
      describe "AXPT-923: Hotel Details Images - As a customer I want to see images of the hotel" do
         it "Remain on Hotel Details page for  Green Valley Ranch. Scroll up to view photo scroll. Click on buttons to view photo choices" do
            page.carousel_photo_reviews_buttons.each_with_index { |carousel_button,index|
            carousel_button.click()
            page.pagination_reviews_button.attribute("class").should eq("current")
           } 
         end
         
         it "Hit 'back to search results' to view main photo of hotel. Hit 'more details' to show main image is 1st in carousel" do
            page.back_to_search_results_link.click()
            sleep 2
            page = HotelResultsPage.new(driver, RSpec.configuration.env) 
            result_hotel_img = page.hotel_card_photos_img[index_card].attribute("src").split("/").last
            page.hotel_card_more_details_links[index_card].click()
            sleep 2
            page = HotelDescriptionPage.new(driver, RSpec.configuration.env)
            result_hotel_img.should eq(page.slides_control_view_photos[0].attribute("src").split("/").last)
         end
      end
      
      describe "AXPT-1042: Review Your Trip - As a customer I want to see my progress on the booking path" do
        it "Remain on Hotel Details page for  Green Valley Ranch. From Rooms & Rates tab. Click on Book on first room available
           Upon Review Your Booking & Pay page, bread crumbs are in upper right corner" do
          page.rooms_and_rates_tab.click()
          page.book_button.click()
          page = HotelCheckoutPage.new(driver, RSpec.configuration.env)
          page.review_your_hotel_booking_label[0].text().should eq("Review Your Hotel Booking")
          page.step_1_checkout_label.text().upcase.should eq(page.checkout_title.text().upcase)
          page.step_2_information_label.text().should eq("CONFIRMATION")
        end
      end
    end  
  end
end
