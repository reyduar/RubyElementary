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
  describe Week_50 do
      driver = nil
      page = nil
      feature = Feature.find_by_name('package search errors')
      feature_travel_times = Feature.find_by_name('package search travel times')
      verifications = nil
      
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
  
    describe "Package: AXPT-2605 - Provide date and time options on DP search form" do
      describe "a. Users should be able to specify my travel dates on a calendar." do
      
        it "A single travel date is required for the outbound and return AND
          the customer is able to manually enter the date as well in the appropriate date format AND
          it is possible to select a date from the calendar and not a time (time is optional)"  do
          package_search_page = PackageSearchPage.new(driver, RSpec.configuration.env)
          package_search_page.visit()
          package_search_page.book_a_package('no departure date')
          package_search_page.search_error_messages.text.should == feature.verifications.find_by_name('select departure date').text
          
          package_search_page = PackageSearchPage.new(driver, RSpec.configuration.env)
          package_search_page.visit()
          package_search_page.book_a_package('no return date')
          package_search_page.search_error_messages.text.should == feature.verifications.find_by_name('select return date').text
        end      
        
        it 'Validation exists that travel dates are within 331 days from the current day for both legs AND
          if the date entered is not valid (too far in the future, etc) the customer remains on the search page 
          and sees an error message asking to correct search parameters and try the search again.' do
          package_search_page = PackageSearchPage.new(driver, RSpec.configuration.env)
          package_search_page.visit()
          package_search_page.book_a_package('more than 331 days')
          sleep 1
          package_search_page.search_error_messages
        end
      
        it 'The calendar feature appears automatically upon entry into the date field' do
          package_search_page = PackageSearchPage.new(driver, RSpec.configuration.env)
          package_search_page.visit()
          package_search_page.departure_date_textbox.click()
          package_search_page.date_calendar
          package_search_page.return_date_textbox.click()
          package_search_page.date_calendar        
        end

        it 'When displayed, the calendar shows current month and one month in the future AND
          it is possible to scroll to view other future months AND
          validation exists that prohibits selecting a return date that is before the outbound date' do
          package_search_page = PackageSearchPage.new(driver, RSpec.configuration.env)
          package_search_page.visit()
          package_search_page.departure_date_textbox.click()
          current_month = Time.now.localtime.strftime("%B %Y")
          text_before_click = package_search_page.date_calendar.text
          text_before_click.split("\n").include?(current_month)
          if Integer(Time.now.localtime.strftime("%d")) > 27
            next_month = (Time.now + (5 * (60 * 60 * 24))).localtime.strftime("%B %Y")
          else
            next_month = (Time.now + (30 * (60 * 60 * 24))).localtime.strftime("%B %Y")
          end
          text_before_click.split("\n").include?(next_month)
          package_search_page.date_calendar_next.click()
          text_after_click = package_search_page.date_calendar.text
          text_before_click.should_not == text_after_click
          package_search_page.book_a_package('return date before outbound')
          package_search_page.search_error_messages.text.should == feature.verifications.find_by_name('return before departure').text
        end
            
        it 'If an outbound date is chosen in a future month, the return date calendar will default to that same future month and one future month.' do
          package = Package.find_by_name('date in the future')
          package_search_page = PackageSearchPage.new(driver, RSpec.configuration.env)
          package_search_page.visit()
          package_search_page.departure_date_textbox.click()
          text_before_change_date = package_search_page.date_calendar.text
          package_search_page.departure_date_textbox.send_keys(eval(package.departure_date)) 
          text_after_change_date = package_search_page.date_calendar.text
          text_before_change_date.should_not == text_after_change_date
        end
        
        it 'The return date calendar has all dates previous to the outbound date grayed out , so that it is impossible to use the calendar to select a return date that is before the outbound date.
            AND the calendar for the outbound date has all dates previous to the current date grayed out' do
          package_search_page = PackageSearchPage.new(driver, RSpec.configuration.env)
          package_search_page.visit()
          package_search_page.departure_date_textbox.click()
          current_day = Integer(Time.now.localtime.strftime("%-d"))
          if current_day > 1
            day_before = current_day - 1
            for i in 1..day_before do
              text = '<span class="ui-state-default">' + i.to_s() + '</span>'
              driver.page_source().include?(text)
            end
          else
            # There is no previous day visible today.
          end
        end
        
        it 'Validation exists that prohibits selecting an outbound and return date that are the same' do
          package_search_page = PackageSearchPage.new(driver, RSpec.configuration.env)
          package_search_page.visit()
          package_search_page.book_a_package('same day outbound and return date')
          package_search_page.search_error_messages.text.should == feature.verifications.find_by_name('same day outbound departure date').text
        end
      end        
      
      describe "b. User should be able to specify his travel times for RT." do
          
        it 'A specific time OR time range is available for selection' do          
          package_search_page = PackageSearchPage.new(driver, RSpec.configuration.env)
          package_search_page.visit()
          package_search_page.departure_time_combobox.send_keys(5)
          package_search_page.departure_time_combobox.send_keys(:return)
          package_search_page.departure_time_combobox.text.should == feature_travel_times.verifications.find_by_name('5 hours').text
          package_search_page.visit()
          package_search_page.departure_time_combobox.send_keys('Early')
          package_search_page.departure_time_combobox.send_keys(:return)
          package_search_page.departure_time_combobox.text.should == feature_travel_times.verifications.find_by_name('Early time range').text
        end
                
        it 'If there are no flights available at all in the time or range specified (including the buffer) the search fails and the customer goes to the search results page and sees a message to change parameters and try again.' do
          package_search_page = PackageSearchPage.new(driver, RSpec.configuration.env)
          package_search_page.visit()
          package_search_page.book_a_package('no flights avail')
          package_search_page.search_error_messages.text.should == feature.verifications.find_by_name('no results').text
        end
        
      end
    end
  end
end
