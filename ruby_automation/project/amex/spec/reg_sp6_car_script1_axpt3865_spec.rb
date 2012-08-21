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
  describe Sprint_06 do
    describe Script_01 do    
      describe "Car: AXPT-3865 - IZ_Tested - Provide ability to see a recap of my car itinerary." do     
        page = nil 
        driver = nil
        imgs_indexs = Array.new        
        car_matrix_vendor_image = Feature.find_by_name('car matrix vendor image')
        car_sections_numbers_texts = Feature.find_by_name('car sections numbers texts')
                
        before(:all) do
          browser = RSpec.configuration.browser
          case browser
          when "firefox"
            driver = Selenium::WebDriver.for :firefox
          else
            puts "Error: Case statment needs a valid browser string!"
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
        
        it "Make one booking without a card.
            Comment: Advantage vendor is the vendor available for don't complete Payment section." do        
            page = CarSearchPage.new(driver, RSpec.configuration.env)
            page.visit()
            page.book_a_car('same location basic w/o discount')            
            page.search_cars_button.click()           
            page = CarResultsPage.new(driver, RSpec.configuration.env)                
            page.cars_cards_imgs.each_with_index { |images,index|                     
            if images.attribute("src")!= nil
               vendor_image = images.attribute("src").split("/").last
               if vendor_image == car_matrix_vendor_image.verifications.find_by_name('car matrix advantage rent a car vendor image').text
                  imgs_indexs.push index                                               
               end
            end
            }                    
            page.car_results_select_buttons[imgs_indexs[1]].click()              
        end   

        it "Show the section 'Payment' is collapsible." do
            page = CarSelectedPage.new(driver, RSpec.configuration.env)         
            page.should_not be_element_present(page, 'car payment info container', 'css')                         
        end        
        
        it "Show the section 'Book You Car' is collapsible." do            
            page.should_not be_element_present(page, 'car book you car info container', 'css')                         
        end  

        it "Show that the 'Payment' section contains appropriate title.
            Comment: Only validate title's section. Other elements into section are not displayed." do            
            page.car_sections_titles[1].text().should eq(car_sections_numbers_texts.verifications.find_by_name('car payment section title').text)              
        end        
        
        it "Show that the 'Payment' section contains appropriate number.
            Comment: Only validate number's section. Other elements into section are not displayed." do
            page.car_sections_numbers[1].text().should eq(car_sections_numbers_texts.verifications.find_by_name('car payment secion number').text)  
        end
        
        it "Show that the 'Book Your Car' section contains appropriate title.
            Comment: Only validate title's section. Other elements into section are not displayed." do            
            page.car_sections_titles[2].text().should eq(car_sections_numbers_texts.verifications.find_by_name('car book you car section title').text)             
        end        
        
        it "Show that the 'Book Your Car' section contains appropriate number.
            Comment: Only validate number's section. Other elements into section are not displayed." do
            page.car_sections_numbers[2].text().should eq(car_sections_numbers_texts.verifications.find_by_name('car book you car section number').text) 
        end         
      end                  
    end
  end
end  
