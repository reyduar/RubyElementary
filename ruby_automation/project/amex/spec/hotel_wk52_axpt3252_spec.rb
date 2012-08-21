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
  describe Week_52 do
    describe "Hotel: AXPT-3252 - Display information in Expanded Hotel property card" do    
      driver = nil
      page = nil
      bridge = Selenium::WebDriver::Navigation   
      feature = Feature.find_by_name('information expanded hotel property card')
      
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
      describe  "A) Users should be able to see the hotel plotted on a map" do
          it "On the hotel card image there is Map icon (magnifying glass)." do
            page = HotelSearchPage.new(driver, RSpec.configuration.env)
            page.visit()
            page.book_a_hotel('basic hotel search')
            page = HotelResultsPage.new(driver, RSpec.configuration.env)
            page.should be_my_element_present(page, "icon magnifying glass", "css")
          end 
          
          it "When the Map icon is clicked the property card expands to show the map below the property image." do          
            page.icon_magnifying_glass.click
            page = nil
            page = HotelResultsPage.new(driver, RSpec.configuration.env)            
            sleep 2
            map_image_element_style = driver.execute_script("return arguments[0].getAttribute('style');" , page.map_image_location_hotel)          
            map_image_element_style.should eq("display: inline;")          
          end
         
          it "To return to the default property card the Hide Hotel Highlights button is clicked." do
            page.hide_hotel_highlights_button.click
            page = nil
            page = HotelResultsPage.new(driver, RSpec.configuration.env)
            map_image_element_style = driver.execute_script("return arguments[0].getAttribute('style');" , page.map_image_location_hotel)          
            map_image_element_style.should eq("display: none;")         
            sleep 2
          end
      end
      
      describe  "B) Users should be able to see expanded property details" do
          it "There is a Show Hotel Highlights button on the hotel property card. If clicked it will expand the card 
              to show several additional data points. The hotel description shows" do             
             show_hotel_highlights_button_style = driver.execute_script("return arguments[0].getElementsByClassName('plus')[0].getAttribute('style');" , page.results_hotel_cards[0])
             show_hotel_highlights_button_style.should eq("display: inline;")                             
             hide_hotel_highlights_button_style = driver.execute_script("return arguments[0].getElementsByClassName('minus')[0].getAttribute('style');" , page.results_hotel_cards[0])
             hide_hotel_highlights_button_style.should eq("display: none;")              
             page.show_hotel_highlights_button.click
             sleep 2
             show_hotel_highlights_button_style = driver.execute_script("return arguments[0].getElementsByClassName('plus')[0].getAttribute('style');" , page.results_hotel_cards[0])
             show_hotel_highlights_button_style.should eq("display: none;")              
             hide_hotel_highlights_button_style = driver.execute_script("return arguments[0].getElementsByClassName('minus')[0].getAttribute('style');" , page.results_hotel_cards[0])
             hide_hotel_highlights_button_style.should eq("display: inline;")                                                      
             hotel_card_description_style = driver.execute_script("return arguments[0].getAttribute('style');" , page.hotel_card_description_div)           
             hotel_card_description_style.should eq("display: block;")  
          end
          
          it "The description, when expanded show text but may not show the entire description. That depends on size constraints of the card. 
              They all have a 'More' link which, when clicked, takes the user to the hotel details page focused on the appropriate tab." do
             page.should be_my_element_present(page, "hotel card more description link", "css") 
             page.hotel_card_more_description_link.click
             page = HotelDescriptionPage.new(driver, RSpec.configuration.env)
             page.should be_my_element_present(page, "back to search results link", "css")
             page.description_tab.text().should eq(feature.verifications.find_by_name('description tab text').text)
             page.back_to_search_results_link.click
          end
       end
    end  
  end
end