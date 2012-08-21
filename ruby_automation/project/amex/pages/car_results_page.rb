require 'rubygems'
require 'selenium-webdriver'
require 'spec_helper'
require_relative '../../../lib/base_page'

class CarResultsPage < BasePage  
  def initialize(driver, test_env, *arg)
    @db_object = Page.find_by_name('car results page')
    @url = Environment.find_by_name(test_env).base_url + Page.find_by_name('car results page').url + (arg[0] || "")
    @title = Page.find_by_name('car results page').title
    @driver = driver 
  end    
  
  def car_results_error_message  
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_results_error_message = self.driver.find_element(:css => self.db_object.elements.find_by_name('car results error message').by_css_locator)
    @car_results_error_message if @car_results_error_message.displayed?
    }	
  end  
  
  def car_results_companies
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_results_companies = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car results companies').by_css_locator)
    @car_results_companies if @car_results_companies[0].displayed?
    }
  end

  def car_results_total_price_label
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_results_total_price_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('car results total price in card').by_css_locator)
    @car_results_total_price_label if @car_results_total_price_label.displayed?
    }
  end

  def car_results_price_currency
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_results_price_currency = self.driver.find_element(:css => self.db_object.elements.find_by_name('car results currency in card').by_css_locator)
    @car_results_price_currency if @car_results_price_currency.displayed?
      }
  end

  def search_error_messages_present?
    search_error_messages = []
    search_error_messages = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car results error message').by_css_locator)
    search_error_messages[0].nil? ? false : true  
  end

  def car_results_update_button
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_results_update_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('car results update button').by_css_locator)
    @car_results_update_button if @car_results_update_button.displayed?
    }
  end
  
	def pickup_date_textbox 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @pickup_date_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('pickup date textbox').by_id_locator)
	  @pickup_date_textbox if @pickup_date_textbox.displayed?
	}	
	end
	
	def dropoff_time_combobox  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @dropoff_time_combobox = self.driver.find_element(:id => self.db_object.elements.find_by_name('dropoff time combobox').by_id_locator)
	  @dropoff_time_combobox if @dropoff_time_combobox.displayed?
    }	
	end
	
  def dropoff_date_textbox 
     wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
     wait.until {
     @pickup_date_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('dropoff date textbox').by_id_locator)
     @pickup_date_textbox if @pickup_date_textbox.displayed?
     } 
  end

  def pickup_date_textbox 
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @pickup_date_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('pickup date textbox').by_id_locator)
    @pickup_date_textbox if @pickup_date_textbox.displayed?
    }	
  end

  def select_first_car 
     wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
     wait.until {
     @select_first_car = self.driver.find_element(:css => self.db_object.elements.find_by_name('car results select first car').by_css_locator)
     @select_first_car if @select_first_car.displayed?
      } 
  end

  def dropoff_time_combobox  
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @dropoff_time_combobox = self.driver.find_element(:id => self.db_object.elements.find_by_name('dropoff time combobox').by_id_locator)
    @dropoff_time_combobox if @dropoff_time_combobox.displayed?
    }	
  end
  
  def matches_cars_text 
     wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
     wait.until {
       @matches_cars_text = self.driver.find_element(:css => self.db_object.elements.find_by_name('car results matches text').by_css_locator)
       @matches_cars_text if @matches_cars_text.displayed?
     } 
   end

  def dropoff_date_textbox 
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @pickup_date_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('dropoff date textbox').by_id_locator)
    @pickup_date_textbox if @pickup_date_textbox.displayed?
    } 
  end

  def select_first_car 
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @select_first_car = self.driver.find_element(:css => self.db_object.elements.find_by_name('car results select first car').by_css_locator)
    @select_first_car if @select_first_car.displayed?
    } 
  end

  def rental_policies_dialog
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
  wait.until {
  @rental_policies_dialog = self.driver.find_element(:css => self.db_object.elements.find_by_name('car results rental policies dialog').by_css_locator)
  @rental_policies_dialog if @rental_policies_dialog.displayed?
    }
  end
  
  def rental_policies_dialog_close_btn
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
  wait.until {
  @rental_policies_dialog_close_btn = self.driver.find_element(:css => self.db_object.elements.find_by_name('car results rental policies dialog close btn').by_css_locator)
  @rental_policies_dialog_close_btn if @rental_policies_dialog_close_btn.displayed?
    }
  end
  
  def rental_policies_dialog_close_cross
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
  wait.until {
  @rental_policies_dialog_close_cross = self.driver.find_element(:css => self.db_object.elements.find_by_name('car results rental policies dialog close cross').by_css_locator)
  @rental_policies_dialog_close_cross if @rental_policies_dialog_close_cross.displayed?
    }
  end  
  
  def strikethrough_on_total_matrix
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
  wait.until {
  @strikethrough_on_total_matrix = self.driver.find_element(:css => self.db_object.elements.find_by_name('strikethrough on total matrix').by_css_locator)
  @strikethrough_on_total_matrix if @strikethrough_on_total_matrix.displayed?
    }
  end
  
  def car_matrix
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_matrix = self.driver.find_element(:css => self.db_object.elements.find_by_name('car matrix').by_css_locator)
	  @car_matrix if @car_matrix.displayed?
     }
  end
   
  def car_results_car_type_titles
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_results_car_type_titles = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car results car type titles').by_css_locator)
    @car_results_car_type_titles if @car_results_car_type_titles[0].displayed?
    }	
  end 

  def car_matrix_column_car_types_links
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_matrix_column_car_types_links = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car matrix column car types links').by_css_locator)
    @car_matrix_column_car_types_links if @car_matrix_column_car_types_links[0].displayed?
    }	
  end 

  def car_matrix_head_car_rental_company_links
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_matrix_head_car_rental_company_links = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car matrix head car rental company links').by_css_locator)
    @car_matrix_head_car_rental_company_links if @car_matrix_head_car_rental_company_links[0].displayed?
    }	
  end 

  def car_matrix_column_car_types_links
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_matrix_column_car_types_links = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car matrix column car types links').by_css_locator)
    @car_matrix_column_car_types_links if @car_matrix_column_car_types_links[0].displayed?
    }	
  end 

  def car_matrix 
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_matrix = self.driver.find_element(:css => self.db_object.elements.find_by_name('car matrix').by_css_locator)
    @car_matrix if @car_matrix.displayed?
    }	
  end   

  def car_results_first_banner_rental_company_img
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_matrix = self.driver.find_element(:css => self.db_object.elements.find_by_name('car matrix').by_css_locator)
	  @car_matrix if @car_matrix.displayed?
	  @car_results_first_banner_rental_company_img = self.driver.find_element(:css => self.db_object.elements.find_by_name('car results first banner rental company img').by_css_locator)
	  @car_results_first_banner_rental_company_img if @car_results_first_banner_rental_company_img.displayed?
      }
  end
    
  def matrix_cars_first_image_source_file
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
  wait.until {
  @matrix_cars_first_image_source_file = self.driver.find_element(:css => self.db_object.elements.find_by_name('matrix cars first image source file').by_css_locator)
  @matrix_cars_first_image_source_file if @matrix_cars_first_image_source_file.displayed?
    }
  end

  def cars_cards_imgs
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
  wait.until {
  @cars_cards_imgs = self.driver.find_elements(:css => self.db_object.elements.find_by_name('cars cards imgs').by_css_locator)
  @cars_cards_imgs if @cars_cards_imgs[0].displayed?
    }
  end   

  def matrix_cars_element_highlighted
  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
  wait.until {
  @matrix_cars_element_highlighted = self.driver.find_element(:css => self.db_object.elements.find_by_name('matrix cars element highlighted').by_css_locator)
  @matrix_cars_element_highlighted if @matrix_cars_element_highlighted.displayed?
    }
  end    
  
  def matrix_cars_first_car_class_link
  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
  wait.until {
  @matrix_cars_first_car_class_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('matrix cars first car class link').by_css_locator)
  @matrix_cars_first_car_class_link if @matrix_cars_first_car_class_link.displayed?
    }
  end  

  def cars_cards_classes
  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
  wait.until {
  @cars_cards_classes = self.driver.find_elements(:css => self.db_object.elements.find_by_name('cars cards classes').by_css_locator)
  @cars_cards_classes if @cars_cards_classes[0].displayed?
    }
  end   
  
  def cars_reset_button
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @cars_reset_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('cars reset button').by_css_locator)
    @cars_reset_button if @cars_reset_button.displayed?
      }
    end
    
  def car_results_car_type_titles
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_results_car_type_titles = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car results car type titles').by_css_locator)
    @car_results_car_type_titles if @car_results_car_type_titles[0].displayed?
      }	
  end 

  def car_matrix_column_car_types_links
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_matrix_column_car_types_links = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car matrix column car types links').by_css_locator)
    @car_matrix_column_car_types_links if @car_matrix_column_car_types_links[0].displayed?
      }	
  end 
  
  def car_matrix_head_car_rental_company_links
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_matrix_head_car_rental_company_links = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car matrix head car rental company links').by_css_locator)
    @car_matrix_head_car_rental_company_links if @car_matrix_head_car_rental_company_links[0].displayed?
      }	
  end 
  
  def car_matrix_column_car_types_links
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_matrix_column_car_types_links = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car matrix column car types links').by_css_locator)
    @car_matrix_column_car_types_links if @car_matrix_column_car_types_links[0].displayed?
      }	
  end 
  
  def car_results_first_car_rental_company_img
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_results_first_banner_rental_company_img = self.driver.find_element(:css => self.db_object.elements.find_by_name('car results first banner rental company img').by_css_locator)
    @car_results_first_banner_rental_company_img if @car_results_first_banner_rental_company_img.displayed?
    }
  end

  def matrix_cars_first_image_source_file
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @matrix_cars_first_image_source_file = self.driver.find_element(:css => self.db_object.elements.find_by_name('matrix cars first image source file').by_css_locator)
    @matrix_cars_first_image_source_file if @matrix_cars_first_image_source_file.displayed?
    }
  end

  def car_results_second_car_rental_company_img
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_results_second_car_rental_company_img = self.driver.find_element(:css => self.db_object.elements.find_by_name('car results second car rental company img').by_css_locator)
    @car_results_second_car_rental_company_img if @car_results_second_car_rental_company_img.displayed?
      }
  end

  def car_results_third_car_rental_company_img
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_results_third_car_rental_company_img = self.driver.find_element(:css => self.db_object.elements.find_by_name('car results third car rental company img').by_css_locator)
    @car_results_third_car_rental_company_img if @car_results_third_car_rental_company_img.displayed?
      }
  end
  
  def car_matrix_first_cells_prices
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_matrix_first_cells_prices = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car matrix first cells prices').by_css_locator)
    @car_matrix_first_cells_prices if @car_matrix_first_cells_prices[0].displayed?
  }	
  end 

  def car_matrix_first_banner_cell_img
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_matrix_first_banner_cell_img = self.driver.find_element(:css => self.db_object.elements.find_by_name('car matrix first banner cell img').by_css_locator)
    @car_matrix_first_banner_cell_img if @car_matrix_first_banner_cell_img.displayed?
  }
  end

  def car_book_now_pay_later_titles_banners
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_book_now_pay_later_titles_banners = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car book now pay later titles banners').by_css_locator)
    @car_book_now_pay_later_titles_banners if @car_book_now_pay_later_titles_banners[0].displayed?
  }	
  end   
  def car_cars_images
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_cars_images = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car cars images').by_css_locator)
    @car_cars_images if @car_cars_images[0].displayed?
  }	
  end   
  
  def car_first_card_data
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_first_card_data = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car first card data').by_css_locator)
    @car_first_card_data if @car_first_card_data[0].displayed?
  }	  
  end   
  
  def car_first_card_details_doors
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_first_card_details_doors = self.driver.find_element(:css => self.db_object.elements.find_by_name('car first card details doors').by_css_locator)
    @car_first_card_details_doors if @car_first_card_details_doors.displayed?
  }
  end
    
  def car_first_card_details_passengers   
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_first_card_details_passengers = self.driver.find_element(:css => self.db_object.elements.find_by_name('car first card details passengers').by_css_locator)
    @car_first_card_details_passengers if @car_first_card_details_passengers.displayed?
  }
  end

  def car_results_car_type_titles
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_results_car_type_titles = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car results car type titles').by_css_locator)
    @car_results_car_type_titles if @car_results_car_type_titles[0].displayed?
    }	
  end 

  def car_matrix_column_car_types_links
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_matrix_column_car_types_links = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car matrix column car types links').by_css_locator)
    @car_matrix_column_car_types_links if @car_matrix_column_car_types_links[0].displayed?
    }	
  end 

  def car_matrix_head_car_rental_company_links
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_matrix_head_car_rental_company_links = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car matrix head car rental company links').by_css_locator)
    @car_matrix_head_car_rental_company_links if @car_matrix_head_car_rental_company_links[0].displayed?
    }	
  end 

  def car_matrix_column_car_types_links
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_matrix_column_car_types_links = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car matrix column car types links').by_css_locator)
    @car_matrix_column_car_types_links if @car_matrix_column_car_types_links[0].displayed?
    }	
  end 

  def car_results_first_car_rental_company_img
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_results_first_car_rental_company_img = self.driver.find_element(:css => self.db_object.elements.find_by_name('car results first car rental company img').by_css_locator)
    @car_results_first_car_rental_company_img if @car_results_first_car_rental_company_img.displayed?
    }
  end

  def car_results_second_car_rental_company_img
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_results_second_car_rental_company_img = self.driver.find_element(:css => self.db_object.elements.find_by_name('car results second car rental company img').by_css_locator)
    @car_results_second_car_rental_company_img if @car_results_second_car_rental_company_img.displayed?
    }
  end

  def car_results_third_car_rental_company_img
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_results_third_car_rental_company_img = self.driver.find_element(:css => self.db_object.elements.find_by_name('car results third car rental company img').by_css_locator)
    @car_results_third_car_rental_company_img if @car_results_third_car_rental_company_img.displayed?
    }
  end

  def car_matrix_first_cells_prices
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_matrix_first_cells_prices = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car matrix first cells prices').by_css_locator)
    @car_matrix_first_cells_prices if @car_matrix_first_cells_prices[0].displayed?
    }	
  end 

  def car_matrix_first_banner_cell_img
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_matrix_first_banner_cell_img = self.driver.find_element(:css => self.db_object.elements.find_by_name('car matrix first banner cell img').by_css_locator)
    @car_matrix_first_banner_cell_img if @car_matrix_first_banner_cell_img.displayed?
      }
  end
  
  def car_first_card_details_drop_off_location    
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_first_card_details_pick_up_location = self.driver.find_element(:css => self.db_object.elements.find_by_name('car first card details drop off location').by_css_locator)
    @car_first_card_details_pick_up_location if @car_first_card_details_pick_up_location.displayed?
  }
  end  
  
  def start_a_new_search_link
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @start_a_new_search_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('start a new search link').by_css_locator)
    @start_a_new_search_link if @start_a_new_search_link.displayed?
      }
  end
  
  def car_search_pickup_location_textbox 
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_search_pickup_location_textbox  = self.driver.find_element(:id => self.db_object.elements.find_by_name('car search pickup location textbox').by_id_locator)
    @car_search_pickup_location_textbox  if @car_search_pickup_location_textbox.displayed?
  }	
  end    
    
  def car_search_dropoff_location_textbox 
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_search_dropoff_location_textbox  = self.driver.find_element(:id => self.db_object.elements.find_by_name('car search dropoff location textbox').by_id_locator)
    @car_search_dropoff_location_textbox  if @car_search_dropoff_location_textbox.displayed?
  }	
  end  
  
  def car_matrix_vendors_images
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_matrix_vendors_images = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car matrix vendors images').by_css_locator)
    @car_matrix_vendors_images if @car_matrix_vendors_images[0].displayed?
    }	
  end     
  
  def car_select_second_car_advantage_vendor      
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_select_second_car_advantage_vendor = self.driver.find_element(:css => self.db_object.elements.find_by_name('car select second car advantage vendor').by_css_locator)
    @car_select_second_car_advantage_vendor if @car_select_second_car_advantage_vendor.displayed?
  }
  end
  
  def car_results_cards 
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_results_cards = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car results cards').by_css_locator)
    @car_results_cards if @car_results_cards[0].displayed?
    }	
  end  
  
  def car_results_select_buttons 
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {  
    @car_results_select_buttons = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car results select buttons').by_css_locator)
    @car_results_select_buttons if @car_results_select_buttons[0].displayed?
    }	
  end   

  def car_loggin_button
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_loggin_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('car loggin button').by_css_locator)
    @car_loggin_button if @car_loggin_button.displayed?
      }
  end  
  
  
end