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
require_relative '../pages/package_hotel_details_page'
require_relative '../db/models/database_model'

describe AMEX_Package do
  describe Sprint_06 do
    driver = nil
    page = nil   
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
    
    describe "Package: AXPT-3079 - DP Hotel Details - As a customer I want to see summary of the hotel I've selected" do    
      hotel_name_1 = "AFFINIA"
      hotel_name_2 = "WELLINGTON"
      hotel_name_selected = nil
        
      it "Search: SFO to JFK 4/22-4/29, 1 room, 2 Adults." do
        page = PackageSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.enter_airport(page.departure_city_textbox,"SFO") 
        page.enter_airport(page.arrival_city_textbox,"JFK")
        page.select_option(page.rooms_combobox, "1")       
        page.select_option(page.adults_combobox(1), "2")       
        page.departure_date_textbox.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
        page.return_date_textbox.send_keys(eval('(Time.now + (9 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
        page.search_button.click()
        page = PackageResultsPage.new(driver, RSpec.configuration.env) 
        page.first_dp_hotel_card.should be_present()
      end
            
      it "Select the hotel: Affinia or Wellington" do
        driver.execute_script("scroll(0,15000);")
        sleep 3
        driver.execute_script("scroll(0,15000);")        
        page.results_hotel_names.each_with_index { |title_name, index|
          if !(title_name.text().empty?)
            if (title_name.text().upcase.include?(hotel_name_1))
              hotel_name_selected = hotel_name_1
              page.more_details_links[index].click()
              break 
            end            
            if (title_name.text().upcase.include?(hotel_name_2))
              hotel_name_selected = hotel_name_2
              page.more_details_links[index].click()
              break 
            end              
          end}           
      end      
      
      it "Summary will include: hotel name" do
        page = PackageHotelDetailsPage.new(driver, RSpec.configuration.env)
        page.package_hotel_details_hotel_name.text.upcase.should be_include(hotel_name_selected)                         
      end           
            
      it "Summary will include: full address" do  
        page.package_hotel_details_address.text.should_not be_empty()       
      end       

      it "Summary will include: check in and check out dates" do
        page.package_hotel_details_check_dates[0].text.should be_include("/") 
        page.package_hotel_details_check_dates[1].text.should be_include("to") 
        page.package_hotel_details_check_dates[2].text.should be_include("/")    
      end   

      it "Summary will include: number of guest and rooms" do  
        page.package_hotel_details_guests_and_rooms[0].text.should eq("2 Guests") 
        page.package_hotel_details_guests_and_rooms[1].text.should eq("1 Room")       
      end  

      it "Summary will include: star rating should appear with the link '?'" do  
        page.package_hotel_details_stars_container.should be_present()
        page.package_hotel_details_stars_help_link.should be_present()
      end  

      it "Summary will include: link 'start a new search'" do 
        page.package_hotel_details_start_a_new_search_link.should be_present() 
        page.package_hotel_details_start_a_new_search_link.click()
        page = PackageSearchPage.new(driver, RSpec.configuration.env)
        page.departure_city_textbox.should be_present()  
        driver.navigate.back() 
        page = PackageHotelDetailsPage.new(driver, RSpec.configuration.env)
        page.package_hotel_details_hotel_name.text.upcase.should be_include(hotel_name_selected)         
      end  
    end  
        
    describe "Package: AXPT-1033 - DP Air Rate Card - As a customer I want to see the lowest rate for the air + hotel package" do            
      it "Remain on search for SFO to JFK in hotel summary. From Wellington or Affinia details, Rooms & Rates. Hit select this hotel/modify flight" do
        page.package_hotel_details_first_select_this_hotel_button.click()
      end
      
      it "Rate card will include: Cost of Flight + Hotel: # night/s, # room/s" do 
        page = PackageResultsPage.new(driver, RSpec.configuration.env) 
        page.first_dp_hotel_card.should be_present()      
        page.hotel_card_flight_and_hotel_costs_upper_labels[0].text.should eq("Cost of Flight + Hotel:")
        page.hotel_card_flight_and_hotel_costs_upper_labels[1].text.should eq("6nights,1room")
        page.hotel_card_flight_and_hotel_costs_upper_labels[2].text.should eq("(includes taxes & fees)")        
      end       
      
      
      
# Rate card will include: Cost of Flight + Hotel: # night/s, # room/s
 # - ""Total Cost"" and the price 
 # - ""Avarage Per Person:"" and the price
 # - ""Booked Separately""
 # - ""Package Saving""      
      


      
      
      
    end
    
    
    
  end
end