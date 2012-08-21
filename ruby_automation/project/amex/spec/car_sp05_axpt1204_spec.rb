require 'selenium-webdriver'
require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require 'spec_helper'
require_relative '../pages/car_search_page'
require_relative '../pages/car_results_page'
require_relative '../pages/car_selected_page'
require_relative '../db/models/database_model'

describe AMEX_Car do
  describe Sprint_05 do
    describe "Car: AXPT-1204 - Review Car | As a customer I want to see a breakdown of taxes and fees" do    
      driver = nil
      page = nil 
      taxes_fees_value = nil
      taxes_and_fees_currency_sing = nil
      total_taxes_and_fees = 0
      
      car_taxes_and_fees_texts_feature = Feature.find_by_name('car taxes and fees texts')
      
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
      
      it "Within the Review Car section the total of taxes and fees will display." do          
          #Navigate to search car
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('same location basic w/o discount')
          page.search_cars_button.click()
          page = CarResultsPage.new(driver, RSpec.configuration.env)          
          #Click on first car button found
          page.select_first_car.click()
          #Validate link 
          page = CarSelectedPage.new(driver, RSpec.configuration.env)             
          #Take currency sign
          taxes_and_fees_currency_sing = page.car_taxes_and_fees_currency_sign.text        
          #Take value taxes and fees
          taxes_fees_value = page.car_taxes_fees_number.text.to_f          
          page.should be_numeric(taxes_fees_value)
      end    
          
      it "It will be an expandable link that when clicked will show all fees and taxes broken down. May be in non USD
          Comment:The script checks values of each taxes and fees because the items (taxes and fees) are not reliable, they can change depending on chosen car." do
          #Validate link name
          page.tax_fee_link.text.should eq (car_taxes_and_fees_texts_feature.verifications.find_by_name('taxes and fees title').text) 
          #Click on link           
          page.tax_fee_link.click()
          #Verify overlay Taxes and Fees opens         
          page.tax_fee_dialog.text.should eq (car_taxes_and_fees_texts_feature.verifications.find_by_name('taxes and fees title').text.upcase)
          #Sum values for each tax and fee          
          page.car_taxes_and_fees_numbers.each {|values|   
            #Take currency sign
            items_currency_sign = values.text.split(//, 2).first 
            #Take values                      
            total_taxes_and_fees = total_taxes_and_fees + values.text.split(//, 2).last.to_f         
            #Validate currency sign          
            taxes_and_fees_currency_sing.should eq items_currency_sign
          }     
          #Validate total taxes and fees 
          taxes_fees_value.should eq total_taxes_and_fees.round(2)
          sleep 2          
      end      
      
      it "There will be an option to collapse the taxes and fees section when done" do    
         #Close overlay
         page.tax_fee_dialog_close_icon.click()                             
      end                
    end
  end
end  
