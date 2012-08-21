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
    describe "Car: AXPT-2512 - Provide a list of preferred car location from a disambiguation list" do
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

      it "Display a list of pick up or drop off locations page so the user can select one of them" do          
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('ambigous city', true)
          page.search_cars_button.click()
          page.ambigous_form.present?
      end

      it "Each entry in the list will have a city, state (US only), country and airport code" do
        def test_line(line)
          us_states = ["AK","AL","AR","AS","AZ","CA","CO","CT","DC","DE",
                       "FL","GA","GU","HI","IA","ID","IL","IN","KS","KY",
                       "LA","MA","MD","ME","MH","MI","MN","MO","MS","MT",
                       "NC","ND","NE","NH","NJ","NM","NV","NY","OH","OK",
                       "OR","PA","PR","PW","RI","SC","SD","TN","TX","UT",
                       "VA","VI","VT","WA","WI","WV","WY"]
          us_states.include? line[1].strip and line[2].include? "US"
        end
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_car('ambigous city', true)
        page.search_cars_button.click()
        page.disambigous_options.present?
        list_items = page.disambigous_options.text.split("\n")
        list_items.each do |c|
          test_line(c.split(",")).should be true
        end
      end
      
      it "The user is required to select a single radio button option for each disambiguation group before clicking the search button." do
        feature = Feature.find_by_name('search car errors')
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_car('ambigous city', true)
        page.search_cars_button.click()
        sleep 1
        page.search_disambiguation_button.click()
        # Check message
        page.fill_required_field_error.text().should == feature.verifications.find_by_name('choose location error').text
        # Check first option
        page.disambiguation_first_choice.click()
        sleep 1
        disambigous_url = driver.current_url
        page.search_disambiguation_button.click()
        # search URL
        driver.current_url.should_not equal(disambigous_url)
      end
      
      it "There is a link at the top of the page to return to search AND
          clicking the link returns the customer to the Car search form AND
          Search field are blank. (Pick up and Drop off) AND
          No search parameters previously entered are persisted" do
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        original_url = driver.current_url
        page.book_a_car('ambigous city', true)
        page.search_cars_button.click()
        # Search and click the back link
        page.link_back_home.click()
        # Check if it returned to the previous page
        driver.current_url.should == original_url
        # Check if search field are blank
        driver.execute_script("return arguments[0].value" , page.pickup_date_textbox).should == ""
        driver.execute_script("return arguments[0].value" , page.dropoff_date_textbox).should == ""
        driver.execute_script("return arguments[0].value" , page.pickup_city_textbox).should == ""
        # Check if "No search parameters previously entered are persisted"
        page.car_ac_combobox.text().should == 'No Preference'
        page.car_rental_company_combobox.text().should == 'No Preference'
        page.car_transmission_combobox.text().should == 'No Preference'
      end
    end  
  end
end
