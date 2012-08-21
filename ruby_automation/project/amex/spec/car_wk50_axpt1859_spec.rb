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
    describe "Car: AXPT-1859 - Air conditioning and Transmission type available in Search form" do       
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

      it "The search form will have the ability to choose air conditioning 
        and transmission type" do       
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.ac_car_select.present?
        page.transmission_car_select.present?
      end   
  
      it "The air conditioning choice will be between no preference, air conditioning or no air conditioning" do       
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        feature = Feature.find_by_name('ac combobox options')
        page.select_option(page.car_ac_combobox, feature.verifications.find_by_name('ac text 1').text)
        page.car_ac_combobox.text().should eq(feature.verifications.find_by_name('ac text 1').text)
        # Note: There is no way to select No sending "No" since there is 
        # an option starting with "No" just before this one. That's why
        # I send arrow_down 3 times to reach that option.
        page.car_ac_combobox.send_keys(:arrow_down)
        page.car_ac_combobox.send_keys(:arrow_down)
        page.car_ac_combobox.send_keys(:arrow_down)
        page.car_ac_combobox.send_keys(:return)
        page.car_ac_combobox.text().should eq(feature.verifications.find_by_name('ac text 2').text)
        page.select_option(page.car_ac_combobox, feature.verifications.find_by_name('ac text 3').text)
        page.car_ac_combobox.text().should eq(feature.verifications.find_by_name('ac text 3').text)
      end   
  
      it "The transmission choice will be between no preference, manual and automatic" do       
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        feature = Feature.find_by_name('transmission combobox options')
        page.select_option(page.car_transmission_combobox, feature.verifications.find_by_name('transmission text N').text)
        page.car_transmission_combobox.text().should eq(feature.verifications.find_by_name('transmission text 1').text)
        page.select_option(page.car_transmission_combobox, feature.verifications.find_by_name('transmission text A').text)
        page.car_transmission_combobox.text().should eq(feature.verifications.find_by_name('transmission text 2').text)
        page.select_option(page.car_transmission_combobox, feature.verifications.find_by_name('transmission text M').text)
        page.car_transmission_combobox.text().should eq(feature.verifications.find_by_name('transmission text 3').text)
      end   
  
      it "The default for both will be no preference" do
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        feature = Feature.find_by_name('ac combobox options')
        page.car_ac_combobox.text().should eq(feature.verifications.find_by_name('ac text 1').text)
        feature = Feature.find_by_name('transmission combobox options')
        page.car_transmission_combobox.text().should eq(feature.verifications.find_by_name('transmission text 1').text)
      end
  
      it "The page should note that these 2 choices are appropriate for searches in rental locations outside the US although there will 
        be no error or failure if a customer enters choices for these on a US rental." do
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        feature = Feature.find_by_name('ac transmission note')
        page.should be_text_present(feature.verifications.find_by_name('ac transmission text').text)
        # TODO: Test a negative.
        page.book_a_car('US car rental with AC option')
        page.search_cars_button.click()
        page = CarResultsPage.new(driver, RSpec.configuration.env)
        feature = Feature.find_by_name('car generic error')
        page.should_not be_text_present(feature.verifications.find_by_name('car results generic error message').text)
        page.start_a_new_search_link.click()
      end

      it "when Search button is selected on form, user is directed to interstitial page" do
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_car('US car rental with AC option')
        page.search_cars_button.click()
        # Turn on interstitial
        driver.execute_script("document.getElementsByClassName('_jq-loading-content')[0].style.display='block'")
        sleep 2
        feature = Feature.find_by_name('interstitial')
        page.should be_text_present(feature.verifications.find_by_name('instertitial message').text)
      end
    end
  end
end
