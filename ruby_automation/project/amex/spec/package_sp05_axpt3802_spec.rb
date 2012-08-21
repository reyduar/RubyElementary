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
  describe Sprint_05 do
    describe "Package: AXPT-3802 - Provide ability to to see alerts on the expanded Air rate card" do    
      driver = nil
      page = nil 
      feature = Feature.find_by_name('on air rate card alert') 
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
      it "For each slice of the journey there may display a variety of different alerts to the user on the expanded rate card.
          1. For any connection that changes airports a Change of Airport alert displays.
          2. For any leg that is subject to approval, a Subject to Government Approval alert displays."do
        page = PackageSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_package("round trip flight rate card alert")
        page = PackageResultsPage.new(driver, RSpec.configuration.env) 
        page.roundtrip_flight_details_link.click()
        alert_verification = (feature.verifications.find_by_name('dp flight card alert subject to government approval').text)   
        # Check displayed options are Change Planes or Subject to Government Approval 
        page.air_rate_card_slice_alerts_connection.each { |alert| 
        alert.text().should eq(feature.verifications.find_by_name('dp flight card alert change planes').text)
        if(alert.text().eql?(alert_verification))
            alert.should eq(feature.verifications.find_by_name('dp flight card alert subject to government approval').text)
        end
        }
      end
    end  
  end
end