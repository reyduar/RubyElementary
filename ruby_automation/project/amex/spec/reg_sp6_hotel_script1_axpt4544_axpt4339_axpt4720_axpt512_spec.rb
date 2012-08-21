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
require_relative '../pages/test_login_page'
require_relative '../db/models/database_model'

describe AMEX_Hotel do
  describe Sprint_06 do
    describe Script_01 do
      hotel_name_1 = "MOTEL 6"
      hotel_name_2 = "RADNOR"      
      hotel_name_3 = "RED CARPET INN"     
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
    
      describe "Hotel: AXPT-4544 - Property Card - As a customer I want to see the Average Nightly Rate shown" do 
        
        it "Login as MR User: http://amex-qa.iseatz.com/login?test_login=true. Select option 1" do
          page = TestLoginPage.new(driver, RSpec.configuration.env)
          page.visit()      
          page.test_user1_login_button.click()
        end
     
        it "Search: Philadelphia, PA 4/22-4/29, 1 room, 2 Guests" do                
          page = HotelSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.enter_airport(page.destination_textbox,"Philadelphia, PA, US") 
          page.select_option(page.rooms_combobox, "1")       
          page.select_option(page.adults_combobox(1), "2")       
          page.check_in_date_textbox.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          page.check_out_date_textbox.send_keys(eval('(Time.now + (9 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          page.select_option(page.rooms_combobox, "1")    
          page.select_option(page.adults_combobox(1), "2")      
          page.search_hotels_button.click()
          page = HotelResultsPage.new(driver, RSpec.configuration.env)             
        end
              
        it "Scroll down to view hotel rate card" do
          driver.execute_script("scroll(0,15000);")
          sleep 3
          driver.execute_script("scroll(0,15000);")  
          sleep 3    
          page = nil
          page = HotelResultsPage.new(driver, RSpec.configuration.env)        
          page.results_hotel_cards.should_not be_nil()
          sleep 3
        end  
      end

      describe "Hotel: AXPT-4339 - Property Card - As a customer I want to see hotels that are book now pay later" do 
        it "Remain on results for Philadelphia, PA 4/22-4/29. Scroll down to view ""Book Now, Pay Later"" banner. 
            Hotels with this banner: Radnor, Motel 6, Red Carpet Inn." do  
          if !(page.hotel_card_book_now_pay_later_divs.nil?)      
            page.results_hotel_names.each_with_index { |title_name, index|
            if !(title_name.text().empty?)
              if (title_name.text().upcase.include?(hotel_name_1) || title_name.text().upcase.include?(hotel_name_2) ||  title_name.text().upcase.include?(hotel_name_3))              
                book_now_pay_later_div = driver.execute_script("return arguments[0].getElementsByClassName('booknowpaylater')" , page.results_hotel_cards[index]) 
                book_now_pay_later_div.should_not be_nil()
                break 
              end                         
            end} 
          end                           
        end      
      end      
        
      describe "Hotel: AXPT-4720 - Hotel Filter - As a customer I want to see program information on the hotel search tab" do 
      
        it "Remain on results for Philadelphia, PA 4/22-4/29. View LRG banner for logged in users. Preview logos on LRG banner." do  
          page.lowest_rate_guaranteed_banner_title.text.should eq("LOWEST RATE GUARANTEED")  
          page.lowest_rate_guaranteed_banner_points_logos.should be_present()               
        end   
          
        it "Scroll up, above LRG banner 'Select a program' overlay" do  
          pending("this funcionality is not implemented yet on the page. More info on bug AXPT-6385")
        end
        
      end
      
      describe "Hotel: AXPT-512 - Property Card - As a marketer I want to show a 2X MR/PWP promotion" do 
      
        it "For any logged in MR eligible member the promo for 2X MR points / PWP will display on every merchant property card" do  
          page.lowest_rate_guaranteed_banner_title.text.should eq("LOWEST RATE GUARANTEED")         
          page.should be_my_element_present(page, "hotel card pay points divs", "css")         
        end   
   
        it "Login as Test User2 (Profile, Not Enrolled, Not Eligible). For any logged in non-MR eligible member the promo will not display." do
          page = TestLoginPage.new(driver, RSpec.configuration.env)
          page.visit()      
          page.logout_button.click()        
          page.visit()      
          page.test_user2_login_button.click()
        end            
      
        it "Search: Philadelphia, PA 4/22-4/29, 1 room, 2 Guests" do                
          page = HotelSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.enter_airport(page.destination_textbox,"Philadelphia, PA, US") 
          page.select_option(page.rooms_combobox, "1")       
          page.select_option(page.adults_combobox(1), "2")       
          page.check_in_date_textbox.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          page.check_out_date_textbox.send_keys(eval('(Time.now + (9 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          page.select_option(page.rooms_combobox, "1")    
          page.select_option(page.adults_combobox(1), "2")      
          page.search_hotels_button.click()
          page = HotelResultsPage.new(driver, RSpec.configuration.env)             
        end  
          
        it "Scroll down to view hotel rate card" do
          driver.execute_script("scroll(0,15000);")
          sleep 3
          driver.execute_script("scroll(0,15000);")  
          sleep 3    
          page = nil
          page = HotelResultsPage.new(driver, RSpec.configuration.env)        
          page.results_hotel_cards.should_not be_nil()
          sleep 3
        end            
                    
        it "For any logged in non-MR eligible member the promo for 2X MR points / PWP will NOT display on every merchant property card" do  
          page.lowest_rate_guaranteed_banner_title.text.should eq("LOWEST RATE GUARANTEED")   
          page.should_not be_my_element_present(page, "lowest rate guaranteed banner points logos", "css")          
          page.should_not be_my_element_present(page, "hotel card pay points divs", "css")
        end
        
        it "Login as Test User4 (Enrolled, Not Eligible)." do
          page = TestLoginPage.new(driver, RSpec.configuration.env)
          page.visit()      
          page.logout_button.click()        
          page.visit()      
          page.test_user4_login_button.click()
        end            
      
        it "Search: Philadelphia, PA 4/22-4/29, 1 room, 2 Guests" do                
          page = HotelSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.enter_airport(page.destination_textbox,"Philadelphia, PA, US") 
          page.select_option(page.rooms_combobox, "1")       
          page.select_option(page.adults_combobox(1), "2")       
          page.check_in_date_textbox.send_keys(eval('(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          page.check_out_date_textbox.send_keys(eval('(Time.now + (9 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'))
          page.select_option(page.rooms_combobox, "1")    
          page.select_option(page.adults_combobox(1), "2")      
          page.search_hotels_button.click()
          page = HotelResultsPage.new(driver, RSpec.configuration.env)             
        end  
          
        it "Scroll down to view hotel rate card" do
          driver.execute_script("scroll(0,15000);")
          sleep 3
          driver.execute_script("scroll(0,15000);")  
          sleep 3    
          page = nil
          page = HotelResultsPage.new(driver, RSpec.configuration.env)        
          page.results_hotel_cards.should_not be_nil()
          sleep 3
        end            
          
        it "For any logged in non-MR eligible member the promo for 2X MR points / PWP will NOT display on every merchant property card" do  
          page.lowest_rate_guaranteed_banner_title.text.should eq("LOWEST RATE GUARANTEED")  
          page.should_not be_my_element_present(page, "lowest rate guaranteed banner points logos", "css")          
          page.should_not be_my_element_present(page, "hotel card pay points divs", "css")         
        end                        
      end            
      
    end      
  end
end