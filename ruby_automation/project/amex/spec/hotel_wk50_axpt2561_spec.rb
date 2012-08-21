require 'rubygems'
require 'selenium-webdriver'
require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require 'spec_helper'
require_relative '../pages/hotel_search_page'
require_relative '../pages/hotel_results_page'
require_relative '../db/models/database_model'

describe AMEX_Hotel do
  describe Week_50 do
    describe "Hotel: AXPT-2561 - Provide sorting functionality for Hotel search results" do    
      driver = nil
      page = nil 
      initial_results_url = nil
      feature = Feature.find_by_name('sort function on hotel search results') 
      
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
      it "On the hotel search results there is a drop down for hotel search sort order.
          The default option is to sort by Best Value." do
        page = HotelSearchPage.new(driver, RSpec.configuration.env)
        initial_results_url = driver.current_url
        page.visit()
        page.book_a_hotel('sort results hotel search')
        page = HotelResultsPage.new(driver, RSpec.configuration.env)
        page.sort_by_combobox.should be_present()
        page.sort_by_combobox.text().should eq(feature.verifications.find_by_name('sort by combobox text best Value').text) 
      end 
      it "Other options available are: Price Low to High, Star Rating, Hotel Name, Distance." do
        page.sort_by_combobox.click()
        page.sort_by_combobox_values[1].text().should eq(feature.verifications.find_by_name('sort by combobox text price').text)
        page.sort_by_combobox_values[2].text().should eq(feature.verifications.find_by_name('sort by combobox text star rating').text)
        page.sort_by_combobox_values[3].text().should eq(feature.verifications.find_by_name('sort by combobox text hotel name').text)
        page.sort_by_combobox_values[4].text().should eq(feature.verifications.find_by_name('sort by combobox text distance').text)
      end 
      it "Selecting other than Best Value kicks off a new hotel search with the sort choice as an input parameter." do
        #  Order by : Price Low to High
        page.wait_for_element_present(page, "sort by combobox","css")
        page.select_option_without_tab(page.sort_by_combobox, "Price Low to High")        
        # page.sort_by_combobox_values[1].click()
        page = nil
        page = HotelResultsPage.new(driver, RSpec.configuration.env)
        # kick off a new DP search ######################################
        sleep 2
        driver.current_url.should_not eq(initial_results_url)
        #################################################################           
        first_price = page.results_hotel_prices.first.text().to_i
        last_price = page.results_hotel_prices.last.text().to_i
        last_price.should be > first_price
        #  Order by : Hotel Name
        list_order_page = []
        list_order_sort = []
        page.wait_for_element_present(page, "sort by combobox","css")        
        page.select_option_without_tab(page.sort_by_combobox, "Hotel Name")         
        # page.sort_by_combobox.click()
        # page.sort_by_combobox_values[3].click()
        # page = HotelResultsPage.new(driver, RSpec.configuration.env)        
        
        # kick off a new DP search #####
        sleep 2
        driver.current_url.should_not eq(initial_results_url)
        #########################################    
        
        page.results_hotel_names.each_with_index { |title_name,index|
          if !(title_name.text().empty?)
              list_order_page[index] = title_name.text().upcase
          end } 
         list_order_sort = list_order_page.sort
         
         list_order_sort.each_with_index do |i,index|
              list_order_page[index].upcase.should eq(i)
          end
          
       #  Order by : Star Rating
       # page.sort_by_combobox.click()
       # page.sort_by_combobox_values[2].click()
        page.wait_for_element_present(page, "sort by combobox","css")       
        page.select_option_without_tab(page.sort_by_combobox, "Star Rating")        
       # page = HotelResultsPage.new(driver, RSpec.configuration.env)       
       
       # kick off a new DP search #####
       sleep 2
       driver.current_url.should_not eq(initial_results_url)
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
      it "All other search parameters (location, dates, # rooms, guests) are retained from the original sort." do
        location_value = driver.execute_script("return arguments[0].value" , page.destination_textbox)
        date_in_value = driver.execute_script("return arguments[0].value" , page.check_in_date_calendar)
        date_out_value = driver.execute_script("return arguments[0].value" , page.check_out_date_calendar)
        # Click: Price Low to High
        # page.sort_by_combobox.click()
        # page.sort_by_combobox_values[1].click()        
        page.wait_for_element_present(page, "sort by combobox","css")        
        page.select_option_without_tab(page.sort_by_combobox, "Price Low to High") 
        # page = HotelResultsPage.new(driver, RSpec.configuration.env)        
        location_value.should eq(feature.verifications.find_by_name('location text').text)
        hotel = Hotel.find_by_name('sort results hotel search')
        date_in_value.should eq(eval(hotel.check_in_date))
        date_out_value.should eq(driver.execute_script("return arguments[0].value" , page.check_out_date_calendar))
        page.room_text_link.text().should eq(feature.verifications.find_by_name('rooms text').text)
        page.guest_text_link.text().should eq(feature.verifications.find_by_name('guests text').text)
        # Click: Star Rating
        page.wait_for_element_present(page, "sort by combobox","css")        
        page.select_option_without_tab(page.sort_by_combobox, "Star Rating") 
        # page.sort_by_combobox.click()        
        # page.sort_by_combobox_values[2].click()
        # page = HotelResultsPage.new(driver, RSpec.configuration.env)        
        location_value.should eq(feature.verifications.find_by_name('location text').text)
        hotel = Hotel.find_by_name('sort results hotel search')
        date_in_value.should eq(eval(hotel.check_in_date))
        date_out_value.should eq(driver.execute_script("return arguments[0].value" , page.check_out_date_calendar))
        page.room_text_link.text().should eq(feature.verifications.find_by_name('rooms text').text)
        page.guest_text_link.text().should eq(feature.verifications.find_by_name('guests text').text)
        # Click: Hotel Name
        # page.sort_by_combobox.click()
        # page.sort_by_combobox_values[3].click()
        page.wait_for_element_present(page, "sort by combobox","css")        
        page.select_option_without_tab(page.sort_by_combobox, "Hotel Name") 
        # page = HotelResultsPage.new(driver, RSpec.configuration.env)        
        location_value.should eq(feature.verifications.find_by_name('location text').text)
        hotel = Hotel.find_by_name('sort results hotel search')
        date_in_value.should eq(eval(hotel.check_in_date))
        date_out_value.should eq(driver.execute_script("return arguments[0].value" , page.check_out_date_calendar))
        page.room_text_link.text().should eq(feature.verifications.find_by_name('rooms text').text)
        page.guest_text_link.text().should eq(feature.verifications.find_by_name('guests text').text)
        # Click: Distance
        page.sort_by_combobox.click()
        page.sort_by_combobox_values[4].click()
        page.wait_for_element_present(page, "sort by combobox","css")        
        page.select_option_without_tab(page.sort_by_combobox, "Distance") 
        # page = HotelResultsPage.new(driver, RSpec.configuration.env)        
        location_value.should eq(feature.verifications.find_by_name('location text').text)
        hotel = Hotel.find_by_name('sort results hotel search')
        date_in_value.should eq(eval(hotel.check_in_date))
        date_out_value.should eq(driver.execute_script("return arguments[0].value" , page.check_out_date_calendar))
        page.room_text_link.text().should eq(feature.verifications.find_by_name('rooms text').text)
        page.guest_text_link.text().should eq(feature.verifications.find_by_name('guests text').text)
      end 
    end  
  end
end
