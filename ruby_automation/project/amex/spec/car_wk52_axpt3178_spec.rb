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
  describe Week_52 do
    describe "Car: AXPT-3178 - Provide Promotional Information in the Interstitial page" do       
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

      it 'The interstitial page always show the text "Get more when you book with American Express"' do       
        feature = Feature.find_by_name('search cars interstitial')
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        # Turn on interstitial
        driver.execute_script("document.getElementsByClassName('_jq-loading-content')[0].style.display='block'")
        sleep 2
        # Check for text in the interstitial
        page.text_visible?(feature.verifications.find_by_name('interstitial main text').text)==true
      end   
      
      it 'The following three items appears to support the text message of the interstitial page' do
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        # Turn on interstitial
        driver.execute_script("document.getElementsByClassName('_jq-loading-content')[0].style.display='block'")
        sleep 2
        page.promo_get_points.present?
        page.promo_pay_points.present?
        page.promo_competitive_rates.present?
      end
    end
  end
end
