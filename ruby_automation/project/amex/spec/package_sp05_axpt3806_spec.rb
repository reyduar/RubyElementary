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
    describe "Package: AXPT-3806 - Provide ability to see the package savings amount" do    
      driver = nil
      page = nil 
      feature = Feature.find_by_name('edit itinerary on dp search feature') 
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
      it "On the DP Air rate card there is an indication of how much was saved in dollars by purchasing air and hotel together as a Package. 
          1. The card says Cost of Flight + Hotel, # nights, # rooms,"do
        page = PackageSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_package("round trip flight rate card package savings amount")
        page = PackageResultsPage.new(driver, RSpec.configuration.env) 
        page.hotel_rate_card_cost_text_labels[0].text().should eq(feature.verifications.find_by_name('cost of flight hotel text').text)
        page.hotel_rate_card_cost_text_labels[1].text().should eq(feature.verifications.find_by_name('nights room text').text)
      end
      
      it "On the DP Air rate card there is an indication of how much was saved in dollars by purchasing air and hotel together as a Package. 
          2. The booked separately amount in dollars,
          3. The package savings in dollars,"do
        page.hotel_rate_card_cost_text_labels.should be_present()
        page.hotel_rate_card_average_per_person.should be_present()
        page.hotel_rate_card_currency_booked_separately.text().should eq(feature.verifications.find_by_name('USD currency').text)
        page.hotel_rate_card_currency_package_savings.text().should eq(feature.verifications.find_by_name('USD currency').text)
      end
      
      it "There is an average price per person on the card. If there is only 1 person the average price per person still appears." do
        # Check average price per person with one travel
        page.hotel_rate_card_average_per_person.should be_present()
        page.hotel_rate_card_average_per_person.text().split(":").first.should eq(feature.verifications.find_by_name('average per person text').text)
        # Check average price per person with two travel
        page.number_of_travelers_link.click()
        page.room_1_adults_combobox.click()
        page.selection_options_adults_1_combobox[1].click()
        page.update_button.click()
        page.hotel_rate_card_average_per_person.should be_present()
        page.hotel_rate_card_average_per_person.text().split(":").first.should eq(feature.verifications.find_by_name('average per person text').text)
      end
      
      it "If there are no package savings then package savings line and booked separately line do not appear, only total cost and average cost per person appear." do
        if (page.hotel_rate_card_currency_package_savings.present? && page.hotel_rate_card_currency_booked_separately.present?)
          page.hotel_rate_card_horizontal_line.should be_present()
        else
          page.should_not be_element_present(page, "hotel rate card horizontal line", "css")
        end
      end
    end  
  end
end