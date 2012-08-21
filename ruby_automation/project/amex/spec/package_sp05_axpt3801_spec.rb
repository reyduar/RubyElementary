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
    describe "Package: AXPT-3801 - Provide ability to see the number of tickets left for an air itinerary" do    
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
      it "On the Air card on the Search results page, on View all flights and View all hotels may be a # of tickets left alert." do
        page = PackageSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_package("round trip flight 6 adult")
        page = PackageResultsPage.new(driver, RSpec.configuration.env) 
        page.all_hotel_your_flight_rate_card_num_tickets_alert.should be_present()
         alert_tickets = (feature.verifications.find_by_name('only tickets left text').text)   
        alert_tickets.include?(page.all_hotel_your_flight_rate_card_num_tickets_alert.text().split(" ").first).should be true
        page.see_all_flights_button.click()
        page.all_flight_rate_card_num_tickets_alerts.each { |alert| 
          alert_tickets.include?(alert.text().split(" ").first).should be true
        }
      end
      
      it "The alert displays only when the number gets below a certain number.
          The formula for when the alert displays is - if the number of tickets left is less than or equal to the total number of travelers + 4, 
          then the alert displays. OWW will determine when the alert will display and return the number in the shop and reprice responses." do
        page.see_all_flights_button.click()
        # verification with 6 travelers + 4
        number_tickets = /[0-9]/.match(page.all_hotel_your_flight_rate_card_num_tickets_alert.text()).to_s
        number_tickets.to_i.should be <= 10
        page.all_hotel_your_flight_rate_card_num_tickets_alert.should be_present()
        # verification with 5 travelers + 4
        page.number_of_travelers_link.click()
        page.room_1_adults_combobox.click()
        page.selection_options_adults_1_combobox[5].click()
        page.update_button.click()
        if (page.all_hotel_your_flight_rate_card_num_tickets_alert.present?)
            number_tickets = /[0-9]/.match(page.all_hotel_your_flight_rate_card_num_tickets_alert.text()).to_s
            number_tickets.to_i.should be <= 9
            page.all_hotel_your_flight_rate_card_num_tickets_alert.should be_present()
        else
            page.should_not be_element_present(page, "all hotel your flight rate card num tickets alert", "css")
        end
        # verification with 4 travelers + 4
        page.number_of_travelers_link.click()
        page.room_1_adults_combobox.click()
        page.selection_options_adults_1_combobox[4].click()
        page.update_button.click()
        if (page.all_hotel_your_flight_rate_card_num_tickets_alert.present?)
            number_tickets = /[0-9]/.match(page.all_hotel_your_flight_rate_card_num_tickets_alert.text()).to_s
            number_tickets.to_i.should be <= 8
            page.all_hotel_your_flight_rate_card_num_tickets_alert.should be_present()
        else
            page.should_not be_element_present(page, "all hotel your flight rate card num tickets alert", "css")
        end
        # verification with 3 travelers + 4 
        page.number_of_travelers_link.click()
        page.room_1_adults_combobox.click()
        page.selection_options_adults_1_combobox[3].click()
        page.update_button.click()
        if (page.all_hotel_your_flight_rate_card_num_tickets_alert.present?)
            number_tickets = /[0-9]/.match(page.all_hotel_your_flight_rate_card_num_tickets_alert.text()).to_s
            number_tickets.to_i.should be <= 7
            page.all_hotel_your_flight_rate_card_num_tickets_alert.should be_present()
        else
            page.should_not be_element_present(page, "all hotel your flight rate card num tickets alert", "css")
        end
        # verification with 2 travelers + 4
        page.number_of_travelers_link.click()
        page.room_1_adults_combobox.click()
        page.selection_options_adults_1_combobox[2].click()
        page.update_button.click()
        if (page.all_hotel_your_flight_rate_card_num_tickets_alert.present?)
            number_tickets = /[0-9]/.match(page.all_hotel_your_flight_rate_card_num_tickets_alert.text()).to_s
            number_tickets.to_i.should be <= 6
            page.all_hotel_your_flight_rate_card_num_tickets_alert.should be_present()
        else
            page.should_not be_element_present(page, "all hotel your flight rate card num tickets alert", "css")
        end
        # verification with 1 travelers + 4
        page.number_of_travelers_link.click()
        page.room_1_adults_combobox.click()
        page.selection_options_adults_1_combobox[1].click()
        page.update_button.click()
        if (page.all_hotel_your_flight_rate_card_num_tickets_alert.present?)
            number_tickets = /[0-9]/.match(page.all_hotel_your_flight_rate_card_num_tickets_alert.text()).to_s
            number_tickets.to_i.should be <= 5
            page.all_hotel_your_flight_rate_card_num_tickets_alert.should be_present()
        else
            page.should_not be_element_present(page, "all hotel your flight rate card num tickets alert", "css")
        end
      end
    end  
  end
end