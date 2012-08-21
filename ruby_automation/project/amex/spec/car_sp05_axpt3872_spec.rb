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
    describe "Car: AXPT-3872 - Provide ability to enter all passenger information" do    
      driver = nil
      page = nil        
      airline_name = nil
      driver_user_name = nil
      driver_last_name = nil
      driver_email_name = nil
      driver_phone_numer = nil  
      checkboxes_value = nil     
      style_driver_info_container = nil
      style_payment_info_container = nil
      style_car_your_book_info_container = nil
            
      car_driver_info_texts_feature = Feature.find_by_name('car driver info texts') 
      car_driver_info_error_texts_feature = Feature.find_by_name('car driver info error texts')
      
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
     
      it "The user is able to see a 'Who is Driving?' section. 
          The section is numbered as section 1 always and the default is to have the section expanded." do
          #Navigate to search car
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('same location basic w/o discount')
          page.search_cars_button.click()
          page = CarResultsPage.new(driver, RSpec.configuration.env)     
          #Click on first car
          page.select_first_car.click()          
          page = CarSelectedPage.new(driver, RSpec.configuration.env)                             
          page.car_driver_info_section_number.text().to_i.should eq(car_driver_info_texts_feature.verifications.find_by_name('driver info section number').text.to_i)
          style_driver_info_container = page.car_driver_info_container.attribute("style")
          page.car_driver_info_container.present?.should be true  
      end
        
      it "The user is able to see a text link regarding ages and a Read age policy.
          If clicked, it will produce an overlay with the vendor's age policy." do                   
          page.car_read_age_policy_link.text().should eq(car_driver_info_texts_feature.verifications.find_by_name('driver read age policy link text').text)           
          page.car_read_age_policy_link.click()
          sleep(2)          
          page.car_overlay_age_policy_title.text().should eq(car_driver_info_texts_feature.verifications.find_by_name('overlay age policy text').text.upcase)          
          page.car_overlay_age_policy_close_button.click()                   
      end
            
      it "The user is able to see field for first name." do
          page.car_driver_info_first_name_textbox.present?.should be true
      end
      
      it "The user is able to see field for middle name." do
          page.car_driver_info_middle_name_textbox.present?.should be true   
      end
      
      it "The user is able to see field for last name." do
          page.car_driver_info_last_name_textbox.present?.should be true 
      end
      
      it "The user is able to see an email address field." do
          page.car_driver_info_email_texbox.present?.should be true 
      end
      
      it "The user is able to see a phone number field." do
          page.car_driver_info_phone_number_texbox.present?.should be true 
      end         
                       
      it "The first name field is required and error message is shown when it is omitted." do
          page.car_driver_info_labels[0].text().should be_include(car_driver_info_texts_feature.verifications.find_by_name('driver info require field').text)         
          #Complete required fields except First Name.
          page.car_driver_info_last_name_textbox.send_keys("Gabriel")
          page.car_driver_info_email_texbox.send_keys("peter.gabriel@gmail.com")
          page.car_driver_info_phone_number_texbox.send_keys("2124567777")          
          page.car_driver_info_save_button.click()
          sleep(1)
          page.car_driver_info_error_messages[0].text().should eq(car_driver_info_error_texts_feature.verifications.find_by_name('driver info first name field required').text)
      end
      
      it "The middle name field is optional." do                 
          page.car_driver_info_labels[1].text().should be_include(car_driver_info_texts_feature.verifications.find_by_name('driver info optional field').text) 
      end
      
      it "The last name field is required and error message is shown when it is omitted." do        
          page.car_driver_info_labels[2].text().should be_include(car_driver_info_texts_feature.verifications.find_by_name('driver info require field').text)         
          #Add first name
          page.car_driver_info_first_name_textbox.send_keys("Peter")
          #Remove last name         
          driver.execute_script("arguments[0].value = ''" , page.car_driver_info_last_name_textbox)          
          page.car_driver_info_save_button.click()
          sleep (1)
          page.car_driver_info_error_messages[0].text().should eq(car_driver_info_error_texts_feature.verifications.find_by_name('driver info last name field required').text)
      end              
              
      it "The user is able to see an email address is required. An error message is shown when the email is omitted." do
          page.car_driver_info_labels[3].text().should be_include(car_driver_info_texts_feature.verifications.find_by_name('driver info require field').text)                             
          #Add last name
          page.car_driver_info_last_name_textbox.send_keys("Gabriel")
          #Remove email
          driver.execute_script("arguments[0].value = ''" , page.car_driver_info_email_texbox)         
          page.car_driver_info_save_button.click()
          sleep (1)
          page.car_driver_info_error_messages[0].text().should eq(car_driver_info_error_texts_feature.verifications.find_by_name('driver info email field required').text) 
          page.car_driver_info_error_messages[1].text().should eq(car_driver_info_error_texts_feature.verifications.find_by_name('driver info email field invalid').text)                      
      end
              
      it "An error message is shown when the email has an invalid format." do
          #Remove email
          driver.execute_script("arguments[0].value = ''" , page.car_driver_info_email_texbox)
          #Add invalid format email
          page.car_driver_info_email_texbox.send_keys("peter.gabriel.gmail.com")        
          page.car_driver_info_save_button.click()
          sleep (1)
          page.car_driver_info_error_messages[0].text().should eq(car_driver_info_error_texts_feature.verifications.find_by_name('driver info email field invalid').text) 
      end
              
      it "The user is able to see a phone number field that is required. An error message is shown when the phone number is omitted." do
          page.car_driver_info_labels[4].text().should be_include(car_driver_info_texts_feature.verifications.find_by_name('driver info require field').text)
          #Add email
          page.car_driver_info_email_texbox.send_keys("peter.gabriel@gmail.com")
          #Remove phone number
          driver.execute_script("arguments[0].value = ''" , page.car_driver_info_phone_number_texbox)      
          page.car_driver_info_save_button.click()
          sleep (1)      
          page.car_driver_info_error_messages[0].text().should eq(car_driver_info_error_texts_feature.verifications.find_by_name('driver info phone number field required').text) 
      end 
        
      it "An error message is shown when the phone number has an invalid format." do                
          #Remove phone number
          driver.execute_script("arguments[0].value = ''" , page.car_driver_info_phone_number_texbox)
          #Add invalid phone number
          page.car_driver_info_phone_number_texbox.send_keys("2124567777-1234")           
          page.car_driver_info_save_button.click()
          sleep (1)                          
          page.car_driver_info_error_messages[0].text().should eq(car_driver_info_error_texts_feature.verifications.find_by_name('driver info phone number field invalid').text) 
      end
        
      it "The user is able to see a 'Loyalty information' fiels that is optional." do
          page.car_driver_info_loyalty_program_texbox.present?.should be true                   
          page.car_driver_info_labels[5].text().should_not be_include(car_driver_info_texts_feature.verifications.find_by_name('driver info require field').text)
      end
        
      it "There is text saying to validate the number carefully as there will be no validation done into 'Loyalty information'." do
          page.car_driver_info_check_loyalty_number_text.text().should eq(car_driver_info_texts_feature.verifications.find_by_name('driver info check loyalty number').text)
      end
       
      it "There is an expandible section on the page for special equipment." do
          page.car_driver_info_driver_has_special_equipment_requests_link.present?.should be true                 
          page.car_driver_info_driver_has_special_equipment_requests_section_expanded.present?.should be true 
          sleep(2)
      end
        
      checkboxes_all = Array.new 
      it "When expanded this section will list each special equipment option with a check box. A Car Seat - Infant checkbox is shown." do
          page.car_driver_info_driver_special_requests_checkboxes.each{|checxboxes_text|                   
          checkboxes_all.push checxboxes_text.text()
          }  
          checkboxes_all[0].should eq(car_driver_info_texts_feature.verifications.find_by_name('driver special requests car seat infant checkboxes text').text)          
      end
        
      it "When expanded this section will list each special equipment option with a check box. A Car Seat - Toddler checkbox is shown." do
          checkboxes_all[1].should eq(car_driver_info_texts_feature.verifications.find_by_name('driver special requests car seat toddler checkboxes text').text) 
      end
        
      it "When expanded this section will list each special equipment option with a check box. Navigation System checkbox is shown." do
          checkboxes_all[2].should eq(car_driver_info_texts_feature.verifications.find_by_name('driver special requests navigation system checkboxes text').text) 
      end
        
      it "When expanded this section will list each special equipment option with a check box. Luggage Rack checkbox is shown." do
          checkboxes_all[3].should eq(car_driver_info_texts_feature.verifications.find_by_name('driver special requests luggage rack checkboxes text').text) 
      end
        
      it "When expanded this section will list each special equipment option with a check box. Bicycle Rack is shown." do
          checkboxes_all[4].should eq(car_driver_info_texts_feature.verifications.find_by_name('driver special requests bicycle rack checkboxes text').text) 
      end 
        
      it "When expanded this section will list each special equipment option with a check box. Ski Rack checkbox is shown." do
          checkboxes_all[5].should eq(car_driver_info_texts_feature.verifications.find_by_name('driver special requests ski rack checkboxes text').text) 
      end
        
      it "When expanded this section will list each special equipment option with a check box. Snow Chains checkbox is shown." do
          checkboxes_all[6].should eq(car_driver_info_texts_feature.verifications.find_by_name('driver special requests snow chains checkboxes text').text) 
      end
        
      it "When expanded this section will list each special equipment option with a check box. Trailer Hitch checkbox is shown." do
          checkboxes_all[7].should eq(car_driver_info_texts_feature.verifications.find_by_name('driver special requests trailer hitch checkboxes text').text) 
      end
        
      it "When expanded this section will list each special equipment option with a check box. Left Hand Control checkbox is shown." do
          checkboxes_all[8].should eq(car_driver_info_texts_feature.verifications.find_by_name('driver special requests left hand control checkboxes text').text) 
      end
        
      it "When expanded this section will list each special equipment option with a check box. Right Hand Control checkbox is shown." do
          checkboxes_all[9].should eq(car_driver_info_texts_feature.verifications.find_by_name('driver special requests right hand control checkboxes text').text) 
      end
                
      it "There will be text explaining that these are not guaranteed and to check with the vendor." do
          page.car_driver_info_driver_special_requests_text.text().should be_include(car_driver_info_texts_feature.verifications.find_by_name('driver info special requests not guarenteed text').text)
      end
       
      it "There will be text explaining a max of 3. A max of 3 special equipment selects are possible." do
          page.car_driver_info_driver_special_requests_text.text().should be_include(car_driver_info_texts_feature.verifications.find_by_name('driver info special requests a max of 3 special equipment text').text)
          page.car_driver_info_driver_special_requests_checkboxes[0].click()
          page.car_driver_info_driver_special_requests_checkboxes[1].click()
          page.car_driver_info_driver_special_requests_checkboxes[2].click()   
          sleep(2)            
          checkboxes_checked = Array.new  
          page.car_driver_info_driver_special_requests_checkboxes.each{|checkboxes_text|                        
              checkboxes_value = checkboxes_text.attribute("class").split(" ").last                                                                         
              if checkboxes_value == car_driver_info_texts_feature.verifications.find_by_name('driver info driver special requests checkboxes checked').text
                 checkboxes_checked.push checkboxes_value                       
              end                          
           }  
           checkboxes_checked.length.should eq(3)   
      end
      
      it "The section can be collapsed after being viewed." do
          page.car_driver_info_driver_has_special_equipment_requests_link.click()
          page.car_driver_info_driver_has_special_equipment_requests_section_collapsed.present?.should be true    
      end

      it "There will be an optional section for flight information." do
          page.car_driver_info_labels[6].present?.should be true
          page.car_driver_info_labels[6].text().should eq(car_driver_info_texts_feature.verifications.find_by_name('driver info drivers flight information text').text)                       
      end
        
      it "There will be a drop down for airlines. A single airline selection can be made. Default value should be 'Select Airline'." do
          page.car_driver_info_driver_airlines_combobox.present?.should be true
          page.car_driver_info_driver_airlines_combobox_arrow.click()
          sleep(1)
          page.car_driver_info_driver_airlines_items_combobox[0].text().should eq(car_driver_info_texts_feature.verifications.find_by_name('driver first element airline combobox text').text)            
      end
        
      it "There will be an entry box for flight number." do
          page.my_element_present?(page,'car driver info driver flight number textbox','id').should == true
      end
        
      it "Both airline and flight number should be entered but if only one is present then field validation should not stop the booking. The booking request would just go on without the information if its not complete.
          Comment: Scenario automated includes select an airline from the dropdown list and doesn't enter values into flight number texbox." do
          airline_name = page.car_driver_info_driver_airlines_items_combobox[2].text()
          page.car_driver_info_driver_airlines_items_combobox[2].click()
          airline_name.should eq(page.car_driver_info_driver_airlines_combobox.text())            
      end
      
      it "When 'Save and Continue' is clicked: the section collapses into a blue line with text and Edit Button." do
          page.car_driver_info_phone_number_texbox.send_keys("2124567777")
          driver_user_name = page.car_driver_info_first_name_textbox.text()
          driver_last_name = page.car_driver_info_last_name_textbox.text()
          driver_email_name = page.car_driver_info_email_texbox.text()
          driver_phone_numer = page.car_driver_info_phone_number_texbox.text()
          page.car_driver_info_save_button.click()
          sleep (1)                   
          page.car_driver_info_edit_button.present?.should be true 
          
          #Validate Who is driving section is collapsed           
          if page.my_element_present?(page,'car driver info container','css')
             if style_driver_info_container == ""
                style_driver_info_container = "expanded"
                style_driver_info_container.should eq(car_driver_info_texts_feature.verifications.find_by_name('driver info expanded container').text)
             end
          end                                  
      end
            
      it "Next section 'Payment' or 'Book you car' will automatically expanded. 
          Comment: The sections are expanded depending of car's vendor." do
          if page.my_element_present?(page,'car payment info warning text','css')
             #Book you car section is expanded
             page.car_book_you_car_info_container.present?.should be true 
             style_car_your_book_info_container = page.car_book_you_car_info_container.attribute("style")  
             style_payment_info_container = "collapsed"  
             style_car_your_book_info_container = "expanded"              
          else
               #Payment section is expanded.
               page.car_payment_info_container.present?.should be true  
               style_payment_info_container = page.car_payment_info_container.attribute("style")  
               style_payment_info_container = "expanded"   
               style_car_your_book_info_container = "collapsed"                 
          end
      end
              
      it "If the Edit button is clicked then the section 'Who is driving' will re-expand with all previously entered data present.
          Comment: 'Payment' or 'Book your car' section is collapsed after expand 'Who is driving' section." do
          page.car_driver_info_edit_button.click()  
          page.car_driver_info_container.present?.should be true          
          driver_user_name.should eq(page.car_driver_info_first_name_textbox.text())
          driver_last_name.should eq(page.car_driver_info_last_name_textbox.text())
          driver_email_name.should eq(page.car_driver_info_email_texbox.text())
          driver_phone_numer.should eq(page.car_driver_info_phone_number_texbox.text()) 
          airline_name.should eq(page.car_driver_info_driver_airlines_combobox.text())           
          
          #Validate driver Payment section is collapsed           
          if page.my_element_present?(page,'car payment info container','css')
             #Element is on the page but it is not visible              
             if style_payment_info_container == "collapsed"                           
                style_payment_info_container.should eq(car_driver_info_texts_feature.verifications.find_by_name('driver info collapsed container').text)
             else               
                  style_payment_info_container.should eq(car_driver_info_texts_feature.verifications.find_by_name('driver info expanded container').text)
             end
          end 
          
          #Validate driver Book your car section is collapsed 
          if page.my_element_present?(page,'car book you car info container','css')
             #Element is on the page but it's not visible                                  
             if style_car_your_book_info_container == "collapsed"
                style_car_your_book_info_container.should eq(car_driver_info_texts_feature.verifications.find_by_name('driver info collapsed container').text)
                else
                    style_car_your_book_info_container.should eq(car_driver_info_texts_feature.verifications.find_by_name('driver info expanded container').text)
             end             
          end            
        end                                  
     end
  end
end
