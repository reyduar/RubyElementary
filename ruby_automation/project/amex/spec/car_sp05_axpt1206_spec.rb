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
    describe "Car: AXPT-1206 - Review Car | As a customer I want to see my progress on the booking path and options to get help" do
      driver = nil
      page = nil
      car_breadcrumbs_and_help_texts_feature = Feature.find_by_name('car breadcrumbs and help texts') 
      
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
      
      it "On the check out page there will be breadcrumbs that show progress down the booking path.
          For the car path there will be only 2 crumbs - Check Out and Confirmation. Check Out will be highlighted.
          There is no navigation with the breadcrumbs, they are informational only." do
          #Navigate to search car
          page = CarSearchPage.new(driver, RSpec.configuration.env)
          page.visit()
          page.book_a_car('same location basic w/o discount')
          page.search_cars_button.click()
          page = CarResultsPage.new(driver, RSpec.configuration.env)
          #Click on first car button found
          page.select_first_car.click()
          #Validate crumb checkout
          page = CarSelectedPage.new(driver, RSpec.configuration.env)                       
          page.car_checkout_crumb.text.should eq (car_breadcrumbs_and_help_texts_feature.verifications.find_by_name('car checkout crumb text').text.upcase)                   
          #Validate arrow between checkout and confirmation crumbs
          page.car_arrow_crumb.present?.should == true
          #Validate crumb confirmation
          page.car_confirmation_crumb.text.should eq (car_breadcrumbs_and_help_texts_feature.verifications.find_by_name('car confirmation crumb text').text.upcase)                                                    
      end
      
      it "Within the same progress bar is 'Need Help? Call Us' with the customer service phone number. 
          The phone number to use is 1-800-297-2977.
          Comment:This Acceptance Criteria does not match with JIRA story because it was updated but not reflected on JIRA." do                        
          #Validate text in progress bar 
          page.progress_bar_help_text_label.text.should eq (car_breadcrumbs_and_help_texts_feature.verifications.find_by_name('car need help text').text)                                                              
      end      
      
      it "Below the progress bar there will be a Help With This Page link that." do          
          #Validate text in link          
          page.help_with_this_page_link.text.should eq (car_breadcrumbs_and_help_texts_feature.verifications.find_by_name('car need help with this page text').text)                    
      end
      
      it "When clicked, will show an overlay with help text.
          Comment: Overlay does not open after clicking on it. Its text has not been defined yet." do          
          pending("this funcionality is not implemented yet on the page.")              
      end
    end
  end
end