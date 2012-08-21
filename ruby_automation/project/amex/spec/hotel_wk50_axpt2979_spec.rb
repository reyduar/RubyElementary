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
    describe "Hotel: AXPT-2979 - Truncate hotel name if too long to fit on hotel card on hotel results page" do    
      driver = nil
      page = nil 
      feature = Feature.find_by_name('truncate hotel name feature') 
      
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
      
      it "On hotel card on hotel results page, Hotel property name displays on single line immediately followed by 'More Details' link.
          If hotel name is too long to display on single line within the card along with 'More Details' link, 
          name should be truncated and followed by ellipsis [...]" do
        page = HotelSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_hotel('basic hotel search')
        page = HotelResultsPage.new(driver, RSpec.configuration.env)
        page.hotel_card_titles.each { |card_title|
          # followed by 'More Details' link
          card_title.text[-12..-1].should eq(feature.verifications.find_by_name('more details link text').text)
          # If hotel name is too long to display on single line, name should be truncated and followed by ellipsis [...]"          
          if (card_title.text.include?('...'))
            slice_text = card_title.text[0..-18]
            slice_text.length.should > 19                           
          end           
          }
      end
    end  
  end
end