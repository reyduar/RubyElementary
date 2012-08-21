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
require_relative '../pages/amex_login_page'
require_relative '../db/models/database_model'

describe AMEX_Hotel do
  describe Sprint_07 do
    describe Script_01 do
      driver = nil
      page = nil   
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
    
      describe "Hotel: AXPT-513 - Property Card - As a customer I want to see the price in points" do 
        it "Search for Los Angeles, 6/10 to 6/12. View Beverly Hills Hotel
           - Click the ? to open the Overlay 
           - Click 'Show Hotel Highlights'
           - Click 'More' to open the overlay" do   
          page = HotelSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.login_in_button.click()
          # Log in as User 1: MR enrolled
          page = AmexLoginPage.new(driver, RSpec.configuration.env)
          page.amex_login_user_textbox.click()
          page.amex_login_user_textbox.send_keys('sdmtb7786')
          page.amex_login_password_textbox.click() 
          page.amex_login_password_textbox.send_keys('flower11')  
          page.amex_login_button.click()
          page = HotelSearchPage.new(driver, RSpec.configuration.env)
          # Note: There is no way to select  "Los Angeles, CA, US" how first option. That's why
          # I send arrow_down 4 times to reach that option.
          page.destination_textbox.send_keys("Los Angeles, CA, US")
          page.destination_textbox.send_keys(:arrow_down) 
          page.destination_textbox.send_keys(:arrow_down) 
          page.destination_textbox.send_keys(:arrow_down) 
          page.destination_textbox.send_keys(:arrow_down) 
          page.destination_textbox.send_keys(:tab)      
          page.check_in_date_textbox.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          page.check_out_date_textbox.send_keys(eval('(Time.now + (9 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          page.search_hotels_button.click()
          page = HotelResultsPage.new(driver, RSpec.configuration.env) 
          page.hotel_card_titles.each_with_index { |card,index| index_card = index        
          break if(card.text().eql?("Beverly Hills Plaza Hotel More Details")) }
          page.results_hotel_cards[index_card].should be_present()
          page.hotel_card_special_offer_question_buttons[index_card].should be_present()
          page.hotel_card_special_offer_question_buttons[index_card].click()
          page.overlay_special_offer_for_you_title_2.text().should eq("Special Offer For You")
          page.overlay_special_offer_for_you_title_2.send_keys(:escape) 
          
          page.hotel_card_promo_more_links[index_card].should be_present()
          page.hotel_card_promo_more_links[index_card].click()
          page.overlay_special_offer_for_you_title_1.text().should eq("Special Offer For You")
          page.overlay_special_offer_for_you_title_1.send_keys(:escape) 
          
          page.hotel_card_show_hotel_highlights_buttons[index_card].should be_present()
          page.hotel_card_show_hotel_highlights_buttons[index_card].click()
          puts page.hotel_card_show_hotel_highlights_buttons[index_card].text().should eq("Hide Hotel Highlights")
        end
      end
      
      describe "Hotel: AXPT-4544 Property Card - As a customer I want to see the Average Nightly Rate shown" do
        it "Remain on Search page for Los Angeles. View the Average Nightly Rate. View strikethrough pricing @ Bev. Hills Hotel" do
          page.hotel_card_average_nightly_rate_labels[index_card].text().should eq("Average Nightly Rate")
          page.hotel_card_price_number_labels[index_card].should be_present()
        end
        
        it "Sort Price Low to High. New Search for Gdansk Poland. Verify alternate currency" do
          driver.execute_script("arguments[0].value = ''" , page.destination_textbox)
          # Note: There is no way to select  "Gdansk, PL" how first option. That's why
          # I send arrow_down twice to reach that option.
          page.destination_textbox.send_keys("Gdansk, PL")
          page.destination_textbox.send_keys(:arrow_down) 
          page.destination_textbox.send_keys(:arrow_down) 
          page.destination_textbox.send_keys(:tab) 
          page.update_button.click()
          page.sort_by_combobox.click()
          page.sort_by_combobox_values[1].click()
          page.hotel_card_price_currencies.each_with_index { |currency,index|
            currency.text().should_not eq("$")
          }
        end
      end
      
      describe "Hotel: AXPT-1716 Hotel Details - As a customer I want to request the rate on a hotel returned without one" do
        it "Change search city to Sierra Nevada, ES 8/23 to 8/27. Page down to bottom, load 'more results'" do
          driver.execute_script("arguments[0].value = ''" , page.destination_textbox)
          page.destination_textbox.send_keys("Sierra Nevada")
          # Note: There is no way to select  "Sierra Nevada" how first option. That's why
          # I send arrow_down one to reach that option.
          page.destination_textbox.send_keys(:arrow_down) 
          page.destination_textbox.send_keys(:tab) 
          page.update_button.click()
          driver.execute_script("scroll(0,15000);")
          sleep 3
          driver.execute_script("scroll(0,15000);")  
          sleep 3
          page.loading_more_results_element.should be_present()
        end
      end
      
      describe "Hotel: AXPT-910 Map View - As a customer I want to see details of the hotels plotted on the map" do
        it "New Search for Disneyland: 8/25 to 8/27. On Hotel Map View" do
          driver.execute_script("arguments[0].value = ''" , page.destination_textbox)
          # Note: There is no way to select  "Disneyland" how first option. That's why
          # I send arrow_down 5 times to reach that option.
          page.destination_textbox.send_keys("Disneyland")
          page.destination_textbox.send_keys(:arrow_down) 
          page.destination_textbox.send_keys(:arrow_down) 
          page.destination_textbox.send_keys(:arrow_down) 
          page.destination_textbox.send_keys(:arrow_down) 
          page.destination_textbox.send_keys(:arrow_down) 
          page.destination_textbox.send_keys(:tab) 
          page.update_button.click()
          page.map_view_tab.click()
          page.plot_location_label.text().should eq("Plot Location")
        end
        
        it "Hover over a big numbered pin and view the name. Click the pin and view detail box. " do
          page.map_pin_number_2.click()
          page.map_view_detail_box_2.should be_present()
        end
        
        it "Select a different pin, showing the older pin will close. Click the 'More Details' link. Hit 'more details'" do
          page.map_pin_number_1.click()
          page.map_view_detail_box_1.should be_present()
          page.map_view_detail_box_1_close_button.click()
          page.map_pin_number_1.click()
          page.map_view_detail_box_1_more_details_link.click()
          page = HotelDescriptionPage.new(driver, RSpec.configuration.env)
          page.rooms_and_rates_tab.should be_present()
          page.back_to_search_results_link.click()
        end
      end
      
      describe "Hotel: AXPT-911 Map View - As a customer I want to plot a location on the map" do
        it "Remain on search results for Disneyland. From Map View. Click the '?' to view the overlay, and close when finished" do
          page = HotelResultsPage.new(driver, RSpec.configuration.env) 
          page.map_view_tab.click()
          page.plot_location_quest_button.click()
          page.overlay_plot_location_title.text().should eq("Plot Location")
          page.overlay_plot_location_close_button.click()
        end
        
        it "Enter the location '2045 S Harbor Blvd.' and click the Search icon. Click the 'x' to clear selection.
            Enter the location 'Hollywood, Los Angeles, CA'. Enter 'ISEATZ NOLA' to envoke error message" do
            page.plot_location_textbox.send_keys('2045 S Harbor Blvd.')
            page.plot_location_glass_icon.click()
            page.plot_location_delete_marker_icon.should be_present()
            page.plot_location_delete_marker_icon.click()
            page.plot_location_textbox.text().should eq("")
            page.plot_location_textbox.send_keys('Hollywood, Los Angeles, CA')
            page.plot_location_glass_icon.should be_present()
            page.plot_location_glass_icon.click()
            page.plot_location_delete_marker_icon.should be_present()
            page.plot_location_delete_marker_icon.click()
            page.plot_location_textbox.text().should eq("")
            page.plot_location_textbox.send_keys('ISEATZ NOLA')
            page.plot_location_glass_icon.click()
            page.entered_location_alert_error.text().should eq("The entered location doesn't exist. Please verify the location and try again.")
        end
      end
    end      
  end
end