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
require_relative '../pages/home_page'
require_relative '../db/models/database_model'


describe AMEX_Car do
  describe Week_50 do
    describe "Car: AXPT-1871 - Pick up and Drop off dates available in edit mode" do       
      driver = nil
      
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
    
      it "On the search summary bar the originally searched for pick up and 
          drop off dates will be available in edit mode" do
          
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          start_date = 'return document.getElementById("%s").value'%(page.db_object.elements.find_by_name('pickup date textbox').by_id_locator)
          end_date = 'return document.getElementById("%s").value'%(page.db_object.elements.find_by_name('dropoff date textbox').by_id_locator)
          driver.execute_script(start_date).should == ''
          driver.execute_script(end_date).should == ''
          page.book_a_car('test date fields')
          driver.execute_script(start_date).should_not == ''
          driver.execute_script(end_date).should_not == ''
      end
    
      it "Clicking in any of the date boxes will trigger the same 
          calendar/time functionality that's on the search page" do
      
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.pickup_date_textbox.click()
          page.should be_element_present(page, 'car pickup date calendar', 'id')
          pickup_date_ui_element = page.db_object.elements.find_by_name('car pickup date calendar').by_id_locator
          page.dropoff_date_textbox.click()
          page.should be_element_present(page, 'car dropoff date calendar', 'id')
          dropoff_date_ui_element = page.db_object.elements.find_by_name('car dropoff date calendar').by_id_locator
          
          page = HomePage.new(driver, RSpec.configuration.env)
          page.visit()
          
          page.departure_date_textbox.click()
          page.should be_element_present(page, 'home departure date calendar', 'id')
          departure_date_ui_element = page.db_object.elements.find_by_name('home departure date calendar').by_id_locator
          page.return_date_textbox.click()
          page.should be_element_present(page, 'home return date calendar', 'id')
          return_date_ui_element = page.db_object.elements.find_by_name('home return date calendar').by_id_locator
                
          pickup_date_ui_element.should == departure_date_ui_element
          dropoff_date_ui_element.should == return_date_ui_element      
      end
    
    
      it "It is possible to edit the pick up only or the drop off only 
          or both." do
          feature = Feature.find_by_name('car result errors')
          
          # Test case: The departure date cannot be after your return date and
          # The drop-off date cannot be before the pick-up date
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('NOLA dropoff date before pickup')
          page.search_cars_button.click()
          page = CarResultsPage.new(driver, RSpec.configuration.env)
          page.should be_text_present(feature.verifications.find_by_name('dropoff before pickup').text)
          
          # Test case: Departure Date field empty
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('NOLA pick up date only')
          page.search_cars_button.click()
          page = CarResultsPage.new(driver, RSpec.configuration.env)
          page.should be_text_present(feature.verifications.find_by_name('missing dropoff').text)
          
          # Test case: Return Date field empty
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('NOLA drop off date only')
          page.search_cars_button.click()
          page = CarResultsPage.new(driver, RSpec.configuration.env)
          page.should be_text_present(feature.verifications.find_by_name('missing pickup').text)
          
          # Test case: Testing both fields completed
          feature = Feature.find_by_name('car generic error')
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('same location basic w/o discount')
          page.search_cars_button.click()
          page = CarResultsPage.new(driver, RSpec.configuration.env)
          page.should_not be_text_present(feature.verifications.find_by_name('car results generic error message').text)
      end
    
      it "Clicking the Update button in the summary bar will kick off a 
          new car search using the newly submitted date information." do
          feature = Feature.find_by_name('car result change')
          
          # reach the summary bar
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('same location basic w/o discount')
          page.search_cars_button.click()
          page = CarResultsPage.new(driver, RSpec.configuration.env)
          html1 = driver.page_source
          # Change date
          pu_new_time = eval(feature.verifications.find_by_name('new pickup time').text)
          do_new_time = eval(feature.verifications.find_by_name('new dropoff time').text)
          page.pickup_date_textbox.send_keys(pu_new_time)
          page.dropoff_date_textbox.send_keys(do_new_time)
          # Click on update button
          page.car_results_update_button.click()
          html2 = driver.page_source
          # Compare both results
          html1.should_not equal(html2)
      end
    
      it "Dates for both pick up and drop off must be present or the update 
          search will fail" do
          feature = Feature.find_by_name('car result errors')
          
          #Do a standard search
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('same location basic w/o discount')
          page.search_cars_button.click()
          page = CarResultsPage.new(driver, RSpec.configuration.env)
          # Search with missing drop off
          dropoff_date = driver.execute_script("return arguments[0].value" , page.dropoff_date_textbox)
          driver.execute_script("arguments[0].value = ''" , page.dropoff_date_textbox)
          page.car_results_update_button.click()
          page.should be_text_present(feature.verifications.find_by_name('missing dropoff').text)
          # Search with missing pick up
          driver.execute_script("arguments[0].value = '%s'"%(dropoff_date) , page.dropoff_date_textbox)
          driver.execute_script("arguments[0].value = ''" , page.pickup_date_textbox)
          page.car_results_update_button.click()
          page.should be_text_present(feature.verifications.find_by_name('missing pickup').text)
      end
    end
  end
end
