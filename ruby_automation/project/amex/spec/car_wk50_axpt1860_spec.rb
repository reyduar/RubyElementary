require 'rubygems'
require 'selenium-webdriver'
require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require 'spec_helper'
require_relative '../pages/car_search_page'
require_relative '../pages/car_results_page'
require_relative '../db/models/database_model'

describe AMEX_Car do
  describe Week_50 do
    describe "Car: AXPT-1860 - Discount Code Option in Search form" do       
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
            
      it "The search form will have the ability to enter a discount code 
          for a single car rental vendor" do       
          feature = Feature.find_by_name('discount text')
          
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.should be_text_present(feature.verifications.find_by_name('discount title text').text)
      end   
      
      it "Entering a discount code is optional" do       
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('same location basic w/o discount')
          page.search_cars_button.click()
          page = CarResultsPage.new(driver, RSpec.configuration.env)
          page.should_not be_search_error_messages_present()
      end   

      it "There will be a drop down to choose the vendor to which the 
          discount code belongs. If a code is used a choice of vendor 
          is required" do
          feature = Feature.find_by_name('discount text')
          
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          #Check if the drop down is present      
          page.car_rental_company_combobox.present?
          #Check if code entry box is present only when a vendor is choosen
          page.choose_a_vendor(feature.verifications.find_by_name('Company 1').text)
          sleep 1
          page.discount_code_textbox.present?
      end   

      it "Drop Down Content: No Preference, Ace, Advantage Rent A Car,
          Avis, Budget, Economy Rent A Car, Dollar Rent A Car, Europcar,
          EZ Rent A Car, Fox Rent A Car, Hertz, Payless, Sixt Rent A Car,
          Thrifty Car Rental" do
          
          # Note: missing vendors: Economy Rent A Car, Europcar
          vendors = ["No Preference", "Ace", "Advantage Rent A Car", 
                     "Avis", "Budget", "Dollar Rent A Car",
                     "EZ Rent A Car", "Economy Rent A Car", "Europcar",
                     "Fox Rent A Car", "Hertz", "Payless", 
                     "Sixt Rent A Car", "Thrifty Car Rental"]
                     
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          #Check if all vendors are present
          vendors.each do |n|
            page.select_option(page.car_rental_company_combobox, n)
            page.car_rental_company_combobox.text().should eq(n)
          end
      end

      it "There will be a text entry field that allows the entry of a 
          discount code. There will be no validation on the code except 
          that there is one if a vendor is chosen from the drop down." do
          feature = Feature.find_by_name('discount text')
          
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          # Read current value in the dropdown, if "No Preference", the
          # textcode should not be present. 
          if page.car_rental_company_combobox.text() == 'No Preference'
            page.should_not be_element_present(page,'discount code textbox','id')
          end

          page.select_option(page.car_rental_company_combobox, feature.verifications.find_by_name('Company 1').text)
          #Check for discount textbox
          sleep 1
          page.discount_code_textbox.present?
      end      

      it "If a vendor and code are entered and a search conducted the 
          results will include all car vendors. The vendor with the 
          discount will be tagged as having a discount, but all vendors 
          will show." do
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('NOLA and AVIS discount')
          page.search_cars_button.click()
          # Look for car with discount, that is, invalid class.
          page = CarResultsPage.new(driver, RSpec.configuration.env)
          page.should be_element_present(page, 'car results invalid price', 'css')
          # search for another vendor.
          if page.car_results_companies.length > 1
            true
          else
            false
          end
      end  
    end  
  end
end