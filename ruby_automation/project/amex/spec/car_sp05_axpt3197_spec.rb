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
    describe "Car: AXPT-3197 - Review Car | As a customer I want to see car rental rules." do
      driver = nil
      car_charges_restrictions_title_feature = Feature.find_by_name('car charges restrictions title')
      car_rental_rule_link_feature = Feature.find_by_name('car rental rule link')
      car_gas_charges_link_feature = Feature.find_by_name('car gas charges link')
      car_additional_costs_link_feature = Feature.find_by_name('car additional costs link')
      car_rental_rule_overlay_feature = Feature.find_by_name('car rental rule overlay')
      car_gas_charges_overlay_feature = Feature.find_by_name('car gas charges overlay')
      car_additional_costs_overlay_feature = Feature.find_by_name('car additional costs overlay')
               		  
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
    
      it "On the car check out page there are several areas where rules are accessed.
          In the sections 'avoid unexpected charges and restrictions' there are 3 links that produce overlays. Each overlay will have text and a dismiss button." do
          #Navigate to search car
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('same location basic w/o discount')
          page.search_cars_button.click()
          page = CarResultsPage.new(driver, RSpec.configuration.env)
          #Click on first car found
          page.select_first_car.click()
          #Validate title's section 
          page = CarSelectedPage.new(driver, RSpec.configuration.env)   
          page.charges_and_restrictions_car_title.text.should eq(car_charges_restrictions_title_feature.verifications.find_by_name('car charges retrictions title text').text)          
          #Validate link Car Rental Rule
          page.car_rental_rules_link.text.should eq(car_rental_rule_link_feature.verifications.find_by_name('car rental rule link title').text)          
          #Validate link Gas Charges
          page.car_gas_charges_link.text.should eq(car_gas_charges_link_feature.verifications.find_by_name('car gas charges link title').text)          
          #Validate link Additional Costs
          page.car_additional_costs_link.text.should eq(car_additional_costs_link_feature.verifications.find_by_name('car additional costs link title').text)          
      end     
      
      it "Car Rental Rules link will produce an overlay that has all of the rules. 
          There overlay itself will have categories of rules as links that take the customer to the rules paragraph specified" do
          #Click on Car Rental Rules link
          page = CarSelectedPage.new(driver, RSpec.configuration.env)
          page.car_rental_rules_link.click()
          #Validate Car Rental Rules overlay opens
          page.car_overlay_rental_rules_title.text.should eq(car_rental_rule_overlay_feature.verifications.find_by_name('car rental rule overlay text title').text.upcase)
          #Click on first link of rules's categories to display context
          page.car_overlay_rental_rules_categories[0].click()          
          #Verify category is expanded
          sleep 5  
          page.car_overlay_rental_rules_categories_expanded[0].present?.should == true                   
          #Click on first link of rule´s categories to contract context
          page.car_overlay_rental_rules_categories[0].click()          
          #Close overlay
          page.car_overlay_rental_rules_close_button.click()          
      end
            
      it "Gas Charges link will produce an overlay that specifically shows the refueling policy of the vendor" do
         #Click on Gas Charges link
         page = CarSelectedPage.new(driver, RSpec.configuration.env)
         page.car_gas_charges_link.click()
         #Validate Gas Charges overlay opens
         page.car_overlay_gas_charges_title.text.should eq(car_gas_charges_overlay_feature.verifications.find_by_name('car gas charges text title').text.upcase)
         #Close overlay         
         page.car_overlay_gas_charges_close_button.click()                             
      end
            
      it "Additional Costs link will produce an overlay that shows additional charges that may apply - extra day, extra hour, miles charges, unit cost, min rental, max rental. 
         Not all of these will apply to each rental but those that do will appear.
         Comment:The script checks prices of additional costs because the items costs is not reliable. The items costs can change in the future." do
         #Click on Additional Costs
         page = CarSelectedPage.new(driver, RSpec.configuration.env)
         page.car_additional_costs_link.click()
         #Validate Additional Costs overlay opens          
         page.car_overlay_aditional_costs_title.text.should eq(car_additional_costs_overlay_feature.verifications.find_by_name('car additional costs text title').text.upcase)                          
         #Validate items values into overlay
         page.car_overlay_aditional_costs_items_values.each {|costs_items_values|
         cost_values = costs_items_values.text.gsub("$","").to_i
         #Validate cost valueas for each item 
          cost_values.should be > 0
         }
         #Close overlay
         page.car_overlay_aditional_costs_button.click()
      end
    end
  end
end