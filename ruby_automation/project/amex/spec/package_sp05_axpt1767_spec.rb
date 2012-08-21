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
    describe "Package: AXPT-1767 - DP Air Rate Card | As a customer I want to be able to see all the details of a flight itinerary on the expanded rate card" do    
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
      it "On the rate card for each journey should be a single link to View Flight Details" do
        page = PackageSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_package("basic round trip")
        page = PackageResultsPage.new(driver, RSpec.configuration.env) 
        page.roundtrip_flight_details_link.should be_present()
        page.roundtrip_flight_details_link.text().should eq(feature.verifications.find_by_name('view roundtrip flight details text').text)  
      end
      
      it "Clicking on the link will expand the information available for all legs of the journey" do
        page.roundtrip_flight_details_link.click()
        page.roundtrip_flight_details_link.text().should eq(feature.verifications.find_by_name('hide roundtrip flight details text').text)  
      end 
      
      it "The additional information available in view details will be: 2.Each leg's equipment, if available." do
        if (page.my_element_present?(page, "air rate card departure slice alerts legs equipment", "css")) 
          page.air_rate_card_departure_slice_alerts_legs_equipment.should be_present()
        end 
        if (page.my_element_present?(page, "air rate card return slice alerts legs equipment", "css")) 
          page.should be_my_element_present(page, "air rate card return slice alerts legs equipment", "css")
        end  
      end
      
      it "The additional information available in view details will be: 3.Each legs food and beverage service, if available." do      
        if (page.my_element_present?(page, "air rate card departure slice alerts legs food beverage service", "css"))       
          page.air_rate_card_departure_slice_alerts_legs_food_beverage_service.should be_present()
        end 
        if (page.my_element_present?(page, "air rate card return slice alerts legs food beverage service", "css"))         
          page.air_rate_card_return_slice_alerts_legs_food_beverage_service.should be_present()
        end 
      end
      
      it "The additional information available in view details will be: 4.The departure and arrival time detail for each connection 
          in each slice." do
        page.air_rate_card_departure_slice_alerts_time.should be_present()
        page.air_rate_card_return_slice_alerts_time.should be_present()
      end
      
      it "The additional information available in view details will be: 5.The departure and arrival city name and airport code for each 
          connection in the slice." do
        page.air_rate_card_departure_slice_alerts_city_name_airport_code.should be_present()
        page.air_rate_card_return_slice_alerts_city_name_airport_code.should be_present()
      end
      
      it "The additional information available in view details will be: 8.The mileage for each flight, if available." do
        if (page.my_element_present?(page, "air rate card departure slice alerts mileage", "css"))               
          page.air_rate_card_departure_slice_alerts_mileage.should be_present()
        end 
        if (page.my_element_present?(page, "air rate card return slice alerts mileage", "css"))    
          page.air_rate_card_return_slice_alerts_mileage.should be_present()
        end 
      end
      
      it "The additional information available in view details will be: 9.If the slice is a multi-carrier itin on expanding the card each 
          individual carrier and logo will display, not the multi-carrier logo." do
        page.air_rate_card_return_slice_logo_1_img.should be_present()
        page.air_rate_card_departure_slice_logo_1_img.should be_present()
        # Check is multi-carrier
        segment=0
        page.air_rate_card_segments_with_logo.each_with_index { |i,index|segment=index}
        if(segment >= 8)
          page.air_rate_card_departure_slice_logo_2_img.should be_present()
          page.air_rate_card_return_slice_logo_2_img.should be_present()
        end
      end
      
      it "The additional information available in view details will be: 10.For each slice of the journey the cabin class is displayed. 
          Options are Economy, Business, First." do
        page.air_rate_card_departure_slice_alerts_cabin_class.should be_present()
        page.air_rate_card_return_slice_alerts_cabin_class.should be_present()
        # Check displayed options are Economy, Business, First
        economy_class = (feature.verifications.find_by_name('cabin class alert text 1').text)   
        business_class = (feature.verifications.find_by_name('cabin class alert text 2').text)   
        page.air_rate_card_departure_slice_alerts_cabin_class.each_with_index { |cabin_class,index|
        if(cabin_class.text().eql?(economy_class))
          page.air_rate_card_departure_slice_alerts_cabin_class[index].text().should eq(feature.verifications.find_by_name('cabin class alert text 1').text)
        else
          if(cabin_class.text().eql?(business_class))
            page.air_rate_card_departure_slice_alerts_cabin_class[index].text().should eq(feature.verifications.find_by_name('cabin class alert text 2').text)
          else
            page.air_rate_card_departure_slice_alerts_cabin_class[index].text().should eq(feature.verifications.find_by_name('cabin class alert text 3').text)
          end
        end
        }
        page.air_rate_card_return_slice_alerts_cabin_class.each_with_index { |cabin_class,index|
        if(cabin_class.text().eql?(economy_class))
          page.air_rate_card_return_slice_alerts_cabin_class[index].text().should eq(feature.verifications.find_by_name('cabin class alert text 1').text)
        else
          if(cabin_class.text().eql?(business_class))
            page.air_rate_card_return_slice_alerts_cabin_class[index].text().should eq(feature.verifications.find_by_name('cabin class alert text 2').text)
          else
            page.air_rate_card_return_slice_alerts_cabin_class[index].text().should eq(feature.verifications.find_by_name('cabin class alert text 3').text)
          end
        end
         }
      end
      
      it "The View Flight Details link, once clicked, changes into a Hide Flight Details link so the details can be collapsed the the customer is finished." do
        page.roundtrip_flight_details_link.click()
        page.roundtrip_flight_details_link.text().should eq(feature.verifications.find_by_name('view roundtrip flight details text').text) 
      end 
    end  
  end
end