require 'rubygems'
require 'selenium-webdriver'
require 'rails'
require 'active_record'
require 'yaml'
require 'spec_helper'
require_relative '../pages/car_search_page'
require_relative '../pages/car_results_page'
require_relative '../db/models/database_model'

describe AMEX_Car do
  describe Week_52 do
    describe "Car: AXPT-3075 - Provide ability to filter the results from the Car Matrix" do       
      driver = nil
      page = nil 

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

      it "The car search results appears in a matrix when the user makes a search" do              
        page = CarSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        #Make a valid search
        page.book_a_car('same location basic w/o discount')
        page.search_cars_button.click()
        page = CarResultsPage.new(driver, RSpec.configuration.env)
        #Check for car matrix
        page.car_matrix.present?.should == true
        sleep 1
        page.element_present?(page,'car results rental policies dialog','css').should == false        
      end   
      
      it "User is able to see a Vendor Name filter in the matrix 
          Vendor Name filter appears as a link 
          If the user clicks the link, only car cards results for that vendor are displayed (ex. Avis)
          The selected row or a column is highlighted to indicate selection when user clicks on it 
          Selection only applies to one single row or column" do    
        page = CarResultsPage.new(driver, RSpec.configuration.env)          
        #Take the url value
        vendor_img_url_value = driver.execute_script("return arguments[0].src", page.matrix_cars_first_image_source_file)
        #Check element is not highlighted
        page.my_element_present?(page,'matrix cars element highlighted','css').should == false                 
        #Click on first vendor image
        page.matrix_cars_first_image_source_file.click           
        #Check element is highlighted
        page.matrix_cars_element_highlighted.present?.should == true         
        #Take all images of vendors results
        imgs_all = Array.new
        page.cars_cards_imgs.each {|x| 
        if x.attribute("src")!= nil
          #Compare url image with image recover from page
            if vendor_img_url_value == x.attribute("src")
               imgs_all.push x.attribute("src")               
            end
        end
        }            
        #Verification value image on array                  
        imgs_all.uniq.length.should be == 1                                                               
      end
        
      it "The reset button does not appear on the page until a row or column filter is selected.
          If a row or column is selected and then a different row or column is selected, the highlight changes to the new selection.
          Every time a row or a column is selected, the page gets refreshed 
          Every time a row or a column is selected, a filter is applied to the search results " do
        #Validating Vendors columns
        page = CarResultsPage.new(driver, RSpec.configuration.env) 
        #Click on Cars vendors
        page.matrix_cars_first_image_source_file.click         
        #Click on button Reset
        page.cars_reset_button.click
        #Verify button Reset is not present
        page.element_present?(page,'cars reset button','css').should == false                   
        #Verify columns in not higlighted
        page.my_element_present?(page,'matrix cars element highlighted','css').should == false                           
          
        #Validating car classes rows   
        #Click on class car
        page.matrix_cars_first_car_class_link.click  
        #Click on button Reset
        page.cars_reset_button.click
        #Verify button Reset is not present
        page.element_present?(page,'cars reset button','css').should == false                   
        #Verify rows in not higlighted
        page.my_element_present?(page,'matrix cars element highlighted','css').should == false                                                      
      end
       
      it "User is able to see Car Classes filter in the matrix 
          Car Classes filter appears as a link
          If the user clicks the link, only car cards results for that class are displayed" do
        page = CarResultsPage.new(driver, RSpec.configuration.env) 
        #Take text value of first car class
        first_car_class_text = page.matrix_cars_first_car_class_link.text            
        #Click on first car class
        page.matrix_cars_first_car_class_link.click  
        #Verify element is highlighted
        page.matrix_cars_element_highlighted.present?.should == true                    
        #Take all cars classes displayed on the page                 
        classes_all = Array.new    
        page.car_results_car_type_titles.each {|x|
          car_class_text_found = x.text.split(' ').first
          if car_class_text_found == first_car_class_text
             classes_all.push first_car_class_text              
          end                          
        }
        #Verification value car class on array
        classes_all.uniq.length.should be == 1                  
      end
             
      it "A number of cars indicator below the matrix changes to show the number of filtered results." do
        #Count how many cars there are without select a vendor           
        before_change_car_matches = Integer(page.matches_cars_text.text.split()[0])                 
        #User clicks on second link of vendor          
        page.car_results_companies[1].click 
        #Count how many cars there are after select a vendor           
        after_change_car_matches = Integer(page.matches_cars_text.text.split()[0])
        #Check the filter has changed
        after_change_car_matches.should be <  before_change_car_matches                        
      end       
    end
  end
end
