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
require_relative '../pages/amex_login_page'
require_relative '../db/models/database_model'

describe AMEX_Hotel do
  describe Week_50 do
    describe "Hotel: AXPT-3253 - Provide ability to log in to see PWP information and to request hotel rate in Property Card" do    
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
      
      it "There is a link that prompts the customer to log in to see PWP information.
          Text before button: Log in to see Price in Membership Rewards Points. Button label: LOG IN" do
        page = HotelSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_hotel('ny hotel search')
        page = HotelResultsPage.new(driver, RSpec.configuration.env)
       
        driver.execute_script("scroll(0,15000);")
        sleep 3
        driver.execute_script("scroll(0,15000);")
        sleep 2
        
        if !(page.results_hotel_cards.empty?)
          login_button_element = driver.execute_script("return arguments[0].getElementsByClassName('login')[0]" , page.results_hotel_cards[0])          
          sleep 2
          if !login_button_element.nil?
            # Button label: LOG IN          
              button_text = login_button_element.text()
              button_text = button_text.strip
              button_text = button_text.upcase
              button_text.should eq("LOG IN")               
            # Text before button: Log in to see Price in Membership Rewards Points
              rewards_text = driver.execute_script("return arguments[0]" , page.results_hotel_cards[0]).text()             
              rewards_text.should be_include("Login to see the price in")         
              rewards_text.should be_include("Membership Rewards") 
              rewards_text.should be_include("Points")                
          else
            view_rates_button_element = driver.execute_script("return arguments[0].getElementsByClassName('_jq-click-to-view-rates')[0]" , page.results_hotel_cards[0])                     
            view_rates_button_element.should_not be_nil?
          end
        end
      end
            
      it "Clicking the link takes the customer to a login page hosted by AMEX" do
        page.hotel_card_login_button.click()       
        page = AmexLoginPage.new(driver, RSpec.configuration.env)              
        page.should be_text_visible("WELCOME TO AMERICAN EXPRESS")
      end       
    end  
  end
end