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
require_relative '../db/models/database_model'

describe AMEX_Hotel do
  describe Week_50 do
    describe "Hotel: AXPT-1827 - Display all hotel search results in a selected location" do    
      driver = nil
      page = nil 
      total_hotel_results=0
      hotel_results_matches=0
      
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
      
      it "Hotel property cards appear in the results dynamically as the customer scrolls down the results." do
        page = HotelSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_hotel('basic hotel search')
        page = HotelResultsPage.new(driver, RSpec.configuration.env)
        page.number_of_results.should be_present()
        total_hotel_results = page.number_of_results.text()
        page.results_hotel_cards.each { |hotel_cards|
          if !(hotel_cards.text().empty?)
               hotel_results_matches += 1
          end }
        if (hotel_results_matches >= 25)
            if(total_hotel_results != 25)
              hotel_results_matches.to_s.should_not eq(total_hotel_results)
            end
        end 
        hotel_results_matches=0
      end
      
      it "The Total number of hotels that match search results are displayed." do
        driver.execute_script("scroll(0,15000);")
        sleep 3
        driver.execute_script("scroll(0,15000);")
        if page.my_element_present?(page, "loading more results element", "css")
          page.wait_for_element_not_present(page, "loading more results element", "css")
        end        
        page.results_hotel_cards.each { |hotel_cards|
          if !(hotel_cards.text().empty?)
               hotel_results_matches += 1
          end }
        hotel_results_matches.to_s.should eq(total_hotel_results)
      end
      
      it "Data: Matches copy: -[Number] Matches of [Number]- [Number] Results" do
          pending("this funcionality is not implemented yet on the page.")
      end
      
    end  
  end
end