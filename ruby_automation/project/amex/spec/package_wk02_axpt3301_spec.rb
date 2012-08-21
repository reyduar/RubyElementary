require 'rubygems'
require 'selenium-webdriver'
require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require 'spec_helper'
require 'date'
require_relative '../pages/package_search_page'
require_relative '../pages/package_results_page'
require_relative '../db/models/database_model'

describe AMEX_Package do
  describe Week_02 do
    driver = nil
    page = nil   
    initial_results_url = nil    
    feature = Feature.find_by_name('dp search summary bar') 
    package = Package.find_by_name('dp search summary')
    verifications = nil
    initial_results_url = nil
    
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
      driver.manage.delete_all_cookies()
      if example.failed?
        driver.save_screenshot("logs/screenshot_#{Time.now.strftime('%Y%m%d-%H%M%S')}.png")
      end
    end        
    
    after(:all) do
      driver.quit()
    end      
  
    describe "Package: AXPT-3301 - DP Search Summary: Customer should be able to see my searched dates in edit mode" do 
      it "For DP itineraries, the outbound date and return date boxes show the originally selected dates/time and are available in edit mode." do
        page = PackageSearchPage.new(driver, RSpec.configuration.env)
        initial_results_url = driver.current_url
        page.visit()
        page.book_a_package("dp search summary")
        page = PackageResultsPage.new(driver, RSpec.configuration.env)   
        page.check_in_date_calendar.should be_present()
        page.check_out_date_calendar.should be_present()
        departure_date_text_value = driver.execute_script("return arguments[0].value" , page.check_in_date_calendar)
        return_date_text_value = driver.execute_script("return arguments[0].value" , page.check_out_date_calendar) 
        page.should_not be_string_empty(departure_date_text_value)
        page.should_not be_string_empty(return_date_text_value) 
        driver.execute_script("arguments[0].value = ''" , page.check_in_date_calendar)
        driver.execute_script("arguments[0].value = ''" , page.check_out_date_calendar)
        departure_date_text_value = driver.execute_script("return arguments[0].value" , page.check_in_date_calendar)
        return_date_text_value = driver.execute_script("return arguments[0].value" , page.check_out_date_calendar) 
        page.should be_string_empty(departure_date_text_value)
        page.should be_string_empty(return_date_text_value) 
        page.check_in_date_calendar.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
        page.check_out_date_calendar.send_keys(eval('(Time.now + (20 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
      end
     
      it "Clicking in any of the date boxes triggers the same calendar/time functionality that's on the search page." do
        page.check_in_date_calendar.click()      
        page.should be_calendar_datepicker_present()       
        page.check_in_date_calendar.send_keys(:escape)
        page.check_out_date_calendar.click()      
        page.should be_calendar_datepicker_present()       
        page.check_out_date_calendar.send_keys(:escape)   
      end
     
      it "Both check in date and a check out date are required for all searches." do
        # check in date and out date is not empty 
        departure_date_text_value = driver.execute_script("return arguments[0].value" , page.check_in_date_calendar)
        return_date_text_value = driver.execute_script("return arguments[0].value" , page.check_out_date_calendar) 
        page.should_not be_string_empty(departure_date_text_value)
        page.should_not be_string_empty(return_date_text_value) 
        page.update_button.click
        page = nil
        page = PackageResultsPage.new(driver, RSpec.configuration.env) 
        page.first_dp_hotel_card.should be_present()
        # check in date empty error
        driver.execute_script("arguments[0].value = ''" , page.check_in_date_calendar)
        page.update_button.click
        page = nil
        page = PackageResultsPage.new(driver, RSpec.configuration.env)
        page.wait_for_element_present(page, "package results error messages", "css")          
        page.result_error_messages[0].should be_present()
        page.result_error_messages[0].text().should eq(feature.verifications.find_by_name('select departure date error').text) 
        page.should_not be_my_element_present(page, "first dp hotel card", "css")           
        # check on date empty error      
        page.check_in_date_calendar.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))          
        driver.execute_script("arguments[0].value = ''" , page.check_out_date_calendar)
        page.update_button.click
        page = nil
        page = PackageResultsPage.new(driver, RSpec.configuration.env)
        page.wait_for_element_present(page, "package results error messages", "css")          
        page.result_error_messages[0].should be_present()
        page.result_error_messages[0].text().should eq(feature.verifications.find_by_name('select return date error').text)  
        page.should_not be_my_element_present(page, "first dp hotel card", "css")
      end
     
      it "Dates must be within 331 days from the current day for both check in and check out. 
          Validation exists that prohibits a check in or check out date more than 331 days in advance." do
        driver.execute_script("arguments[0].value = ''" , page.check_in_date_calendar)
        driver.execute_script("arguments[0].value = ''" , page.check_out_date_calendar)
        page.check_in_date_calendar.send_keys(eval('(Time.now + (332 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
        page.check_out_date_calendar.send_keys(eval('(Time.now + (333 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))            
        page.update_button.click
        page = nil
        page = PackageResultsPage.new(driver, RSpec.configuration.env)
        page.wait_for_element_present(page, "package results error messages", "css")          
        page.result_error_messages[0].should be_present()
        page.result_error_messages[0].text().should eq(feature.verifications.find_by_name('dates should be within 331 days error').text) 
        page.should_not be_my_element_present(page, "first dp hotel card", "css") 
      end
      
      it "Whether dates are entered via the calendar or manually input, the maximum stay is limited to 30 days.
          If the date entered is not valid (too far in the future, etc) the customer remains on the search page and sees an error asking 
          to correct search parameters and try the search again. Validation exists that prohibits a stay longer than 30 days." do
        driver.execute_script("arguments[0].value = ''" , page.check_in_date_calendar)
        driver.execute_script("arguments[0].value = ''" , page.check_out_date_calendar)
        page.check_in_date_calendar.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
        page.check_out_date_calendar.send_keys(eval('(Time.now + (60 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))            
        page.update_button.click
        page = nil
        page = PackageResultsPage.new(driver, RSpec.configuration.env)
        page.wait_for_element_present(page, "package results error messages", "css")          
        page.result_error_messages[0].should be_present()
        page.result_error_messages[0].text().should eq(feature.verifications.find_by_name('the maximum stay is limited to 30 days error').text) 
        page.should_not be_my_element_present(page, "first dp hotel card", "css") 
      end

      it "The calendar feature appears automatically upon entry into the date field. The customer is able to manually enter the date as well, in the appropriate date format." do
        page.check_in_date_calendar.click()      
        page.should be_calendar_datepicker_present()       
        page.check_in_date_calendar.send_keys(:escape)
        page.check_out_date_calendar.click()      
        page.should be_calendar_datepicker_present()       
        page.check_out_date_calendar.send_keys(:escape) 
        # fill in the "on date textbox" with an invalid format date: year/month/day
        driver.execute_script("arguments[0].value = ''" , page.check_in_date_calendar)
        driver.execute_script("arguments[0].value = ''" , page.check_out_date_calendar)
        page.check_in_date_calendar.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
        if(Time.now.day < 12)
          page.check_out_date_calendar.send_keys("#{Time.now.day+12}/#{Time.now.month}/#{Time.now.year}")
        else
          page.check_out_date_calendar.send_keys("#{Time.now.day}/#{Time.now.month}/#{Time.now.year}")
        end
        page.update_button.click
        page = nil
        page = PackageResultsPage.new(driver, RSpec.configuration.env) 
        page.wait_for_element_present(page, "package results error messages", "css")          
        page.result_error_messages[0].text().should eq(feature.verifications.find_by_name('select return date error').text)  
        page.should_not be_my_element_present(page, "first dp hotel card", "css") 
        # fill in the "in date textbox" with an invalid format date: day/month/year
        driver.execute_script("arguments[0].value = ''" , page.check_in_date_calendar)
        driver.execute_script("arguments[0].value = ''" , page.check_out_date_calendar)
        if(Time.now.day < 12)
          page.check_in_date_calendar.send_keys("#{Time.now.day+12}/#{Time.now.month}/#{Time.now.year}")
        else
           page.check_in_date_calendar.send_keys("#{Time.now.day}/#{Time.now.month}/#{Time.now.year}")
        end
        page.check_out_date_calendar.send_keys(eval('(Time.now + (8 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
        page.update_button.click
        page = nil
        page = PackageResultsPage.new(driver, RSpec.configuration.env) 
        page.wait_for_element_present(page, "package results error messages", "css")          
        page.result_error_messages[0].text().should eq(feature.verifications.find_by_name('select departure date error').text)  
        page.should_not be_my_element_present(page, "first dp hotel card", "css") 
      end

      it "When displayed, the calendar shows current month and one month in the future. It is possible to scroll to view other future months." do
        verifications = [] 
        current_month = Date::MONTHNAMES[Time.now.month]  
        next_month = Date::MONTHNAMES[Time.now.month + 1]           
        verifications = [current_month,next_month]
        driver.execute_script("arguments[0].value = ''" , page.check_in_date_calendar)
        driver.execute_script("arguments[0].value = ''" , page.check_out_date_calendar)   
        page.check_in_date_calendar.send_keys(:arrow_left)  
        page.should be_calendar_datepicker_present() 
        page.calendar_datepicker_current_months.each_with_index { |month,index|  month.text().should eq(verifications[index])} 
        page.calendar_datepicker_next_button.click()
        current_month = Date::MONTHNAMES[Time.now.month + 1]  
        next_month = Date::MONTHNAMES[Time.now.month + 2]           
        verifications = [current_month,next_month]      
        page.calendar_datepicker_current_months.each_with_index { |month,index|  month.text().should eq(verifications[index])} 
        page.calendar_datepicker_previous_button.click()
        current_month = Date::MONTHNAMES[Time.now.month]  
        next_month = Date::MONTHNAMES[Time.now.month + 1]           
        verifications = [current_month,next_month]      
        page.calendar_datepicker_current_months.each_with_index { |month,index|  month.text().should eq(verifications[index])} 
        page.check_in_date_calendar.send_keys(:escape)
        page.check_out_date_calendar.send_keys(:arrow_left)      
        page.should be_calendar_datepicker_present()       
        page.calendar_datepicker_current_months.each_with_index { |month,index|  month.text().should eq(verifications[index])}  
        page.calendar_datepicker_next_button.click()
        current_month = Date::MONTHNAMES[Time.now.month + 1]  
        next_month = Date::MONTHNAMES[Time.now.month + 2]           
        verifications = [current_month,next_month]      
        page.calendar_datepicker_current_months.each_with_index { |month,index|  month.text().should eq(verifications[index])} 
        page.calendar_datepicker_previous_button.click()
        current_month = Date::MONTHNAMES[Time.now.month]  
        next_month = Date::MONTHNAMES[Time.now.month + 1]           
        verifications = [current_month,next_month]      
        page.calendar_datepicker_current_months.each_with_index { |month,index|  month.text().should eq(verifications[index])}      
        page.check_out_date_calendar.send_keys(:escape) 
      end

      it "If a check in date is chosen in a future month, the check out date calendar will default to that same future month and one future month." do
        driver.execute_script("arguments[0].value = ''" , page.check_in_date_calendar)
        driver.execute_script("arguments[0].value = ''" , page.check_out_date_calendar) 
        departure_date_next_month = '(Time.now + (35 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'  
        page.check_in_date_calendar.send_keys(eval(departure_date_next_month))
        page.check_in_date_calendar.send_keys(:tab)
        page.check_out_date_calendar.send_keys(:arrow_left)     
        current_month = Date::MONTHNAMES[Time.now.month + 1]  
        next_month = Date::MONTHNAMES[Time.now.month + 2]           
        verifications = [current_month,next_month] 
        page.check_out_date_calendar.send_keys(eval('(Time.now + (34 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
        page.calendar_datepicker_current_months.each_with_index { |month,index|  
          month.text().should eq(verifications[index])
        } 
        page.check_out_date_calendar.send_keys(:escape)  
      end

      it "The check out date calendar has all dates previous to the check in date grayed out, so that it is impossible to use the calendar to select a check out date that is before the check in date." do
        driver.execute_script("arguments[0].value = ''" , page.check_in_date_calendar)
        driver.execute_script("arguments[0].value = ''" , page.check_out_date_calendar) 
        in_date = eval(package.departure_date)  
        page.check_in_date_calendar.send_keys(in_date)
        page.check_in_date_calendar.send_keys(:tab)
        page.check_out_date_calendar.send_keys(:arrow_left)   
        departure_day_minus_one = (Date.strptime in_date,'%m/%d/%Y').day - 1    
        page.calendar_datepicker_day_numbers.each_with_index { |day,index|
        if (day.text().to_s == departure_day_minus_one.to_s)
          day_disabled_class_text = (driver.execute_script("return arguments[0].parentNode.className;", day)).strip         
          day_disabled_class_text.should eq('ui-datepicker-unselectable ui-state-disabled')           
        end
        } 
      end

      it "The calendar for the check in date has all dates previous to the current date grayed out." do
        driver.execute_script("arguments[0].value = ''" , page.check_in_date_calendar)
        current_date = Time.now.localtime.strftime("%m/%d/%Y")
        page.check_in_date_calendar.send_keys(current_date)
        page.check_in_date_calendar.send_keys(:tab)
        page.check_in_date_calendar.send_keys(:arrow_left)   
        departure_day_minus_one = (Date.strptime current_date,'%m/%d/%Y').day - 1    
        page.calendar_datepicker_day_numbers.each { |day|
        if (day.text().to_s == departure_day_minus_one.to_s)
          day_disabled_class_text = (driver.execute_script("return arguments[0].parentNode.className;", day)).strip         
          day_disabled_class_text.should be_include('ui-state-disabled')           
        end
        } 
      end

      it "Validation exists that prohibits selecting a check in date that is before the check out date.
          Validation exists that prohibits the check in and check out date from being the same." do
        driver.execute_script("arguments[0].value = ''" , page.check_in_date_calendar)
        driver.execute_script("arguments[0].value = ''" , page.check_out_date_calendar)
        page.check_in_date_calendar.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
        page.check_out_date_calendar.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))            
        page.update_button.click
        page = nil
        page = PackageResultsPage.new(driver, RSpec.configuration.env)
        page.wait_for_element_present(page, "package results error messages", "css")          
        page.result_error_messages[0].should be_present()
        page.result_error_messages[0].text().should eq(feature.verifications.find_by_name('same day outbound departure date').text) 
        page.should_not be_my_element_present(page, "first dp hotel card", "css") 
      end
    
      it "There are no times shown. Any search initiated from the DP search summary bar retains the times from the original DP search performed.
          Clicking the 'Update' button in the summary bar kicks off a new DP search using the newly submitted date/time information." do
        page = PackageSearchPage.new(driver, RSpec.configuration.env)
        initial_results_url = driver.current_url
        page.visit()
        page.book_a_package("round trip time morning 6am - noon")
        page = PackageResultsPage.new(driver, RSpec.configuration.env)
        sleep 2        
        /am/.match(page.flight_times_label[0].text()).to_s.should eq("am")
        /am/.match(page.flight_times_label[2].text()).to_s.should eq("am")
        driver.execute_script("arguments[0].value = ''" , page.arrival_city_textbox)
        page.enter_airport(page.arrival_city_textbox, feature.verifications.find_by_name('arrival city text').text)
        page.update_button.click
        page = nil
        page = PackageResultsPage.new(driver, RSpec.configuration.env)
        sleep 2         
        /am/.match(page.flight_times_label[0].text()).to_s.should eq("am")
        /am/.match(page.flight_times_label[2].text()).to_s.should eq("am")
        driver.current_url.should_not eq(initial_results_url)
      end
  
      it "The interstitial page shows and the customer sees a refreshed search results page. (link imp story)" do
        sleep 2 
        page.update_button.click
        page = nil
        page = PackageResultsPage.new(driver, RSpec.configuration.env) 
        driver.execute_script("document.getElementsByClassName('_jq-loading-content')[0].style.display='block'")
        page.interstitial_main_text_label.should be_present()
        page.interstitial_main_text_label.text().should eq(feature.verifications.find_by_name('interstitial main text').text) 
      end
     end
  end
end