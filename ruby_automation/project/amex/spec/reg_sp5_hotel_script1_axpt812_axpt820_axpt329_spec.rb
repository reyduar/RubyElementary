require 'rubygems'
require 'selenium-webdriver'
require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require 'spec_helper'
require_relative '../pages/hotel_search_page'
require_relative '../pages/hotel_results_page'
require_relative '../pages/hotel_disambiguation_page'
require_relative '../db/models/database_model'

describe AMEX_Hotel do
  describe Sprint_05 do
    describe "Script_01" do    
      driver = nil
      page = nil 
      feature = Feature.find_by_name('search hotel in a variety of ways') 
      
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
      describe "AXPT-812: Hotel Search - As a customer I want the ability to search for hotels in a variety of ways" do
        it "Searching by address radio button. To envoke error of no results found use: Country: US Street: 230 Fort Juckson City: Buras, 70037" do
          page = HotelSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.by_address_option.click()
          # input address
          page.search_street_address_textbox.send_keys(feature.verifications.find_by_name('address 1 text').text)
          # input city
          page.search_city_textbox.send_keys(feature.verifications.find_by_name('city 1 text').text)
          # select state
          page.search_state_combobox.click()
          page.search_state_combobox.send_keys(:arrow_down)
          page.search_state_combobox.send_keys(:return)
          # input zip/Postal code
          page.search_zip_postal_code_textbox.send_keys(feature.verifications.find_by_name('zip postal code 1 text').text)
          page.check_in_date_textbox.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          page.check_out_date_textbox.send_keys(eval('(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          page.search_hotels_button.click()
          page.search_error_messages[0].text().should eq(feature.verifications.find_by_name('returned no results error message text').text)
        end 
        
        it "To envoke field errors: leave out city/zip/wrong state" do
          page = nil
          page = HotelSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.by_address_option.click()
          page.search_hotels_button.click()
          # verification field errors
          page.search_error_messages[0].text().should eq(feature.verifications.find_by_name('please specify a city error message text').text)
          page.search_error_messages[1].text().should eq(feature.verifications.find_by_name('wrong state error message text').text)
          page.search_error_messages[2].text().should eq(feature.verifications.find_by_name('please select a check-in date error message text').text)
          page.search_error_messages[3].text().should eq(feature.verifications.find_by_name('please select a check-out date error message text').text)
        end 
        
        it "Use: 186 Market St, Newark, NJ 07103 Select dates (3/25-3/30) and '2' number of guests Hit Search Hotels" do
          # input address
          page.search_street_address_textbox.send_keys(feature.verifications.find_by_name('address 2 text').text)
          # input city
          page.search_city_textbox.send_keys(feature.verifications.find_by_name('city 2 text').text)
          # select state
          page.search_state_combobox.click()
          page.search_state_combobox.send_keys(:arrow_down)
          page.search_state_combobox.send_keys(:return)
          # input zip/Postal code
          page.search_zip_postal_code_textbox.send_keys(feature.verifications.find_by_name('zip postal code 2 text').text)
          page.check_in_date_textbox.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          page.check_out_date_textbox.send_keys(eval('(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          page.search_hotels_button.click()
          page = HotelResultsPage.new(driver, RSpec.configuration.env) 
          page.results_hotel_cards[0].should be_present()
          page.start_a_new_search_link.text().should eq(feature.verifications.find_by_name('start a new search link text').text)
        end
        
        it "After getting results click 'Start new Search'. Select Search by city or landmark Use: Las Vegas (city name) " do
          page.start_a_new_search_link.click()
          page = HotelSearchPage.new(driver, RSpec.configuration.env)
          page.by_city_or_landmark_option.click()
          page.destination_textbox.send_keys(feature.verifications.find_by_name('destination text').text)
          page.destination_textbox.send_keys(:arrow_down)
          page.destination_textbox.send_keys(:tab)
          page.check_in_date_textbox.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          page.check_out_date_textbox.send_keys(eval('(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          page.search_hotels_button.click()
          page = HotelResultsPage.new(driver, RSpec.configuration.env) 
          page.results_hotel_cards[0].should be_present()
          page.start_a_new_search_link.click()
        end
        
        it "To envoke additional disambiguation results:" do
          page = HotelSearchPage.new(driver, RSpec.configuration.env)
          page.destination_textbox.send_keys(feature.verifications.find_by_name('edit hotel destination ambiguous text').text)
          page.check_in_date_textbox.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          page.check_out_date_textbox.send_keys(eval('(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          page.search_hotels_button.click  
          page = HotelDisambiguationPage.new(driver, RSpec.configuration.env)           
          page.disambiguation_page_title.text().should eq(feature.verifications.find_by_name('disambiguation page title').text)
          page.disambiguation_first_selection_in_all_options[0].click()
          page.search_hotels_button.click()
          page = HotelResultsPage.new(driver, RSpec.configuration.env) 
          page.results_hotel_cards[0].should be_present()
        end 
      end 
      
      describe "AXPT-820: Hotel Search Summary - As a customer I want to see my destination in edit mode" do
        it "Remain on Search Results page for McCarran Airport In address/landmark edit field type Henderson, NV. Hit Update" do
          destination_hotel_search = driver.execute_script("return arguments[0].value" , page.destination_textbox)
          driver.execute_script("arguments[0].value = ''" , page.destination_textbox)    
          page.destination_textbox.send_keys(feature.verifications.find_by_name('edit hotel destination text').text)
          page.destination_textbox.send_keys(:arrow_down) 
          page.destination_textbox.send_keys(:tab) 
          page.update_button.click()
          destination_text_value = driver.execute_script("return arguments[0].value" , page.destination_textbox)
          destination_text_value.should_not eq(destination_hotel_search)
          destination_text_value.should eq(feature.verifications.find_by_name('edit hotel destination text').text)
        end 
      end
      
      describe "AXPT-329: Interstitial - As a marketer I want to add pomotional information to the interstitial" do
        it "Remain on Search Results page for Henderson, NV. Hit Update" do
          page.update_button.click()
          # Turn on interstitial
          driver.execute_script("document.getElementsByClassName('_jq-loading-content')[0].style.display='block'")
          sleep 2
          page.interstitial_main_text_label.text().should eq(feature.verifications.find_by_name('interstitial main text').text)
          page.promo_get_points.present?
          page.promo_pay_points.present?
          page.promo_competitive_rates.present?
        end
      end 
    end  
  end
end
