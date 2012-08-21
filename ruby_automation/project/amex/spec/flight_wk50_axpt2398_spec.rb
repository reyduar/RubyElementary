require 'rubygems'
require 'selenium-webdriver'
require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require 'spec_helper'
require_relative '../pages/flight_search_page'
require_relative '../pages/flight_results_page'
require_relative '../db/models/database_model'

describe AMEX_Air do
  describe Week_50 do
    describe "Flight: AXPT-2398 - Provide Air search result in a price dollar matrix" do    
      driver = nil
      page = nil 
      feature = Feature.find_by_name('price dollar matrix')
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
      
      it "User should be able to see a matrix when the air results are displayed. Matrix includes a top row with the airline name/logo." do         
        page = FlightSearchPage.new(driver, RSpec.configuration.env)
        page.visit()       
        page.book_a_flight('one way - matrix options') 
        page = FlightResultsPage.new(driver, RSpec.configuration.env) 
        page.price_dollar_matrix_airline_columns.each { |airline| airline.text().should_not be_empty()}    
      end
      
      it "First column shows number of stops in ascending order: Nonstop, One stop, Two stops, etc" do 
        # Text label verification
        verifications = eval(feature.verifications.find_by_name('price dollar matrix stops rows').text)        
        page.price_dollar_matrix_stops_rows.each { |stops_row| verifications.should be_include(stops_row.text())}    
        # Ascending Order verification        
        verifications.length.times { |i| 
          page.price_dollar_matrix_stops_rows.length.times { |j| 
            if (page.price_dollar_matrix_stops_rows[j].text()  == verifications[i])
              if (j < (page.price_dollar_matrix_stops_rows.length - 1))
                page.price_dollar_matrix_stops_rows[j + 1].text().should eq(verifications[i + 1])
              end
            end
          }        
        }        
      end      
      
      it "Display price in whole US dollar value (no cents, no rounding) for the # stops and airline combination.
          If the number of stops/airline combination is not represented in the solution set then the cell will be blank (currently: underscore, not blank).
          Note: Order of Display: Airlines show from left to right is by price. Lowest price goes to the left." do
        # US dollar value number verification           
        page.price_dollar_matrix_stops_rows.length.times { |j| 
        if (j < (page.price_dollar_matrix_stops_rows.length - 1))
          page.price_dollar_matrix_us_dollar_value_row(j + 1).each_with_index { |us_dollar_value,index| 
          if !(page.numeric?(us_dollar_value))
            # US dollar value order of display verification
            if (index < (page.price_dollar_matrix_us_dollar_value_row(j + 1).length - 1))
              page.price_dollar_matrix_us_dollar_value_row(j + 1)[index + 1].text.to_i.should >= page.price_dollar_matrix_us_dollar_value_row(j + 1)[index].text.to_i
            end
          else
            us_dollar_value.strip.should eq('&mdash;') 
          end    
          }  
        end    
        }                
      end

      it "Display of a scroll bar below the matrix to scroll right to see the rest of the columns." do         
        page.price_dollar_matrix_scroll_bar.should be_present()
      end      
      
      it "Display of a collapse if the customer clicks in." do
        page.price_dollar_matrix_collapse_button.click()
        page.price_dollar_matrix_collapse_button.text().should eq('Expand')
        page.price_dollar_matrix_collapse_button.click()
        page.price_dollar_matrix_collapse_button.text().should eq('Collapse')
      end     
    end  
  end
end