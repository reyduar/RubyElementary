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
  describe Week_52 do
    describe "Package: AXPT-3310 - Guest users should be prompted to log in to see PWP" do    
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
        page = PackageSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_package("one adult at least in each room")
        page = PackageResultsPage.new(driver, RSpec.configuration.env)        
        driver.execute_script("scroll(0,15000);")
        sleep 3
        driver.execute_script("scroll(0,15000);")
        page.results_package_cards.each { |package_card|
          # Text before button: Log in to see Price in Membership Rewards Points
          rewards_text = driver.execute_script("return arguments[0].getElementsByClassName('mem-rewards-text')[0]" , package_card).text()  
          rewards_text.should be_include("Login to see the price in")                  
          # Button label: LOG IN
          button_element = driver.execute_script("return arguments[0].getElementsByClassName('login')[0]" , package_card)          
          button_text = button_element.text()
          button_text = button_text.strip
          button_text = button_text.upcase
          button_text.should eq("LOG IN")
          }
      end
      
      it "For any guest customer, the PWP amount does not display." do
        pending("this funcionality is not implemented yet on the page.")
      end      
    end  
  end
end