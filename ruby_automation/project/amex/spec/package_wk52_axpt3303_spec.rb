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
  describe Week_52 do
    driver = nil
    page = nil    
    feature = Feature.find_by_name('sort function on package search results') 
    verifications = nil
    initial_results_url = nil
    
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
      driver.manage.delete_all_cookies()
      if example.failed?
        driver.save_screenshot("logs/screenshot_#{Time.now.strftime('%Y%m%d-%H%M%S')}.png")
      end
    end        
    
    after(:all) do
      driver.quit()
    end      
  
    describe "Package: AXPT-3303 - Provide ability to see all flight options and to sort search results" do 
      describe "A) Customer should be able to sort search results" do 
        it "On the search results there is a drop down for Sort Order. The default is to sort by best value." do
          page = PackageSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_package("simple dp search")
          page = PackageResultsPage.new(driver, RSpec.configuration.env)        
          initial_results_url = driver.current_url  
          page.sort_by_combobox.should be_present()
          page.sort_by_combobox.text().should eq(feature.verifications.find_by_name('sort by combobox text best Value').text) 
        end       
        
        it "Other options available are: Price, Star Rating, Hotel Name, Distance." do
          page.sort_by_combobox.click()
          sleep 2
          page.sort_by_combobox_values[0].text().should eq(feature.verifications.find_by_name('sort by combobox text best Value').text) 
          page.sort_by_combobox_values[1].text().should eq(feature.verifications.find_by_name('sort by combobox text price').text)
          page.sort_by_combobox_values[2].text().should eq(feature.verifications.find_by_name('sort by combobox text star rating').text)
          page.sort_by_combobox_values[3].text().should eq(feature.verifications.find_by_name('sort by combobox text hotel name').text)
          page.sort_by_combobox_values[4].text().should eq(feature.verifications.find_by_name('sort by combobox text distance').text)        
        end 
        
        it "Selecting other than best value does NOT kick off a new DP search. 
            The sort is limited to those hotels already in session returned from the initial search." do
          #  Order by : Price in Dollars
          page.sort_by_combobox_values[1].click()
          
          # does NOT kick off a new DP search #####
          sleep 2
          driver.current_url.should eq(initial_results_url)      
          #########################################          
          
          first_price = page.results_hotel_prices.first.text().to_i
          last_price = page.results_hotel_prices.last.text().to_i
          last_price.should be > first_price
          #  Order by : Hotel Name
          list_order_page = []
          list_order_sort = []
          sleep 2           
          page.sort_by_combobox.click()
          sleep 2          
          page.sort_by_combobox_values[3].click()
          
          # does NOT kick off a new DP search #####
          sleep 5
          driver.current_url.should eq(initial_results_url)      
          #########################################              
          
          num=0  
          page.results_hotel_names.each { |title_name|
            if !(title_name.text().empty?)
                list_order_page[num] = title_name.text().upcase
                num += 1 
                
            end } 
           list_order_sort = list_order_page.sort
           index=0
           list_order_sort.each do |i|
                list_order_page[index].upcase.should eq(i)
                index += 1
            end
          #  Order by : Star Rating
          page.sort_by_combobox.click()
          sleep 2           
          page.sort_by_combobox_values[2].click()
          
          # does NOT kick off a new DP search #####
          sleep 5
          driver.current_url.should eq(initial_results_url)      
          #########################################                    
          
          if(page.first_card_star_five.attribute("class")=='empty-star')
            page.second_card_star_five.attribute("class").should_not eq('full-star')
          end          
          if(page.first_card_star_four.attribute("class")=='empty-star')
            page.second_card_star_four.attribute("class").should_not eq('full-star')
          end          
          if(page.first_card_star_three.attribute("class")=='empty-star')
            page.second_card_star_three.attribute("class").should_not eq('full-star')
          end            
          
          if(page.second_card_star_five.attribute("class")=='empty-star')
            page.third_card_star_five.attribute("class").should_not eq('full-star')
          end          
          if(page.second_card_star_four.attribute("class")=='empty-star')
            page.third_card_star_four.attribute("class").should_not eq('full-star')
          end          
          if(page.second_card_star_three.attribute("class")=='empty-star')
            page.third_card_star_three.attribute("class").should_not eq('full-star')
          end            
        end 
        
        it "Next to the sort drop down there is a '?' for more information. When clicked an overlay appears with details about sort." do
          page.should_not be_element_present(page, "help sorting overlay title", "css")
          page.help_sorting_icon.click()
          page.help_sorting_overlay_title.should be_present()
        end 
      end
    
      describe "B) Customer should be able to see all flight options" do          
        it "On the DP search results in the 'Choose Your Flight' module there is a 'See All Flights' button.
            Button: See All Flights (Links to Search Results - View All Flights page)" do
          page = PackageSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_package("one adult at least in each room")
          page = PackageResultsPage.new(driver, RSpec.configuration.env)        
          page.see_all_flights_button.should be_present() 
          see_all_flights_button_text_value = driver.execute_script("return arguments[0].value" , page.see_all_flights_button)
          see_all_flights_button_text_value.should eq("SEE ALL FLIGHTS")                     
        end      
        
        it "Below the button is text explaining that it is possible to change flights and hotels prior to booking." do
          page.explanation_text_label.text.strip.should eq(feature.verifications.find_by_name('explaining label text').text)
        end 
        
        it "If clicked, the customer will go the 'See All Flights' page to see a listing of all possible flight options for the package searched." do
          page.see_all_flights_button.click()
          page = PackageResultsPage.new(driver, RSpec.configuration.env)
          page.your_hotel_text_element.text.strip.should eq("Your Hotel")          
        end                       
      end           
    end   
  end
end