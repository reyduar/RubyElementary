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
    describe "Hotel: AXPT-3074 - Display strikethrough rate only for hotels with promotions that lower nightly rate from stardard rate" do    
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
      
      it "The strikethrough rate for hotels only shows it if the hotel has a promotion that lowers the nightly rate from the standard rate." do
        page = HotelSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_hotel('ny hotel search')
        page = HotelResultsPage.new(driver, RSpec.configuration.env)
       
        driver.execute_script("scroll(0,15000);")
        sleep 3
        driver.execute_script("scroll(0,15000);")
        
        page.results_hotel_cards.each { |hotel_card|
        old_price_element = driver.execute_script("return arguments[0].getElementsByClassName('old-price')[0]",hotel_card)
        if !(old_price_element.nil?)          
          old_price = old_price_element.text.gsub("$", "").to_i()         
          big_price = driver.execute_script("return arguments[0].getElementsByClassName('number')[0]",hotel_card).text.to_i() 
          big_price.should <= old_price
        end}
      end
    end  
  end
end