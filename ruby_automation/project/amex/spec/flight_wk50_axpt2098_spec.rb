require 'rubygems'
require 'selenium-webdriver'
require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require 'spec_helper'
require 'date'
require_relative '../pages/flight_search_page'
require_relative '../pages/flight_results_page'
require_relative '../db/models/database_model'

describe AMEX_Air do
  describe Week_50 do
    describe "Flight: AXPT-2098 - Provide ability to edit one way or round trip itinerary dates in search summary bar" do       
      driver = nil
      page = nil 
      feature = Feature.find_by_name('edit ow rt itinerary dates')
      flight = Flight.find_by_name('basic round trip')

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
      
      it "For round trip itineraries the outbound date and return date boxes that will show 
          the originally selected dates and be available in edit mode." do       
          page = FlightSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_flight('basic round trip') 
          page = FlightResultsPage.new(driver, RSpec.configuration.env) 
          departure_date_text_value = driver.execute_script("return arguments[0].value" , page.departure_date_textbox)
          return_date_text_value = driver.execute_script("return arguments[0].value" , page.return_date_textbox) 
          departure_date_text_value.should eq(eval(flight.departure_date_1))  
          return_date_text_value.should eq(eval(flight.return_date))    
      end   
      
      it "Clicking in any of the date boxes will trigger the same calendar functionality that's on the air search page.
          The customer will be able to manually enter the date as well in the appropriate date format." do
          page.departure_date_textbox.click()      
          page.should be_calendar_datepicker_present()       
          page.departure_date_textbox.send_keys(:escape)
          page.return_date_textbox.click()      
          page.should be_calendar_datepicker_present()       
          page.return_date_textbox.send_keys(:escape)             
      end  
      
      it "A travel date is required for each leg of the journey. If the date entered is not valid 
          the customer will remain on the search page and see an error asking to correct search parameters and try the search again." do 
         driver.execute_script("arguments[0].value = ''" , page.departure_date_textbox)
         driver.execute_script("arguments[0].value = ''" , page.return_date_textbox) 
         page.update_button.click() 
         verifications = eval(feature.verifications.find_by_name('empty both dates error messages').text)
         page.search_error_messages.each_with_index { |error_message,index|  error_message.text().should eq(verifications[index])}                  
         page.departure_date_textbox.send_keys(eval(flight.departure_date_1))  
         page.update_button.click() 
         page.search_error_messages.each_with_index { |error_message,index|  error_message.text().should eq(feature.verifications.find_by_name('empty return date error message').text)}    
         driver.execute_script("arguments[0].value = ''" , page.departure_date_textbox)    
         page.return_date_textbox.send_keys(eval(flight.return_date))  
         page.update_button.click() 
         page.search_error_messages.each_with_index { |error_message,index|  error_message.text().should eq(feature.verifications.find_by_name('empty departure date error message').text)}     
      end  
      
      it "Travel dates must be within 331 days from the current day for all travel legs. If the date entered is too far in the future
          the customer will remain on the search page and see an error asking to correct search parameters and try the search again." do 
         driver.execute_script("arguments[0].value = ''" , page.departure_date_textbox)
         driver.execute_script("arguments[0].value = ''" , page.return_date_textbox) 
         page.departure_date_textbox.send_keys(eval('(Time.now + (332 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
         page.return_date_textbox.send_keys(eval('(Time.now + (333 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))            
         page.update_button.click() 
         verifications = eval(feature.verifications.find_by_name('both dates too far error messages').text)
         page.search_error_messages.each_with_index { |error_message,index|  error_message.text().should eq(verifications[index])}                  
         driver.execute_script("arguments[0].value = ''" , page.departure_date_textbox)
         driver.execute_script("arguments[0].value = ''" , page.return_date_textbox) 
         page.departure_date_textbox.send_keys(eval('(Time.now + (332 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))           
         page.update_button.click() 
         verifications = eval(feature.verifications.find_by_name('departure date too far error messages').text)
         page.search_error_messages.each_with_index { |error_message,index|  error_message.text().should eq(verifications[index])}              
         driver.execute_script("arguments[0].value = ''" , page.departure_date_textbox)
         driver.execute_script("arguments[0].value = ''" , page.return_date_textbox) 
         page.return_date_textbox.send_keys(eval('(Time.now + (333 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))           
         page.update_button.click() 
         verifications = eval(feature.verifications.find_by_name('return date too far error messages').text)
         page.search_error_messages.each_with_index { |error_message,index|  error_message.text().should eq(verifications[index])}           
      end  

      it "The calendar feature should appear automatically upon entry into the date field.
          When displayed the calendar will show current month and one month in the future. 
          It will be possible to scroll to view other future months." do 
          verifications = [] 
          current_month = Date::MONTHNAMES[Time.now.month]  
          next_month = Date::MONTHNAMES[Time.now.month + 1]           
          verifications = [current_month,next_month]
          driver.execute_script("arguments[0].value = ''" , page.departure_date_textbox)
          driver.execute_script("arguments[0].value = ''" , page.return_date_textbox)   
          page.departure_date_textbox.send_keys(:arrow_left)  
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
          page.departure_date_textbox.send_keys(:escape)
          page.return_date_textbox.send_keys(:arrow_left)      
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
          page.return_date_textbox.send_keys(:escape) 
      end  

      it "It is possible to select a date from the calendar and not a time as time is optional.
          A single date will be allowed per flight leg" do 
          driver.execute_script("arguments[0].value = ''" , page.departure_date_textbox)
          driver.execute_script("arguments[0].value = ''" , page.return_date_textbox)   
          page.departure_date_textbox.send_keys(:arrow_left)  
          page.departure_date_textbox.send_keys(:return)
          page.return_date_textbox.send_keys(:arrow_left)
          page.return_date_textbox.send_keys(:return)
          departure_date_text_value = driver.execute_script("return arguments[0].value" , page.departure_date_textbox)
          return_date_text_value = driver.execute_script("return arguments[0].value" , page.return_date_textbox) 
          page.should_not be_string_empty(departure_date_text_value)
          page.should_not be_string_empty(return_date_text_value) 
      end     
      
      it "Validation will exist that prohibits selecting a return date that is before the outbound date." do
        driver.execute_script("arguments[0].value = ''" , page.departure_date_textbox)
        driver.execute_script("arguments[0].value = ''" , page.return_date_textbox) 
        return_date_before_departure_date = '(Time.now + (10 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'
        departure_date_after_return_date = '(Time.now + (11 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'
        page.return_date_textbox.send_keys(eval(return_date_before_departure_date))   
        page.departure_date_textbox.send_keys(eval(departure_date_after_return_date))
        page.departure_date_textbox.send_keys(:tab)
        sleep 2
        departure_date_text_value = driver.execute_script("return arguments[0].value" , page.departure_date_textbox)
        return_date_text_value = driver.execute_script("return arguments[0].value" , page.return_date_textbox)     
        page.should_not be_string_empty(departure_date_text_value)
        page.should be_string_empty(return_date_text_value)       
      end
      
      it "if an outbound date is chose in a future month the return date calendar will default to that same future month and one future month." do    
        driver.execute_script("arguments[0].value = ''" , page.departure_date_textbox)
        driver.execute_script("arguments[0].value = ''" , page.return_date_textbox) 
        departure_date_next_month = '(Time.now + (32 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'  
        page.departure_date_textbox.send_keys(eval(departure_date_next_month))
        page.departure_date_textbox.send_keys(:tab)
        page.return_date_textbox.send_keys(:arrow_left)     
        next_month = Date::MONTHNAMES[Time.now.month + 1]  
        after_next_month = Date::MONTHNAMES[Time.now.month + 2]           
        verifications = [next_month,after_next_month]      
        departure_date_next_month = '(Time.now + (35 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'  
        page.departure_date_textbox.send_keys(eval(departure_date_next_month))
        page.departure_date_textbox.send_keys(:tab)
        page.return_date_textbox.send_keys(:arrow_left)     
        current_month = Date::MONTHNAMES[Time.now.month + 2]  
        next_month = Date::MONTHNAMES[Time.now.month + 3]           
        verifications = [current_month,next_month]      
        page.calendar_datepicker_current_months.each_with_index { |month,index|  month.text().should eq(verifications[index])} 
        page.return_date_textbox.send_keys(:escape)     
      end

      it "the return date calendar have all dates previous to the outbound date grayed out 
          so that it will be impossible to use the calendar to select a return date that is before the outbound date." do
        driver.execute_script("arguments[0].value = ''" , page.departure_date_textbox)
        driver.execute_script("arguments[0].value = ''" , page.return_date_textbox) 
        departure_date = eval(flight.departure_date_1)  
        page.departure_date_textbox.send_keys(departure_date)
        page.departure_date_textbox.send_keys(:tab)
        page.return_date_textbox.send_keys(:arrow_left)   
        departure_day_minus_one = (Date.strptime departure_date,'%m/%d/%Y').day - 1    
        page.calendar_datepicker_day_numbers.each_with_index { |day,index|
          if (day.text().to_s == departure_day_minus_one.to_s)
            day_disabled_class_text = (driver.execute_script("return arguments[0].parentNode.className;", day)).strip         
            day_disabled_class_text.should eq('ui-datepicker-unselectable ui-state-disabled')           
          end
        } 
        page.return_date_textbox.send_keys(:escape)   
      end 
      
      it "if the last date of a month is selected as the outbound date the calendar for the return will default to the next month and one future month.
          The customer will need the ability to move back a month for the case where the outbound and return are the same date. 
          Example - outbound chosen is 10/31. Return calendar should show November and December. However, if the customer's intent is to travel out 
          and back both on 10/31 there needs to be the option to move back to October in the calendar to select 10/31 as the return date." do
        last_date_of_current_month = Date.civil(Time.now.year, Time.now.month, -1).strftime('%m/%d/%Y')    
        driver.execute_script("arguments[0].value = ''" , page.departure_date_textbox)
        driver.execute_script("arguments[0].value = ''" , page.return_date_textbox)  
        page.departure_date_textbox.send_keys(last_date_of_current_month)    
        page.departure_date_textbox.send_keys(:tab)    
        page.return_date_textbox.send_keys(:arrow_left)   
        next_month = Date::MONTHNAMES[Time.now.month + 1]  
        after_next_month = Date::MONTHNAMES[Time.now.month + 2]    
        verifications = [next_month,after_next_month] 
        page.calendar_datepicker_current_months.each_with_index { |month,index|  month.text().should eq(verifications[index])} 
        page.calendar_datepicker_previous_button.click()
        departure_day = (Date.strptime last_date_of_current_month,'%m/%d/%Y').day   
        page.calendar_datepicker_day_numbers.each_with_index { |day,index|
          if (day.text().to_s == departure_day.to_s)
            day_disabled_class_text = (driver.execute_script("return arguments[0].parentNode.className;", day)).strip         
            day_disabled_class_text.should_not eq('ui-datepicker-unselectable ui-state-disabled')           
          end
        } 
        page.return_date_textbox.send_keys(last_date_of_current_month)    
        page.return_date_textbox.send_keys(:tab) 
        departure_date_text_value = driver.execute_script("return arguments[0].value" , page.departure_date_textbox)
        return_date_text_value = driver.execute_script("return arguments[0].value" , page.return_date_textbox) 
        departure_date_text_value.should eq(last_date_of_current_month)  
        return_date_text_value.should eq(last_date_of_current_month)   
      end 
    end  
  end
end  