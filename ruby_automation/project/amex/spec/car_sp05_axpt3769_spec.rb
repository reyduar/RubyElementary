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
    describe "Car: AXPT-3769 - Provide ability to see shuttle and rental hours information in the Car Review Page." do
      driver = nil
      page = nil 
      
      car_data_texts_feature = Feature.find_by_name('car data texts')
      car_data_overlays_feature = Feature.find_by_name('car data overlays feature')       
     
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
     
      it "User is able to see link for shuttle information on the summary of the selected car of the Car review page if applicable." do
         #Navigate to search car
         page = CarSearchPage.new(driver, RSpec.configuration.env)
         page.visit()
         page.book_a_car('same location basic w/o discount')
         page.search_cars_button.click()
         page = CarResultsPage.new(driver, RSpec.configuration.env) 
         #Select first card  
         page.select_first_car.click() 
         #Validate suttle link info
         page = CarSelectedPage.new(driver, RSpec.configuration.env)   
         if page.my_element_present?(page,'car data suttle info link','css')                   
            page.car_data_suttle_info_link.text().should eq(car_data_texts_feature.verifications.find_by_name('car shuttle info link text').text)
         end       
      end
            
      it "User is able to see link hours of operation on the summary of the selected car of the Car review page if applicable." do
          #Validate link on pick up location
          if (page.my_element_present?(page,'car data pick up data location hour operation link','css'))
              page.car_data_pick_up_data_location_hour_operation_link.text().should eq(car_data_texts_feature.verifications.find_by_name('car hours of operation link text').text)                     
          end 
          #Validate link on drop off location
          if (page.my_element_present?(page, 'car data drop off location hour operation link', 'css'))
              page.car_data_drop_off_location_hour_operation_link.text().should eq(car_data_texts_feature.verifications.find_by_name('car hours of operation link text').text)            
          end                     
      end      
      
      it "User is able to see the shuttle link only if there is shuttle information returned from the car vendor. If the link is clicked an overlay is displayed that shows information on the shuttle as provided by the car vendor.
          A dismiss link to close the overlay is provided." do
          if page.my_element_present?(page,'car data suttle info link','css') 
             #Click on link to open overlay
             page.car_data_suttle_info_link.click()      
             sleep(2)              
             page.car_data_suttle_information_overlay_title.text().should eq(car_data_overlays_feature.verifications.find_by_name('car data suttle information overlay title text').text.upcase)             
             #Close overlay        
             page.car_data_suttle_information_overlay_close_button.click()               
         end            
      end
            
      it "User is able to see links for hours of operation if applicable. The link provides operating hours of the rental counter.
          A dismiss link to close the overlay is provided." do
          #Validate link on pick up location
          if (page.my_element_present?(page,'car data pick up data location hour operation link','css'))
              #Click on link
              page.car_data_pick_up_data_location_hour_operation_link.click()
              #Validate overlay opens              
              page.car_data_pick_up_location_hours_of_operation_overlay_title.text().should eq(car_data_overlays_feature.verifications.find_by_name('car data hours of operation overlay title text').text.upcase)
              sleep(2)             
              #Close overlay
              page.car_data_pick_up_location_hours_of_operation_overlay_close_button.click()            
          end 
          #Validate link on drop off location
          if (page.my_element_present?(page, 'car data drop off location hour operation link', 'css'))                  
              #Click on link
              page.car_data_drop_off_location_hour_operation_link.click()
              #Validate overlay opens
              page.car_data_drop_off_location_hours_of_operation_overlay_title.text().should eq(car_data_overlays_feature.verifications.find_by_name('car data hours of operation overlay title text').text.upcase)
              sleep(2) 
              #Close overlay
              page.car_data_drop_off_location_hours_of_operation_overlay_close_button.click()                        
          end         
      end
      
      it "If the location is open 24 hours there is no link or overlay needed if applicable. Should simply say 'Open 24 hours'." do
          #Validate link on pick up location
          if (page.my_element_present?(page, 'car data pick up location open hours title', 'css'))                                      
              page.car_data_pick_up_location_open_hours_title.text().should eq(car_data_texts_feature.verifications.find_by_name('car data hours of operation text').text)              
          end    
          #Validate link on drop off location
          if (page.my_element_present?(page, 'car data drop off location open hours title', 'css')) 
              page.car_data_drop_off_location_open_hours_title.text().should eq(car_data_texts_feature.verifications.find_by_name('car data hours of operation text').text)
          end         
      end          
    end
  end
end