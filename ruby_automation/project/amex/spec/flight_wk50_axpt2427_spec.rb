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

describe "Flight: AXPT-2427 - Display flight informational alerts on air rate card" do    
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
  
  after(:all) do
    driver.close()
  end
  #Step 1 - Alert: "+# Day" or "-# Day" message:
  it "If the slice contains flight(s) where the day will change in the course of the flight/layover, display alert 
     '+# Day or -# Day' message (with # being the number of days difference) above the destination city" do
    page = FlightSearchPage.new(driver, RSpec.configuration.env)
    page.visit()
    page.book_a_flight('basic multi city')   
    page.on_air_rate_card_alert_day_label.should be_present()
    page.on_air_rate_card_alert_day_label.text().should eq(feature.verifications.find_by_name('red card alert day').text)  
  end
  #Step 2 - Alert: "Change Planes"
   it "If the slice is a connection or change of gauge, display alert 'Change Planes' message following the layover duration 
      if applies connection is multiple flights with different flight numbers from origin to the destination change of gauge 
      is a flight has the same flight number from origin to destination but there is a change of aircraft somewhere." do
    page = FlightSearchPage.new(driver, RSpec.configuration.env)
    page.visit()
    page.book_a_flight('basic round trip') 
    page.on_air_rate_card_alert_change_planes_label.should be_present()
    page.on_air_rate_card_alert_change_planes_label.text().should eq(feature.verifications.find_by_name('red card alert change planes').text)  
  end
  #Step 3 - Alert: "Subject to Government Approval"
  it "If the slice contains a flight that is still pending government approval, display alert 'Subject to Government Approval' 
      message following the layover duration if applies If both 'Change Planes' and 'Subject to Government Approval' 
      applies to the same slice, display 'Change Planes' first followed by 'Subject to Government Approval'" do
    page = FlightSearchPage.new(driver, RSpec.configuration.env)
    page.visit()
    page.book_a_flight('basic round trip rate card alert') 
    page.on_air_rate_card_alert_subject_to_government_approval_label.should be_present()
    page.on_air_rate_card_alert_subject_to_government_approval_label.each { |iterator_label| 
    if !(iterator_label.text().empty?)
      iterator_label.text.should eq(feature.verifications.find_by_name('red card alert subject to government approval').text)
    end
    }
  end
 
end
