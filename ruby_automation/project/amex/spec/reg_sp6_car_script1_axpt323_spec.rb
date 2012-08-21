require 'selenium-webdriver'
require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require 'spec_helper'
require_relative '../pages/car_search_page'
require_relative '../pages/car_results_page'
require_relative '../pages/amex_login_page'
require_relative '../db/models/database_model'

describe AMEX_Car do
  describe Sprint_06 do
    describe Script_01 do    
      describe "Car: AXPT-323 - IZ-OWW_Tested - Account Summary - As a guest customer I want to see the option to log in on all pages." do  
        page = nil 
        driver = nil
        
        amex_login_texts = Feature.find_by_name('amex login texts')
        
        before(:all) do
          browser = RSpec.configuration.browser
          case browser
          when "firefox"
            driver = Selenium::WebDriver.for :firefox
          else
            puts "Error: Case statment needs a valid browser string!"
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

        it "Search for cars any market/date/traveler." do
            page = CarSearchPage.new(driver, RSpec.configuration.env)
            page.visit()
            page.book_a_car('same location basic w/o discount')            
            page.search_cars_button.click() 
            page = CarResultsPage.new(driver, RSpec.configuration.env)                    
            page.should be_element_present(page, 'car matrix', 'css')                            
        end       

        it "On the search results page click the log in on the car results page." do                        
            page.car_loggin_button.click()
            page = AmexLoginPage.new(driver, RSpec.configuration.env)
            page.amex_login_welcome_title.text().should eq(amex_login_texts.verifications.find_by_name('login welcome title').text)             
        end        

        it "Verify that the user is brought to the amex hosted log in page." do         
            page.amex_login_form_title.text().should eq(amex_login_texts.verifications.find_by_name('login form title').text)             
        end        
      end
    end
  end
end  

