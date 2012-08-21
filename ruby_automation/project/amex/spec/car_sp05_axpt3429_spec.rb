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
    describe "Car: AXPT-3429 - Provide ability to see a summary of my selected car in the Review Page." do   
      driver = nil
      page = nil 
      car_type = nil
      car_type_checkout = nil
      car_type_length_rental = nil
      car_type_length_rental_number = nil
      vendor_img = nil
      vendor_img_checkout = nil
      car_img = nil
      car_img_checkout = nil      
      car_pick_up_date_time = nil
      car_drop_off_date_time = nil      
      number_doors = nil
      number_passengers = nil
      number_luggage = nil
      pick_up_location = nil
      drop_off_location = nil
      extra_cost_value = nil
      extra_cost_detail = nil
      estimated_total_cost = nil
      
      car_data_texts_feature = Feature.find_by_name('car data texts') 
      car_texts_cost_feature = Feature.find_by_name('car texts cost') 
      car_taxes_and_fees_texts_feature = Feature.find_by_name('car taxes and fees texts')
      
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
    
      it "User lands to the Checkout page after a car selection." do
          #Navigate to search car
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('same location basic w/o discount')
          page.search_cars_button.click()
          page = CarResultsPage.new(driver, RSpec.configuration.env)   
          #Take car type
          car_type = page.car_results_car_type_titles[0].text()   
          #Take vendor image
          vendor_img = page.cars_cards_imgs[0].attribute("src").split("/").last      
          #Take car image
          sleep 2
          car_img = page.car_cars_images[0].attribute("src").split("/").last    
          #Take Pick Up Date/Time
          car_pick_up_date_time = page.car_first_card_data[0].text()
          #Take Drop Off Date/Time                               
          car_drop_off_date_time = page.car_first_card_data[1].text()    
          
          #Take doors values   
          if page.my_element_present?(page,'car first card details doors','css')
             number_doors = page.car_first_card_details_doors.text().to_i 
          end         
          #Take passengers values   
          if page.my_element_present?(page,'car first card details passengers','css')
             number_passengers = page.car_first_card_details_passengers.text().to_i  
          end                      
          #Take luggage values   
          if page.my_element_present?(page,'car first card details luggage','css')
             number_luggage = page.car_first_card_details_luggage.text().to_i
          end
          
          #Take pickup location
          pick_up_location = page.car_first_card_details_pick_up_location.text()
          #Take drop off location
          drop_off_location = page.car_first_card_details_drop_off_location.text()                   
          #Click on first car button found
          page.select_first_car.click()                               
      end
      
      it "User is able to see the type of car and length of rental at the top of the summary." do
          page = CarSelectedPage.new(driver, RSpec.configuration.env)      
          car_type_checkout = page.car_type_and_length_rental_title.text().split(/  /,2).first          
          car_type_length_rental = page.car_type_and_length_rental_title.text().split(/  /,2).last.strip
          car_type_length_rental_number = car_type_length_rental.split.first          
          #Validate car type name
          car_type.should eq car_type_checkout
          #Validate car lenght of rental
          car_type_length_rental_number.to_i.should be > 0                           
      end          
      
      it "User is able to see the following informational item in the car summary: Car vendor logo." do
          vendor_img_checkout = page.car_selected_banner_rental_company_img.attribute("src").split("/").last  
          #Validate car vendor image
          vendor_img.should eq (vendor_img_checkout)        
      end
            
      it "User is able to see the following informational item in the car summary: Car image." do    
          car_img_checkout = page.car_selected_image.attribute("src").split("/").last        
          car_img.should eq (car_img_checkout)          
      end
            
      it "User is able to see the following informational item in the car summary: Book now pay later label." do    
          page.car_book_now_pay_later_title_banner.text().should eq(car_data_texts_feature.verifications.find_by_name('car book now pay later text banner').text.upcase)              
      end
      
      it "User is able to see the following informational item in the car summary: Pick up and drop off out dates and times." do 
          #Validate pick up date time value
          car_pick_up_date_time.should eq (page.car_data_locations[0].text())
          #Validate drop off date time value          
          car_drop_off_date_time.should eq (page.car_data_locations[1].text())             
      end
            
      it "User is able to see the following informational item in the car summary: Information on air conditioning." do
         page.car_data_summary_texts.each{|summary_texts|
         if (summary_texts.text().include? (car_data_texts_feature.verifications.find_by_name('car checkout air conditioning text').text))
             summary_texts.text().should eq(car_data_texts_feature.verifications.find_by_name('car checkout air conditioning text').text)
         end           
         }          
      end 
          
      it "User is able to see the following informational item in the car summary: Information on transmission." do
         page.car_data_summary_texts.each{|summary_texts|
         if (summary_texts.text().include? (car_data_texts_feature.verifications.find_by_name('car checkout automatic transmission text').text))
             summary_texts.text().should eq(car_data_texts_feature.verifications.find_by_name('car checkout automatic transmission text').text) 
         end           
         }          
      end 
      
      it "User is able to see the following informational item in the car summary: Information on doors." do                            
         if page.my_element_present?(page,'car data doors number','css')
            number_doors.should eq(page.car_data_doors_number.text().to_i)
         end
      end
      
      it "User is able to see the following informational item in the car summary: Information on passengers." do                             
         if page.my_element_present?(page,'car data passengers number','css')
            number_passengers.should eq(page.car_data_passengers_number.text().to_i)
         end
      end
            
      it "User is able to see the following informational item in the car summary: Information on luggage."do                                        
         if page.my_element_present?(page,'car data luggage number','css')
            number_luggage.should eq(page.car_data_luggage_number.text().to_i) 
         end
      end
           
      it "User is able to see the following informational item in the car summary: Link for shuttle info, if applicable." do
         page = CarSelectedPage.new(driver, RSpec.configuration.env)     
         if (page.my_element_present?(page, 'car data suttle info link', 'css'))
             page.car_data_suttle_info_link.text().should eq(car_data_texts_feature.verifications.find_by_name('car shuttle info link text').text)
         end
      end
            
      it "User is able to see the following informational item in the car summary: Link for hours of operation, if applicable." do
         page = CarSelectedPage.new(driver, RSpec.configuration.env)   
         #Validate link on pick up location
         if (page.my_element_present?(page,'car data pick up data location hour operation link','css'))
             page.car_data_pick_up_data_location_hour_operation_link.text().should eq(car_data_texts_feature.verifications.find_by_name('car hours of operation link text').text)                     
         end         
         #Validate link on drop off location
         if (page.my_element_present?(page, 'car data drop off location hour operation link', 'css'))
            page.car_data_drop_off_location_hour_operation_link.text().should eq(car_data_texts_feature.verifications.find_by_name('car hours of operation link text').text)            
         end        
      end
      
      it "User is able to see the following informational item in the car summary: 
          Pick up and drop off location including address (if off airport), airport code (if on or off terminal), terminal/shuttle info if applicable." do 
          page = CarSelectedPage.new(driver, RSpec.configuration.env)          
          #Validate pick up location
          page.car_data_pick_up_location_text.text().should be_include(pick_up_location)                                       
          #Validate drop off location
          page.car_data_drop_off_location_text.text().should be_include(drop_off_location)                        
      end
            
      it "User is able to see the following informational item in the car summary: Unit cost and any extra days that are part of the base rate." do
          #Unit Costs: Rate description
          page = CarSelectedPage.new(driver, RSpec.configuration.env)
          #Validate text
          page.car_rate_details_texts[0].text().should be_include(car_texts_cost_feature.verifications.find_by_name('car rate text').text)
          #Validate value              
          page.car_rate_details_numbers[0].text().to_i.should be > 0
                    
          #Extra days text description          
          if (page.my_element_present?(page, 'car rate details texts', 'css'))
              #Validate extra text
              page.car_rate_details_texts.each{|extra_cost|
                extra_cost_detail = extra_cost.text()                
                if extra_cost_detail.include? car_texts_cost_feature.verifications.find_by_name('car extra text').text
                   page.car_rate_details_texts[extra_cost].should be_present()
                   #Validate values
                   page.car_rate_details_numbers.each{|extra_value|
                   extra_cost_value = extra_value.text().to_i                   
                   extra_cost_value.should > 0
                  } 
                end
              }             
          end        
      end
               
      it "User is able to see the following informational item in the car summary: Taxes and fees total." do
          #Validate link name
          page.tax_fee_link.text().should eq (car_taxes_and_fees_texts_feature.verifications.find_by_name('taxes and fees title').text)
          #Validate value taxes & fees
          page.car_taxes_fees_number.text.to_f.should be > 0          
      end   
        
      it "User is able to see the following informational item in the car summary: Total cost." do          
          estimated_total_cost = page.estimated_cost_number.text().to_f
          page.should be_numeric(estimated_total_cost)
          estimated_total_cost.should be > 0                            
      end
      
      it "An Exclusive Travel Benefit section will display showing benefits of booking with Amex." do
          page.car_exclusive_travel_benefit_section.text().should be_include(car_data_texts_feature.verifications.find_by_name('car exclusive travel benefits text').text)
      end              
    end
  end
end  
