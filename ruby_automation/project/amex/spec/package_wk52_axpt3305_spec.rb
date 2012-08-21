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
  describe Week_52 do
    driver = nil
    page = nil    
    feature = Feature.find_by_name('dp hotel property card') 
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
      driver.manage.delete_all_cookies()
      if example.failed?
        driver.save_screenshot("logs/screenshot_#{Time.now.strftime('%Y%m%d-%H%M%S')}.png")
      end
    end        
    
    after(:all) do
      driver.quit()
    end      
  
    describe "Package: AXPT-3305 - DP Hotel Property Card | Display Hotel name, lowest rate for air + hotel package and savings amount" do 
      describe "A) Customer should be able to see Hotel Name in property card" do 
        it "On the hotel property card, the Hotel name is displayed.
            If Hotel name exceeds 25 characters, it should be truncated and present an ellipsis at the end of the line.
            A 'More Details' link appears next to the name that will eventually link to Hotel Details page." do
          page = PackageSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_package("one adult at least in each room")
          page = PackageResultsPage.new(driver, RSpec.configuration.env)        
          page.hotel_card_titles.each { |card_title|
          # If Hotel name exceeds 25 characters, it should be truncated and present an ellipsis at the end of the line.         
          if (card_title.text.include?('...'))
            slice_text = card_title.text[0..-4]
            slice_text.length.should > 21                           
          end           
          }
          # A 'More Details' link appears next to the name          
          page.more_details_links.each { |more_details_link|
          more_details_link.text[-12..-1].should eq(feature.verifications.find_by_name('more details link text').text)         
          }  
          # that will eventually link to Hotel Details page 
          page.more_details_links[0].click()
          page = PackageHotelDetailsPage.new(driver, RSpec.configuration.env)
          page.dp_room_details_card_titles.each { |dp_room_details_card_title|
            dp_room_details_card_title.text.strip.should eq("Room Details")
          }                    
        end       
      end
    end      
    
    describe "B) Customer should be able to see the lowest rate for the air + hotel package" do      
    
      it "The property card has Total Cost for the package and shows the total cost for a single package
          (including taxes and fees) in US Dollars." do                            
          page = PackageSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_package("one adult at least in each room")
          page = PackageResultsPage.new(driver, RSpec.configuration.env)          
          page.rate_card_prices.each {|card_price| page.should be_numeric(card_price.text.gsub(",", "").strip)}
      end          
    end 

    describe "C) Customer should be able to see the package savings amount" do                      
      it "On each hotel card in the DP path, there is an indication of how much the package would cost if booked separately 
          and how much is saved in dollars by purchasing air and hotel together as a package." do
          page = PackageSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_package("one adult at least in each room")
          page = PackageResultsPage.new(driver, RSpec.configuration.env)          
          page.booked_separately_prices.each {|price| page.should be_numeric(price.text.gsub(",", "").strip)}          
          page.package_savings_prices.each {|price| page.should be_numeric(price.text.gsub(",", "").strip)}           
      end    
      
      it "The booked separately and savings amount are not represented in MR points." do
        page.booked_separately_currencies.each {|currency| currency.text.strip.should eq("$")}          
        page.package_savings_currencies.each {|currency| currency.text.strip.should eq("$")}       
      end
    end                     
  end
end