require 'rubygems'
require 'selenium-webdriver'
require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require 'spec_helper'
require_relative '../pages/package_search_page'
require_relative '../pages/package_results_page'
require_relative '../db/models/database_model'

describe AMEX_Package do
  describe Sprint_05 do
    describe "Package: AXPT-3802 - Provide ability to to see alerts on the expanded Air rate card" do    
      driver = nil
      page = nil 
      feature = Feature.find_by_name('dp result flight matrix feature') 
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
      it "All flight options are returned in a matrix." do
        page = PackageSearchPage.new(driver, RSpec.configuration.env)
        page.visit()
        page.book_a_package("round trip flight rate card alert")
        page = PackageResultsPage.new(driver, RSpec.configuration.env)
        page.see_all_flights_button.click()
        page.all_flight_matrix.should be_present()        
      end  
      
      it "There is a maximum of 4 rows, including the row for the airline name/logo." do
        number_row = 0
        page.all_flight_matrix_rows.each_with_index { |row,index|number_row = index}
        number_row.to_i.should be <= 4
      end
      
      it "The top row shows airline name and logo." do
        page.all_flight_matrix_top_row_airline_names.each_with_index { |airline_name,index| 
        airline_name.should be_present() 
        }
        page.all_flight_matrix_top_row_airline_logos.each_with_index { |airline_logo,index| 
        airline_logo.attribute("alt").should be_present() 
        }
      end

      it "The order in which the airlines show from left to right is determined by package price. Lowest price goes to the left." do
        page.all_flight_matrix_ammounts.each_with_index{ |ammount,index| 
        price = ammount.text().sub(/,/,".").to_f
        if(index==0)
          price.should be >= 0
        else
          price.should be >= page.all_flight_matrix_ammounts[index-1].text().sub(/,/,".").to_f
        end
      }
      end
      
      it "The page shows 8 columns of airlines. A scroll bar below the matrix is available to scroll right to see the rest. 
        The scroll bar starts at the start of the first carrier column, not under the number of stops column." do
        number_column = 0
        page.all_flight_matrix_airline_columns.each_with_index { |column,index| number_column = index }
        if(number_column>=7)
         page.all_flight_matrix_slider.should be_present() 
        else
         page.my_element_present?(page,'all flight matrix slider','css').should == false
        end 
      end
      
      it "The first column shows nonstop, one stop, 2+ stops in ascending order." do
        page.all_flight_matrix_stop_columns.each_with_index { |stop_column,index| 
        if(stop_column.text().eql?("Non-Stop"))
          number_stop="0"
        else
          number_stop = /[0-9]/.match(stop_column.text()).to_s
        end
        if(index==0)
          number_stop.to_i.should be >= 0
        else
         if(page.all_flight_matrix_stop_columns[index-1].text().eql?("Non-Stop"))
          before_number = "0"
         else 
          before_number = /[0-9]/.match(page.all_flight_matrix_stop_columns[index-1].text()).to_s
         end
          number_stop.to_i.should be >= before_number.to_i
        end
        }
      end
      
      it "At a maximum the search will return 2 stops greater than the option with the fewest stops. 
         So if nonstops are available on the search the max that would be returned is 2+ stops. 
         If 1 stops are available the max that would be returned is 2+ stops." do
        stop_column = page.all_flight_matrix_stop_columns[0].text()
        if(stop_column.eql?("Non-Stop"))
         less_number="0"
        else
         less_number = /[0-9]/.match(stop_column).to_s
        end
        stop_column = page.all_flight_matrix_stop_columns.last.text()
        if(stop_column.eql?("Non-Stop"))
         max_number="0"
        else
         max_number = /[0-9]/.match(stop_column).to_s
        end
        max_number.to_i.should_not be > less_number.to_i + 2
      end
      
      it "There will be links to taxes and fees (copy below) and airline baggage charges (AXPT-417) underneath the matrix. 
         When clicked each will produce an overlay. The tax overlay will be a general one with information on air and hotel taxes (see below). 
         the baggage overlay will be the same used in the air stand alone path." do
        page.all_flight_baggage_charges_link.text().should eq(feature.verifications.find_by_name('baggage charges link text').text)
        page.all_flight_taxes_and_fees_link.text().should eq(feature.verifications.find_by_name('taxes and fees link text').text)
        page.all_flight_baggage_charges_link.click()
        page.all_flight_baggage_fees_title.text().should eq(feature.verifications.find_by_name('baggage charges title text').text)
        page.all_flight_baggage_fees_close_button.click()
        page.all_flight_taxes_and_fees_link.click()
        page.all_flight_packages_taxes_and_fees_title.text().should eq(feature.verifications.find_by_name('packages taxes and fees title text').text)
        page.all_flight_packages_taxes_and_fees_close_button.click()
      end
      
      it "There is a collapse option that hides the matrix if the customer clicks it. Upon click, the matrix portion only collapses 
         and the option becomes an expand." do
        # Verification expand matrix
        page.all_flight_matrix.should be_present() 
        page.all_flight_collapse_expand_button.text().should eq(feature.verifications.find_by_name('collapse button text').text)
        # Verification colapse matrix
        page.all_flight_collapse_expand_button.click()
        page.all_flight_collapse_expand_button.text().should eq(feature.verifications.find_by_name('expand button text').text)
      end
    end  
  end
end