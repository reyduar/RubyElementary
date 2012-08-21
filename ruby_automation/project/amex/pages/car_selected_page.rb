require 'rubygems'
require 'selenium-webdriver'
require 'spec_helper'
require_relative '../../../lib/base_page'

class CarSelectedPage < BasePage  
  def initialize(driver, test_env, *arg)
    @db_object = Page.find_by_name('car selected page')
    @url = Environment.find_by_name(test_env).base_url + Page.find_by_name('car selected page').url + (arg[0] || "")
    @title = Page.find_by_name('car selected page').title
    @driver = driver 
  end    

  def change_car_link
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @change_car_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('change car link').by_css_locator)
	  @change_car_link if @change_car_link.displayed?
	  }	
  end  

  def tax_fee_link
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @tax_fee_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('taxes and fee link').by_css_locator)
	  @tax_fee_link if @tax_fee_link.displayed?
      }
  end

  def tax_fee_dialog
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @tax_fee_dialog = self.driver.find_element(:id => self.db_object.elements.find_by_name('taxes and fee dialog').by_id_locator)
	  @tax_fee_dialog if @tax_fee_dialog.displayed?
      }
  end
  
  def tax_fee_dialog_close_icon
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @tax_fee_dialog_close_icon = self.driver.find_element(:css => self.db_object.elements.find_by_name('taxes and fee dialog close icon').by_css_locator)
	  @tax_fee_dialog_close_icon if @tax_fee_dialog_close_icon.displayed?
      }
  end
 
  def review_your_car_label 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @review_your_car_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('review your car label').by_css_locator)
	  @review_your_car_label if @review_your_car_label.displayed?
      }
  end
  
  def progress_bar_help_text_label 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @progress_bar_help_text_label = self.driver.find_element(:class => self.db_object.elements.find_by_name('progress bar help text label').by_class_locator)
	  @progress_bar_help_text_label if @progress_bar_help_text_label.displayed?
      }
  end  

  def help_with_this_page_link 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @help_with_this_page_link = self.driver.find_element(:link_text => self.db_object.elements.find_by_name('help with this page link').by_link_text_locator)
	  @help_with_this_page_link if @help_with_this_page_link.displayed?
      }
  end 

 def estimated_cost_number
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @estimated_cost_number = self.driver.find_element(:css => self.db_object.elements.find_by_name('estimated cost number').by_css_locator)
	  @estimated_cost_number if @estimated_cost_number.displayed?
      }
  end   
  
  def car_selected_banner_rental_company_img
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_selected_banner_rental_company_img = self.driver.find_element(:css => self.db_object.elements.find_by_name('car selected banner rental company img').by_css_locator)
	  @car_selected_banner_rental_company_img if @car_selected_banner_rental_company_img.displayed?
      }
  end
  
  def change_your_car_button
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @change_your_car_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('change your car button').by_css_locator)
	  @change_your_car_button if @change_your_car_button.displayed?
      }
  end
  
  def charges_and_restrictions_car_title
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @charges_and_restrictions_car_title = self.driver.find_element(:css => self.db_object.elements.find_by_name('charges and restrictions car title').by_css_locator)
	  @charges_and_restrictions_car_title if @charges_and_restrictions_car_title.displayed?
      }
  end
  
  def car_rental_rules_link
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_rental_rules_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('car rental rules link').by_css_locator)
	  @car_rental_rules_link if @car_rental_rules_link.displayed?
      }
  end
  
  def car_gas_charges_link
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_gas_charges_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('car gas charges link').by_css_locator)
	  @car_gas_charges_link if @car_gas_charges_link.displayed?
      }
  end
  
  def car_additional_costs_link
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_additional_costs_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('car additional costs link').by_css_locator)
	  @car_additional_costs_link if @car_additional_costs_link.displayed?
      }
  end
  
  def car_overlay_rental_rules_title
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_overlay_rental_rules_title = self.driver.find_element(:id => self.db_object.elements.find_by_name('car overlay rental rules title').by_id_locator)
	  @car_overlay_rental_rules_title if @car_overlay_rental_rules_title.displayed?
      }
  end
    
  def car_overlay_rental_rules_categories
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	wait.until {
	@car_overlay_rental_rules_categories = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car overlay rental rules categories').by_css_locator)
	@car_overlay_rental_rules_categories if @car_overlay_rental_rules_categories[0].displayed?
    }
  end
  
  def car_overlay_rental_rules_close_button
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_overlay_rental_rules_close_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('car overlay rental rules close button').by_css_locator)
	  @car_overlay_rental_rules_close_button if @car_overlay_rental_rules_close_button.displayed?
      }
  end 
  
  def car_overlay_gas_charges_title
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_overlay_gas_charges_title = self.driver.find_element(:id => self.db_object.elements.find_by_name('car overlay gas charges title').by_id_locator)
	  @car_overlay_gas_charges_title if @car_overlay_gas_charges_title.displayed?
      }
  end
    
  def car_overlay_gas_charges_close_button
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_overlay_gas_charges_close_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('car overlay gas charges close button').by_css_locator)
	  @car_overlay_gas_charges_close_button if @car_overlay_gas_charges_close_button.displayed?
      }
  end   

  def car_overlay_aditional_costs_title
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_overlay_aditional_costs_title = self.driver.find_element(:id => self.db_object.elements.find_by_name('car overlay aditional costs title').by_id_locator)
	  @car_overlay_aditional_costs_title if @car_overlay_aditional_costs_title.displayed?
      }
  end

  def car_overlay_aditional_costs_button
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_overlay_aditional_costs_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('car overlay aditional costs button').by_css_locator)
	  @car_overlay_aditional_costs_button if @car_overlay_aditional_costs_button.displayed?
      }
  end  
  
  def car_overlay_aditional_costs_items_values
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_overlay_aditional_costs_items_values = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car overlay aditional costs items').by_css_locator)
	  @car_overlay_aditional_costs_items_values if @car_overlay_aditional_costs_items_values[0].displayed?
      }
  end  
  
  def car_overlay_rental_rules_categories_expanded
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_overlay_rental_rules_categories_expanded = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car overlay rental rules categories expanded').by_css_locator)
	  @car_overlay_rental_rules_categories_expanded if @car_overlay_rental_rules_categories_expanded[0].displayed?
      }
  end  
  
  def car_checkout_crumb
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_checkout_crumb = self.driver.find_element(:css => self.db_object.elements.find_by_name('car checkout crumb').by_css_locator)
	  @car_checkout_crumb if @car_checkout_crumb.displayed?
      }
  end      
  
  def car_confirmation_crumb 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_confirmation_crumb = self.driver.find_element(:class => self.db_object.elements.find_by_name('car confirmation crumb').by_class_locator)
	  @car_confirmation_crumb if @car_confirmation_crumb.displayed?
      }
  end     
  
  def car_arrow_crumb
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_arrow_crumb = self.driver.find_element(:css => self.db_object.elements.find_by_name('car arrow crumb').by_css_locator)
	  @car_arrow_crumb if @car_arrow_crumb.displayed?
      }
  end  
  
  def car_taxes_fees_number 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_confirmation_crumb = self.driver.find_element(:css => self.db_object.elements.find_by_name('car taxes fees number').by_css_locator)
    @car_confirmation_crumb if @car_confirmation_crumb.displayed?
      }
  end    
  
  def car_taxes_and_fees_numbers
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	wait.until {
	@car_taxes_and_fees_numbers = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car taxes and fees numbers').by_css_locator)
	@car_taxes_and_fees_numbers if @car_taxes_and_fees_numbers[0].displayed?
    }
  end

  def car_taxes_and_fees_currency_sign
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_taxes_and_fees_currency_sign = self.driver.find_element(:css => self.db_object.elements.find_by_name('car taxes and fees currency sign').by_css_locator)
	  @car_taxes_and_fees_currency_sign if @car_taxes_and_fees_currency_sign.displayed?
      }
  end     
  
  def car_type_and_length_rental_title
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_type_and_length_rental_title = self.driver.find_element(:css => self.db_object.elements.find_by_name('car type and length rental title').by_css_locator)
	  @car_type_and_length_rental_title if @car_type_and_length_rental_title.displayed?
      }
  end  
  
  def car_selected_image
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_selected_image = self.driver.find_element(:css => self.db_object.elements.find_by_name('car selected image').by_css_locator)
	  @car_selected_image if @car_selected_image.displayed?
      }
  end 

  def car_book_now_pay_later_title_banner
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_book_now_pay_later_title_banner = self.driver.find_element(:css => self.db_object.elements.find_by_name('car book now pay later title banner').by_css_locator)
	  @car_book_now_pay_later_title_banner if @car_book_now_pay_later_title_banner.displayed?
      }
  end
    
  def car_data_locations
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	wait.until {
	@car_data_locations = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car data locations').by_css_locator)
	@car_data_locations if @car_data_locations[0].displayed?
    }
  end  
    
  def car_data_summary_texts
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	wait.until {
	@car_data_summary_texts = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car data summary texts').by_css_locator)
	@car_data_summary_texts if @car_data_summary_texts[0].displayed?
    }
  end    
    
  def car_data_doors_number
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_data_doors_number = self.driver.find_element(:css => self.db_object.elements.find_by_name('car data doors number').by_css_locator)
	  @car_data_doors_number if @car_data_doors_number.displayed?
      }
  end  
  
  def car_data_passengers_number
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_data_passengers_number = self.driver.find_element(:css => self.db_object.elements.find_by_name('car data passengers number').by_css_locator)
	  @car_data_passengers_number if @car_data_passengers_number.displayed?
      }
  end    
  
  def car_data_luggage_number
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_data_luggage_number = self.driver.find_element(:css => self.db_object.elements.find_by_name('car data luggage number').by_css_locator)
	  @car_data_luggage_number if @car_data_luggage_number.displayed?
      }
  end      
  
  def car_data_suttle_info_link
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_data_suttle_info_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('car data suttle info link').by_css_locator)
	  @car_data_suttle_info_link if @car_data_suttle_info_link.displayed?
      }
  end      
  
  def car_data_pick_up_data_location_hour_operation_link  
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_data_pick_up_data_location_hour_operation_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('car data pick up data location hour operation link').by_css_locator)
	  @car_data_pick_up_data_location_hour_operation_link if @car_data_pick_up_data_location_hour_operation_link.displayed?
      }
  end      

  def car_data_drop_off_location_hour_operation_link    
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_data_drop_off_location_hour_operation_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('car data drop off location hour operation link').by_css_locator)
	  @car_data_drop_off_location_hour_operation_link if @car_data_drop_off_location_hour_operation_link.displayed?
      }
  end      

  def car_data_pick_up_location_text      
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_data_pick_up_location_text = self.driver.find_element(:css => self.db_object.elements.find_by_name('car data pick up location text').by_css_locator)
	  @car_data_pick_up_location_text if @car_data_pick_up_location_text.displayed?
      }
  end
  
  def car_data_drop_off_location_text      
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_data_drop_off_location_text = self.driver.find_element(:css => self.db_object.elements.find_by_name('car data drop off location text').by_css_locator)
	  @car_data_drop_off_location_text if @car_data_drop_off_location_text.displayed?
      }
  end  

  def car_total_cost_currency_sign      
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_total_cost_currency_sign = self.driver.find_element(:css => self.db_object.elements.find_by_name('car total cost currency sign').by_css_locator)
	  @car_total_cost_currency_sign if @car_total_cost_currency_sign.displayed?
      }
  end   

  def car_rate_details_texts
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	wait.until {
	@car_rate_details_texts = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car rate details texts').by_css_locator)
	@car_rate_details_texts if @car_rate_details_texts[0].displayed?
    }
  end
  
  def car_rate_details_numbers
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	wait.until {
	@car_rate_details_numbers = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car rate details numbers').by_css_locator)
	@car_rate_details_numbers if @car_rate_details_numbers[0].displayed?
    }
  end
   
  def car_exclusive_travel_benefit_section 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_exclusive_travel_benefit_section = self.driver.find_element(:class => self.db_object.elements.find_by_name('car exclusive travel benefit section').by_class_locator)
	  @car_exclusive_travel_benefit_section if @car_exclusive_travel_benefit_section.displayed?
      }
  end 
  
  def car_driver_info_section_number    
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_driver_info_section_number = self.driver.find_element(:css => self.db_object.elements.find_by_name('car driver info section number').by_css_locator)
    @car_driver_info_section_number if @car_driver_info_section_number.displayed?
  }
  end
  
  def car_read_age_policy_link 
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_read_age_policy_link = self.driver.find_element(:class => self.db_object.elements.find_by_name('car read age policy link').by_class_locator)
	  @car_read_age_policy_link if @car_read_age_policy_link.displayed?
      }
  end 

  def car_overlay_age_policy_title  
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_overlay_age_policy_title = self.driver.find_element(:id => self.db_object.elements.find_by_name('car overlay age policy title').by_id_locator)
	  @car_overlay_age_policy_title if @car_overlay_age_policy_title.displayed?
      }
  end  
  
  def car_overlay_age_policy_close_button    
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_overlay_age_policy_close_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('car overlay age policy close button').by_css_locator)
    @car_overlay_age_policy_close_button if @car_overlay_age_policy_close_button.displayed?
  }
  end
  
  def car_driver_info_first_name_textbox  
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_driver_info_first_name_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('car driver info first name textbox').by_id_locator)
	  @car_driver_info_first_name_textbox if @car_driver_info_first_name_textbox.displayed?
      }
  end  
  
  def car_driver_info_middle_name_textbox  
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_driver_info_middle_name_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('car driver info middle name textbox').by_id_locator)
	  @car_driver_info_middle_name_textbox if @car_driver_info_middle_name_textbox.displayed?
      }
  end    
  
  def car_driver_info_last_name_textbox  
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_driver_info_last_name_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('car driver info last name textbox').by_id_locator)
	  @car_driver_info_last_name_textbox if @car_driver_info_last_name_textbox.displayed?
      }
  end      
 
  def car_driver_info_labels
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	wait.until {
	@car_driver_info_labels = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car driver info labels').by_css_locator)
	@car_driver_info_labels if @car_driver_info_labels[0].displayed?
    }
  end 
  
  def car_driver_info_email_texbox  
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_driver_info_email_texbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('car driver info email texbox').by_id_locator)
	  @car_driver_info_email_texbox if @car_driver_info_email_texbox.displayed?
      }
  end
  
  def car_driver_info_phone_number_texbox  
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_driver_info_phone_number_texbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('car driver info phone number texbox').by_id_locator)
	  @car_driver_info_phone_number_texbox if @car_driver_info_phone_number_texbox.displayed?
      }
  end

  def car_driver_info_container    
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_driver_info_container = self.driver.find_element(:css => self.db_object.elements.find_by_name('car driver info container').by_css_locator)
    @car_driver_info_container if @car_driver_info_container.displayed?
  }
  end
  
  def car_driver_info_error_messages 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_driver_info_error_messages = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car driver info error messages').by_css_locator)
    @car_driver_info_error_messages if @car_driver_info_error_messages[0].displayed?
    }
  end 
  
  def car_driver_info_save_button    
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_driver_info_save_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('car driver info save button').by_css_locator)
    @car_driver_info_save_button if @car_driver_info_save_button.displayed?
  }
  end
 
  def car_driver_info_loyalty_program_texbox  
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_driver_info_loyalty_program_texbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('car driver info loyalty program texbox').by_id_locator)
	  @car_driver_info_loyalty_program_texbox if @car_driver_info_loyalty_program_texbox.displayed?
      }
  end 
  
  def car_driver_info_check_loyalty_number_text    
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_driver_info_check_loyalty_number_text = self.driver.find_element(:css => self.db_object.elements.find_by_name('car driver info check loyalty number text').by_css_locator)
    @car_driver_info_check_loyalty_number_text if @car_driver_info_check_loyalty_number_text.displayed?
  }
  end
  
  def car_driver_info_driver_has_special_equipment_requests_link    
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_driver_info_driver_has_special_equipment_requests_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('car driver info driver has special equipment requests link').by_css_locator)
    @car_driver_info_driver_has_special_equipment_requests_link if @car_driver_info_driver_has_special_equipment_requests_link.displayed?
  }
  end
  
  def car_driver_info_driver_has_special_equipment_requests_section_expanded   
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_driver_info_driver_has_special_equipment_requests_section_expanded = self.driver.find_element(:css => self.db_object.elements.find_by_name('car driver info driver has special equipment requests section expanded').by_css_locator)
    @car_driver_info_driver_has_special_equipment_requests_section_expanded if @car_driver_info_driver_has_special_equipment_requests_section_expanded.displayed?
  }
  end
  
  def car_driver_info_driver_has_special_equipment_requests_section_collapsed   
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_driver_info_driver_has_special_equipment_requests_section_collapsed = self.driver.find_element(:css => self.db_object.elements.find_by_name('car driver info driver has special equipment requests section collapsed').by_css_locator)
    @car_driver_info_driver_has_special_equipment_requests_section_collapsed if @car_driver_info_driver_has_special_equipment_requests_section_collapsed.displayed?
  }
  end
  
  def car_driver_info_driver_special_requests_text    
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_driver_info_driver_special_requests_text = self.driver.find_element(:css => self.db_object.elements.find_by_name('car driver info driver special requests text').by_css_locator)
    @car_driver_info_driver_special_requests_text if @car_driver_info_driver_special_requests_text.displayed?
  }
  end  
  
  def car_driver_info_driver_special_requests_checkboxes 
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
    @car_driver_info_driver_special_requests_checkboxes = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car driver info driver special requests checkboxes').by_css_locator)
    @car_driver_info_driver_special_requests_checkboxes if @car_driver_info_driver_special_requests_checkboxes[0].displayed?
    }
  end   
  
  def car_driver_info_driver_airlines_items_combobox 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_driver_info_driver_airlines_items_combobox = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car driver info driver airlines items combobox').by_css_locator)
    @car_driver_info_driver_airlines_items_combobox if @car_driver_info_driver_airlines_items_combobox[0].displayed?
    }
  end  

  def car_driver_info_driver_airlines_combobox_arrow 
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_driver_info_driver_airlines_combobox_arrow = self.driver.find_element(:css => self.db_object.elements.find_by_name('car driver info driver airlines combobox arrow').by_css_locator)
    @car_driver_info_driver_airlines_combobox_arrow if @car_driver_info_driver_airlines_combobox_arrow.displayed?
  }
  end  
  
  def car_driver_info_driver_airlines_combobox 
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_driver_info_driver_airlines_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('car driver info driver airlines combobox').by_css_locator)
    @car_driver_info_driver_airlines_combobox if @car_driver_info_driver_airlines_combobox.displayed?
  }
  end  
  
  def car_driver_info_driver_flight_number_textbox  
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_driver_info_driver_flight_number_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('car driver info driver flight number textbox').by_id_locator)
	  @car_driver_info_driver_flight_number_textbox if @car_driver_info_driver_flight_number_textbox.displayed?
      }
  end   
  
  def car_driver_info_edit_button 
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_driver_info_edit_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('car driver info edit button').by_css_locator)
    @car_driver_info_edit_button if @car_driver_info_edit_button.displayed?
  }
  end   
  
  def car_payment_info_container   
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_payment_info_container = self.driver.find_element(:css => self.db_object.elements.find_by_name('car payment info container').by_css_locator)
    @car_payment_info_container if @car_payment_info_container.displayed?
  }
  end
  
  def car_book_you_car_info_container   
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_book_you_car_info_container = self.driver.find_element(:css => self.db_object.elements.find_by_name('car book you car info container').by_css_locator)
    @car_book_you_car_info_container if @car_book_you_car_info_container.displayed?
  }
  end  

  def car_payment_info_warning_text   
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_book_you_car_info_container = self.driver.find_element(:css => self.db_object.elements.find_by_name('car payment info warning text').by_css_locator)
    @car_book_you_car_info_container if @car_book_you_car_info_container.displayed?
  }
  end  
  
  def car_data_suttle_information_overlay_title
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_data_suttle_information_overlay_title = self.driver.find_element(:id => self.db_object.elements.find_by_name('car data suttle information overlay title').by_id_locator)
	  @car_data_suttle_information_overlay_title if @car_data_suttle_information_overlay_title.displayed?
      }
  end
   
  def car_data_suttle_information_overlay_close_button
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_data_suttle_information_overlay_close_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('car data suttle information overlay close button').by_css_locator)
	  @car_data_suttle_information_overlay_close_button if @car_data_suttle_information_overlay_close_button.displayed?
      }
  end    
  
  def car_data_pick_up_location_hours_of_operation_overlay_title 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_data_pick_up_location_hours_of_operation_overlay_title = self.driver.find_element(:id => self.db_object.elements.find_by_name('car data pick up location hours of operation overlay title').by_id_locator)
	  @car_data_pick_up_location_hours_of_operation_overlay_title if @car_data_pick_up_location_hours_of_operation_overlay_title.displayed?
      }
  end
  
  def car_data_pick_up_location_hours_of_operation_overlay_close_button 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_data_pick_up_location_hours_of_operation_overlay_close_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('car data pick up location hours of operation overlay close button').by_css_locator)
	  @car_data_pick_up_location_hours_of_operation_overlay_close_button if @car_data_pick_up_location_hours_of_operation_overlay_close_button.displayed?
      }
  end 

  def car_data_drop_off_location_hours_of_operation_overlay_title 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_data_drop_off_location_hours_of_operation_overlay_title = self.driver.find_element(:id => self.db_object.elements.find_by_name('car data drop off location hours of operation overlay title').by_id_locator)
	  @car_data_drop_off_location_hours_of_operation_overlay_title if @car_data_drop_off_location_hours_of_operation_overlay_title.displayed?
      }
  end

  def car_data_drop_off_location_hours_of_operation_overlay_close_button 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_data_drop_off_location_hours_of_operation_overlay_close_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('car data drop off location hours of operation overlay close button').by_css_locator)
	  @car_data_drop_off_location_hours_of_operation_overlay_close_button if @car_data_drop_off_location_hours_of_operation_overlay_close_button.displayed?
      }
  end  
  
  def car_data_pick_up_location_open_hours_title   
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_data_pick_up_location_open_hours_title = self.driver.find_element(:css => self.db_object.elements.find_by_name('car data pick up location open hours title').by_css_locator)
	  @car_data_pick_up_location_open_hours_title if @car_data_pick_up_location_open_hours_title.displayed?
      }
  end
  
  def car_data_drop_off_location_open_hours_title 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @car_data_drop_off_location_open_hours_title = self.driver.find_element(:css => self.db_object.elements.find_by_name('car data drop off location open hours title').by_css_locator)
	  @car_data_drop_off_location_open_hours_title if @car_data_drop_off_location_open_hours_title.displayed?
      }
  end
  
  def car_select_book_car_button      
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_select_book_car_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('car select book car button').by_css_locator)
    @car_select_book_car_button if @car_select_book_car_button.displayed?
  }
  end  
  
  def car_book_car_error_message        
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_book_car_error_message = self.driver.find_element(:css => self.db_object.elements.find_by_name('car book car error message').by_css_locator)
    @car_book_car_error_message if @car_book_car_error_message.displayed?
  }
  end  
  
  def car_book_car_terms_conditions_checkbox        
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_book_car_terms_conditions_checkbox = self.driver.find_element(:css => self.db_object.elements.find_by_name('car book car terms conditions checkbox').by_css_locator)
    @car_book_car_terms_conditions_checkbox if @car_book_car_terms_conditions_checkbox.displayed?
  }
  end    

  def car_sections_titles
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_section_titles = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car sections titles').by_css_locator)
    @car_section_titles if @car_section_titles[0].displayed?
    }
  end  
  
  def car_sections_numbers
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_section_numbers = self.driver.find_elements(:css => self.db_object.elements.find_by_name('car sections numbers').by_css_locator)
    @car_section_numbers if @car_section_numbers[0].displayed?
    }
  end    
end