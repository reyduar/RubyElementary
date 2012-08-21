require 'selenium-webdriver'
require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require 'spec_helper'
require_relative '../pages/car_search_page'
require_relative '../pages/car_results_page'
require_relative '../pages/car_selected_page'
require_relative '../db/models/database_model'

describe AMEX_Car do
  describe Sprint_05 do
    describe Script_01 do
      describe "Car: AXPT-1157 - Car Search Summary - As a customer I want to see my rental locations in edit mode." do    
          driver = nil
          page = nil           
          search_pickup_location_value = nil
          result_pickup_location_value = nil
          result_dropoff_location_value = nil          
          edit_pickup_location_value = nil
          edit_dropoff_location_value = nil          
          payment_section = nil
          vendor_image = nil                     
          
          car_matrix_vendor_image = Feature.find_by_name('car matrix vendor image') 
          car_book_car_text = Feature.find_by_name('car book car text')
                
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
                
          it "Do an airport round trip search first." do   
              page = CarSearchPage.new(driver, RSpec.configuration.env)
              page.visit()
              page.book_a_car('same location basic w/o discount')
              search_pickup_location_value = driver.execute_script("return arguments[0].value" , page.pickup_city_textbox)                 
              page.search_cars_button.click()           
              page = CarResultsPage.new(driver, RSpec.configuration.env) 
              page.car_matrix.should be_present()
          end    
          
          it "When on the results page show that the information entered is in the edit fields at the top of the page." do               
              result_pickup_location_value = driver.execute_script("return arguments[0].value" , page.car_search_pickup_location_textbox)
              result_dropoff_location_value = driver.execute_script("return arguments[0].value" , page.car_search_dropoff_location_textbox)    
              search_pickup_location_value.should eq(result_pickup_location_value)
              search_pickup_location_value.should eq(result_dropoff_location_value)                 
          end
        
          it "Show that the airport is editable in both fields." do                
              driver.execute_script("arguments[0].value = ''" , page.car_search_pickup_location_textbox)          
              sleep(1)
              page.enter_airport(page.car_search_pickup_location_textbox, "London Heathrow Airport, GB (LHR)")                          
              edit_pickup_location_value = driver.execute_script("return arguments[0].value" , page.car_search_pickup_location_textbox)                      
              driver.execute_script("arguments[0].value = ''" , page.car_search_dropoff_location_textbox)   
              page.enter_airport(page.car_search_dropoff_location_textbox, "London Heathrow Airport, GB (LHR)")              
              edit_dropoff_location_value = driver.execute_script("return arguments[0].value" , page.car_search_dropoff_location_textbox)          
              edit_pickup_location_value.should_not eq(result_pickup_location_value)
              edit_dropoff_location_value.should_not eq(result_dropoff_location_value)                          
          end
        
          it "Show rates are returned when the information is changed.
              Comment: The script checks matrix car-vendors exists because the rental's values are not reliable, they can change depending on chosen car-vendor." do
              page.car_search_dropoff_location_textbox.send_keys(:tab) 
              page.pickup_date_textbox.send_keys(:tab) 
              page.dropoff_date_textbox.send_keys(:tab)          
              page.car_results_update_button.click() 
              page.car_matrix.should be_present()    
          end        
      
      describe "Car: AXPT-1213 - Book Car - As a customer I want to book my car itinerary" do
          it "Do a search in any market for any amount of time.
              Comment: To complete Who is driving section and not Payment section, Advantage car vendor should be selected." do
              driver.execute_script("arguments[0].value = ''" , page.car_search_pickup_location_textbox)    
              page.enter_airport(page.car_search_pickup_location_textbox, "Miami International Airport, FL, US (MIA)")              
              driver.execute_script("arguments[0].value = ''" , page.car_search_dropoff_location_textbox)
              page.enter_airport(page.car_search_dropoff_location_textbox, "Miami International Airport, FL, US (MIA)")                            
              page.pickup_date_textbox.send_keys(:tab) 
              page.dropoff_date_textbox.send_keys(:tab)  
              sleep 1
              page.car_results_update_button.click()   
              page.car_matrix_vendors_images.should be_present()              
              page.car_matrix_vendors_images.each_with_index { |images,index|
              vendor_image = images.attribute("src").split("/").last
              if vendor_image == car_matrix_vendor_image.verifications.find_by_name('car matrix advantage rent a car vendor image').text
                 page.car_matrix_vendors_images[index].click()   
                 sleep 2             
                 page.car_select_second_car_advantage_vendor.click()
                 payment_section = "collapsed"   
                 break                            
                else 
                    payment_section = "expanded"
              end
              } 
          end

          it "Proceed to the checkout and fill out the Who is driving section." do
              if payment_section == "collapsed"
                 page = CarSelectedPage.new(driver, RSpec.configuration.env)  
                 page.car_driver_info_container.should be_present()        
                 page.car_driver_info_first_name_textbox.send_keys("Ariel")
                 page.car_driver_info_last_name_textbox.send_keys("ORBITZTEST")
                 page.car_driver_info_email_texbox.send_keys("testcar.ariel@gmail.com")   
                 page.car_driver_info_phone_number_texbox.send_keys("541141091700") 
                 page.car_driver_info_save_button.click()
              end                 
          end   

          it "Proceed to the book section and try clicking the Book Car button without clicking the T&C radio button.
              Show the form validation error." do
              if payment_section == "collapsed"
                 page.car_select_book_car_button.click()        
                 page.car_book_car_error_message.text().should eq(car_book_car_text.verifications.find_by_name('car book car terms and conditions error message').text)  
              end             
          end         
        end         
      end
    end
  end
end   