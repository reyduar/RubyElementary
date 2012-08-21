require 'rubygems'
require 'selenium-webdriver'
require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require 'spec_helper'
require_relative '../pages/flight_search_page'
require_relative '../pages/flight_results_page'
require_relative '../db/models/database_model'

describe "Flight: AXPT-2713 - Provide ability to log in a page hosted by AMEX to get PWP information in Air Rate cards" do    
  driver = nil
  page = nil 
  feature = Feature.find_by_name('log in on the rate card') 
  before(:all) do
    browser = RSpec.configuration.browser 
    case browser
      when "firefox"
        driver = Selenium::WebDriver.for :firefox 
      else
      puts "Error: Case statement needs a valid browser string!"
    end    
  end 
  
  after(:all) do
    driver.close()
  end
  it "User has the ability to log in on the rate card. User can see a link to log in on the rate card 
      Login link takes the user to an AMEX hosted login page" do
    page = FlightSearchPage.new(driver, RSpec.configuration.env)
    page.visit()
    page.book_a_flight('basic one way') 
    page.log_in_on_the_rate_card_login_label.should be_present()
    page.log_in_on_the_rate_card_rewards_label.should be_present()
    page.log_in_on_the_rate_card_log_in_button.should be_present()
    page.log_in_on_the_rate_card_login_label.text().should eq(feature.verifications.find_by_name('login to see the price in').text) 
    match_label = page.log_in_on_the_rate_card_rewards_label.text().match( /(.+)Rewards/m ).to_s
    match_label.should eq(feature.verifications.find_by_name('membership rewards points').text)
  end
  it "User is Able to log in the host page Amex" do
    pending("this funcionality is not implemented yet on the page.")
  end
  it "The login is Successful, the user is taken back to the result page With All PWP options" do
    pending("this funcionality is not implemented yet on the page.")
  end
end