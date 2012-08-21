require 'rubygems'
require 'selenium-webdriver'
require_relative '../../../lib/base_page'

require 'active_support'
require 'active_resource'
require 'rails'
require 'active_record'
require 'yaml'
require 'spec_helper'
require_relative '../db/models/database_model'

class CarSearchPage < BasePage   
  def initialize(driver, test_env, *arg)   
    @db_object = Page.find_by_name('car page')
    @url = arg[0] || Environment.find_by_name(test_env).base_url + Page.find_by_name('car page').url
    @title = Page.find_by_name('car page').title
    @driver = driver 
  end  
  
  def choose_a_vendor(vendor_name)
    self.select_option(self.car_rental_company_combobox,vendor_name)
  end
  
  def book_a_car(dataset_name, direct=false)
    car = Car.find_by_name(dataset_name)
       
    # type of car ride option
    if car.dropoff_same_as_pickup == true
      self.dropoff_same_as_pickup_label.click()   
    end
    
    if car.different_dropoff_location == true
      self.different_dropoff_location_label.click()   
    end    
    
    # Search pick up city
    if !(car.pickup_city.nil?)
      self.pickup_city_textbox.send_keys(car.pickup_city) 
    end
    if !direct
      self.pickup_city_textbox.send_keys(:arrow_down)
      self.pickup_city_textbox.send_keys(:tab)
    end
    
    # Drop off city
    if !(car.dropoff_city.nil?)
      self.dropoff_city_textbox.send_keys(car.dropoff_city) 
    end
    if !direct and !(car.dropoff_city.nil?)
      self.dropoff_city_textbox.send_keys(:arrow_down)
      self.dropoff_city_textbox.send_keys(:tab)
    end
    
   if car.pickup_in_address == true
    self.pickup_search_by_address_option_label.click() 
    sleep 1      
    if !(car.pickup_country.nil?)
      self.select_option(self.pickup_country_combobox,car.pickup_country.to_s)
    end
    
    if !(car.pickup_address.nil?)
      self.pickup_address.send_keys(car.pickup_address)
    end

    if !(car.pickup_city_address.nil?)
      self.pickup_city_address.send_keys(car.pickup_city_address)
    end

    if !(car.pickup_state.nil?)
      self.select_option(self.pickup_state_combobox,car.pickup_state.to_s)
    end

    if !(car.pickup_zip.nil?)
      self.pickup_zip.send_keys(car.pickup_zip)
    end      
   end    
    
   if car.dropoff_in_address == true
    self.dropoff_search_by_address_option_label.click() 
    sleep 1      
    if !(car.dropoff_country.nil?)
      self.select_option(self.dropoff_country_combobox,car.dropoff_country.to_s)
    end
    
    if !(car.dropoff_address.nil?)
      self.dropoff_address.send_keys(car.dropoff_address)
    end

    if !(car.dropoff_city_address.nil?)
      self.dropoff_city_address.send_keys(car.dropoff_city_address)
    end

    if !(car.dropoff_state.nil?)
      self.select_option(self.dropoff_state_combobox,car.dropoff_state.to_s)
    end

    if !(car.dropoff_zip.nil?)
      self.dropoff_zip.send_keys(car.dropoff_zip)
    end      
   end
    
    # Pickup date
    if !(car.pickup_date.nil?)
      self.pickup_date_textbox.send_keys(eval(car.pickup_date))  
    end 
    
    # TD: Set Pickup Time    
    
    # Drop off date
    if !(car.dropoff_date.nil?)
      self.dropoff_date_textbox.send_keys(eval(car.dropoff_date))
      self.dropoff_date_textbox.send_keys(:tab)      
    end 
    
    # TD: Set drop off time
    
    # Car rental company
    if !(car.car_rental_company.nil?)
      self.select_option(self.car_rental_company_combobox,car.car_rental_company.to_s)
    end 
    sleep(1)

    # Coupon text area
    if !(car.discount_code.nil?)
      self.discount_code_textbox.send_keys(car.discount_code)
    end
     
    # AC option
    if !(car.ac_option.nil?)
      self.select_option(self.car_ac_combobox,car.ac_option.to_s)
    end 
    
     # Click on submit button
    #self.search_cars_button.click()
  end
        
  def dropoff_same_as_pickup
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @dropoff_same_as_pickup = self.driver.find_element(:id => self.db_object.elements.find_by_name('dropoff same as pickup').by_id_locator)
	  @dropoff_same_as_pickup if @dropoff_same_as_pickup.displayed?
	}
  end

  def dropoff_same_as_pickup_label
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @dropoff_same_as_pickup_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('dropoff same as pickup label').by_css_locator)
	  @dropoff_same_as_pickup_label if @dropoff_same_as_pickup_label.displayed?
	}
  end
  
	def different_dropoff_location 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @different_dropoff_location = self.driver.find_element(:id => self.db_object.elements.find_by_name('different dropoff location').by_id_locator)
	  @different_dropoff_location if @different_dropoff_location.displayed?
	}
	end
    
    def different_dropoff_location_label
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @different_dropoff_location_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('different dropoff location label').by_css_locator)
	  @different_dropoff_location_label if @different_dropoff_location_label.displayed?
	}
	end

	def pickup_city_textbox
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @pickup_city_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('pickup city textbox').by_id_locator)
	  @pickup_city_textbox if @pickup_city_textbox.displayed?
	}
	end

	def dropoff_city_textbox
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @dropoff_city_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('dropoff city textbox').by_id_locator)
	  @dropoff_city_textbox if @dropoff_city_textbox.displayed?
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
	  wait = Selenium::WebDriver::Wait.new(:TIMEOUT => TIMEOUT)
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
	      
  def pickup_country_combobox
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @pickup_country_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('pickup country combobox').by_css_locator)
      @pickup_country_combobox if @pickup_country_combobox.displayed?
	}	
	end	   
  
  def pickup_address
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @pickup_address = self.driver.find_element(:id => self.db_object.elements.find_by_name('pickup address').by_id_locator)
	  @pickup_address if @pickup_address.displayed?
	}
  end

    def pickup_city_address
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @pickup_city_address = self.driver.find_element(:id => self.db_object.elements.find_by_name('pickup city address').by_id_locator)
	  @pickup_city_address if @pickup_city_address.displayed?
	}
	end

   	def pickup_state_combobox  
	  wait = Selenium::WebDriver::Wait.new(:TIMEOUT => TIMEOUT)
	  wait.until {
	  @pickup_state_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('pickup state combobox').by_css_locator)
	  @pickup_state_combobox if @pickup_state_combobox.displayed?
	}	
	end  
  
  def pickup_zip
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @pickup_zip = self.driver.find_element(:id => self.db_object.elements.find_by_name('pickup zip').by_id_locator)
    @pickup_zip if @pickup_zip.displayed?
  } 
  end

  def dropoff_country_combobox
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @dropoff_country_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('dropoff country combobox').by_css_locator)
      @dropoff_country_combobox if @dropoff_country_combobox.displayed?
	}	
	end	   
  
  def dropoff_address
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @dropoff_address = self.driver.find_element(:id => self.db_object.elements.find_by_name('dropoff address').by_id_locator)
	  @dropoff_address if @dropoff_address.displayed?
	}
  end

    def dropoff_city_address
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @dropoff_city_address = self.driver.find_element(:id => self.db_object.elements.find_by_name('dropoff city address').by_id_locator)
	  @dropoff_city_address if @dropoff_city_address.displayed?
	}
	end

   	def dropoff_state_combobox  
	  wait = Selenium::WebDriver::Wait.new(:TIMEOUT => TIMEOUT)
	  wait.until {
	  @dropoff_state_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('dropoff state combobox').by_css_locator)
	  @dropoff_state_combobox if @dropoff_state_combobox.displayed?
	}	
	end  
  
  def dropoff_zip
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @dropoff_zip = self.driver.find_element(:id => self.db_object.elements.find_by_name('dropoff zip').by_id_locator)
    @dropoff_zip if @dropoff_zip.displayed?
  } 
  end
  
  
  
  
  
  
  
  
  
  
  
  
  
  #car_search_pickup_use_address_input
  def pickup_input_options
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @pickup_input_options = self.driver.find_element(:id => self.db_object.elements.find_by_name('pickup input options').by_id_locator)
	  @pickup_input_options if @pickup_input_options.displayed?
	}
  end

  def rental_type
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @rental_type = self.driver.find_element(:id => self.db_object.elements.find_by_name('car rental type option').by_id_locator)
	  @rental_type if @rental_type.displayed?
	}
  end 

   def pickup_subtitle 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @pickup_subtitle = self.driver.find_element(:css => self.db_object.elements.find_by_name('pickup subtitle').by_css_locator)
      @pickup_subtitle if @pickup_subtitle.displayed?
	}	
	end

  def dropoff_same_as_pickup_input
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @dropoff_same_as_pickup_input = self.driver.find_element(:id => self.db_object.elements.find_by_name('dropoff location same as pickup input').by_id_locator)
      @dropoff_same_as_pickup_input if @dropoff_same_as_pickup_input.displayed?
    }
  end

  def pickup_search_city_airport_input
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @pickup_search_city_airport_input = self.driver.find_element(:id => self.db_object.elements.find_by_name('pickup search by city or airport input').by_id_locator)
      @pickup_search_city_airport_input if @pickup_search_city_airport_input.displayed?
    }
  end

  def dropoff_search_city_airport_input
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @dropoff_search_city_airport_input = self.driver.find_element(:id => self.db_object.elements.find_by_name('dropoff search by city or airport input').by_id_locator)
      @dropoff_search_city_airport_input if @dropoff_search_city_airport_input.displayed?
    }
  end

  def pickup_search_by_address_input
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @pickup_search_by_address_input = self.driver.find_element(:id => self.db_object.elements.find_by_name('pickup search by address input').by_id_locator)
      @pickup_search_by_address_input if @pickup_search_by_address_input.displayed?
    }
  end

  def dropoff_search_by_address_input
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @dropoff_search_by_address_input = self.driver.find_element(:id => self.db_object.elements.find_by_name('dropoff search by address input').by_id_locator)
      @dropoff_search_by_address_input if @dropoff_search_by_address_input.displayed?
    }
  end  

  def pickup_search_city_airport_option_label
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @pickup_search_city_airport_option_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('pickup search city airport option label').by_css_locator)
      @pickup_search_city_airport_option_label if @pickup_search_city_airport_option_label.displayed?
    }
  end

  def dropoff_search_city_airport_option_label
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @dropoff_search_city_airport_option_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('dropoff search city airport option label').by_css_locator)
      @dropoff_search_city_airport_option_label if @dropoff_search_city_airport_option_label.displayed?
    }
  end   
  
  def pickup_search_by_address_option_label
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @pickup_search_by_address_option_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('pickup search by address option label').by_css_locator)
      @pickup_search_by_address_option_label if @pickup_search_by_address_option_label.displayed?
    }
  end

  def dropoff_search_by_address_option_label
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @dropoff_search_by_address_option_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('dropoff search by address option label').by_css_locator)
      @dropoff_search_by_address_option_label if @dropoff_search_by_address_option_label.displayed?
    }
  end 
  
  def dropoff_input_options
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @dropoff_input_options = self.driver.find_element(:id => self.db_object.elements.find_by_name('dropoff input options').by_id_locator)
	  @dropoff_input_options if @dropoff_input_options.displayed?
	}
  end
      
  #car rental company combobox
  def car_rental_company_combobox 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @car_rental_company_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('car rental company combobox').by_css_locator)
      @car_rental_company_combobox if @car_rental_company_combobox.displayed?
	}	
	end	     

    


  def car_rental_company_combobox_arrow
      wait = Selenium::WebDriver::Wait.new(:timeout => timeout)
	  wait.until {  
      @car_rental_company_combobox_arrow = self.driver.find_element(:css => self.db_object.elements.find_by_name('car rental company combobox arrow').by_css_locator)
      @car_rental_company_combobox_arrow if @car_rental_company_combobox_arrow.displayed?
	}	
	end	     

  # car discount textbox
	def discount_code_textbox 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @discount_code_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('discount code textbox').by_id_locator)
	  @discount_code_textbox if @discount_code_textbox.displayed?
	}	
	end

	def search_cars_button 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @search_cars_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('search cars button').by_css_locator)
	  @search_cars_button if @search_cars_button.displayed?
	}	
	end	
    
  def ac_car_select
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @ac_car_select = self.driver.find_element(:id => self.db_object.elements.find_by_name('ac select').by_id_locator)
	  @ac_car_select if @ac_car_select.displayed?
	}
  end
    
  def transmission_car_select
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @transmission_car_select = self.driver.find_element(:id => self.db_object.elements.find_by_name('transmission select').by_id_locator)
	  @transmission_car_select if @transmission_car_select.displayed?
	}
  end
    
  def car_ac_combobox
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @car_ac_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('car AC combobox').by_css_locator)
	  @car_ac_combobox if @car_ac_combobox.displayed?
	}
  end
    
  def car_transmission_combobox
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
      @car_transmission_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('car transmission combobox').by_css_locator)
	  @car_transmission_combobox if @car_transmission_combobox.displayed?
	}
  end
   
  def car_interstitial_graph
      wait = Selenium::WebDriver::Wait.new(:timeout => timeout)
	  wait.until {  
      @car_interstitial_graph = self.driver.find_element(:id => self.db_object.elements.find_by_name('interstitial graph').by_id_locator)
	  @car_interstitial_graph if @car_interstitial_graph.displayed?
	}
  end 
    
  def search_element_present?(element)
    search_element = []
    search_element = self.driver.find_elements(:css => element)
    search_element[0].nil? ? false : true  
  end
  
  def car_search_form 
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
      @car_search_form = self.driver.find_element(:id => self.db_object.elements.find_by_name('car search form').by_id_locator)
      @car_search_form if @car_search_form.displayed?
     }
  end
    
  def car_errors 
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_errors = self.driver.find_element(:css => self.db_object.elements.find_by_name('car errors').by_css_locator)
    @car_errors if @car_errors.displayed?
    }
  end

  def ambigous_form
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @ambigous_form = self.driver.find_element(:css => self.db_object.elements.find_by_name('car disambiguation form').by_css_locator)
    @ambigous_form if @ambigous_form.displayed?
    }
  end
      
  def disambigous_options
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @disambigous_options = self.driver.find_element(:css => self.db_object.elements.find_by_name('disambiguos options').by_css_locator)
    @disambigous_options if @disambigous_options.displayed?
    }
  end

  def search_disambiguation_button
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @search_disambiguation_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('search disambiguation button').by_css_locator)
    @search_disambiguation_button if @search_disambiguation_button.displayed?
    }
  end

  def disambiguation_first_choice
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @disambiguation_first_choice = self.driver.find_element(:css => self.db_object.elements.find_by_name('disambiguation first choice').by_css_locator)
    @disambiguation_first_choice if @disambiguation_first_choice.displayed?
    }
  end

  def link_back_home
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @link_back_home = self.driver.find_element(:css => self.db_object.elements.find_by_name('disambiguation back link').by_css_locator)
    @link_back_home if @link_back_home.displayed?
    }
  end
    
  def fill_required_field_error
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @fill_required_field_error = self.driver.find_element(:css => self.db_object.elements.find_by_name('disambiguation search error').by_css_locator)
    @fill_required_field_error if @fill_required_field_error.displayed?
    }
  end

  def car_search_rental_option
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @car_search_rental_option = self.driver.find_element(:id => self.db_object.elements.find_by_name('car search rental option').by_id_locator)
    @car_search_rental_option if @car_search_rental_option.displayed?
    }
  end

  def promo_get_points
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @promo_get_points = self.driver.find_element(:css => self.db_object.elements.find_by_name('promo get points').by_css_locator)
    @promo_get_points if @promo_get_points.displayed?
    }
  end

  def promo_pay_points
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @promo_pay_points = self.driver.find_element(:css => self.db_object.elements.find_by_name('promo pay points').by_css_locator)
    @promo_pay_points if @promo_pay_points.displayed?
    }
  end
    
    
   def disambigous_options
        wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
        wait.until {
        @disambigous_options = self.driver.find_element(:css => self.db_object.elements.find_by_name('disambiguos options').by_css_locator)
        @disambigous_options if @disambigous_options.displayed?
       }
    end
    
    def search_disambiguation_button
        wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
        wait.until {
        @search_disambiguation_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('search disambiguation button').by_css_locator)
        @search_disambiguation_button if @search_disambiguation_button.displayed?
       }
    end
    
    def disambiguation_first_choice
        wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
        wait.until {
        @disambiguation_first_choice = self.driver.find_element(:css => self.db_object.elements.find_by_name('disambiguation first choice').by_css_locator)
        @disambiguation_first_choice if @disambiguation_first_choice.displayed?
       }
    end
    
    def link_back_home
        wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
        wait.until {
        @link_back_home = self.driver.find_element(:css => self.db_object.elements.find_by_name('disambiguation back link').by_css_locator)
        @link_back_home if @link_back_home.displayed?
       }
    end
    
    def fill_required_field_error
        wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
        wait.until {
        @fill_required_field_error = self.driver.find_element(:css => self.db_object.elements.find_by_name('disambiguation search error').by_css_locator)
        @fill_required_field_error if @fill_required_field_error.displayed?
       }
    end
    
    def car_search_rental_option
        wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
        wait.until {
        @car_search_rental_option = self.driver.find_element(:id => self.db_object.elements.find_by_name('car search rental option').by_id_locator)
        @car_search_rental_option if @car_search_rental_option.displayed?
       }
    end
    
    
    def promo_get_points
        wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
        wait.until {
        @promo_get_points = self.driver.find_element(:css => self.db_object.elements.find_by_name('promo get points').by_css_locator)
        @promo_get_points if @promo_get_points.displayed?
       }
    end
    
   def promo_pay_points
        wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
        wait.until {
        @promo_pay_points = self.driver.find_element(:css => self.db_object.elements.find_by_name('promo pay points').by_css_locator)
        @promo_pay_points if @promo_pay_points.displayed?
       }
    end
    
   def promo_competitive_rates
        wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
        wait.until {
        @promo_competitive_rates = self.driver.find_element(:css => self.db_object.elements.find_by_name('promo competitive rates').by_css_locator)
        @promo_competitive_rates if @promo_competitive_rates.displayed?
       }
    end
    
    def airports_worldwide_pickup_link 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
      wait.until {  
      @airports_worldwide_pickup_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide pickup link').by_css_locator)
      @airports_worldwide_pickup_link if @airports_worldwide_pickup_link.displayed?
    }	
    end	
    
    def airports_worldwide_dropoff_link 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
      wait.until {  
      @airports_worldwide_dropoff_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide dropoff link').by_css_locator)
      @airports_worldwide_dropoff_link if @airports_worldwide_dropoff_link.displayed?
    }	
    end	  
    
    def airports_worldwide_overlay_title 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
      wait.until {  
      @airports_worldwide_overlay_title = self.driver.find_element(:id => self.db_object.elements.find_by_name('airports worldwide overlay title').by_id_locator)
      @airports_worldwide_overlay_title if @airports_worldwide_overlay_title.displayed?
    }	
    end	   

    def airports_worldwide_departure_link 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
      wait.until {  
      @airports_worldwide_departure_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide departure link').by_css_locator)
      @airports_worldwide_departure_link if @airports_worldwide_departure_link.displayed?
    }	
    end	  
    
    def airports_worldwide_overlay_icon_close_button 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
      wait.until {  
      @airports_worldwide_overlay_icon_close_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide overlay icon close button').by_css_locator)
      @airports_worldwide_overlay_icon_close_button if @airports_worldwide_overlay_icon_close_button.displayed?
    }	
    end	    

    def airports_worldwide_overlay_us_airports_tab 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
      wait.until {  
      @airports_worldwide_overlay_us_airports_tab = self.driver.find_element(:id => self.db_object.elements.find_by_name('airports worldwide overlay us airports tab').by_id_locator)
      @airports_worldwide_overlay_us_airports_tab if @airports_worldwide_overlay_us_airports_tab.displayed?
    }	  
    end    
    
    def airports_worldwide_overlay_us_airports_abecedary_letter_link 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
      wait.until {  
      @airports_worldwide_overlay_us_airports_abecedary_letter_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide overlay us airports abecedary letter link').by_css_locator)
      @airports_worldwide_overlay_us_airports_abecedary_letter_link if @airports_worldwide_overlay_us_airports_abecedary_letter_link.displayed?
    }	
    end   

    def airports_worldwide_overlay_us_airports_code_link 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
      wait.until {  
      @airports_worldwide_overlay_us_airports_code_link = self.driver.find_element(:id => self.db_object.elements.find_by_name('airports worldwide overlay us airports code link').by_id_locator)
      @airports_worldwide_overlay_us_airports_code_link if @airports_worldwide_overlay_us_airports_code_link.displayed?
    }	
    end    
    
    def airports_worldwide_overlay_canadian_airports_tab 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
      wait.until {  
      @airports_worldwide_overlay_canadian_airports_tab = self.driver.find_element(:id => self.db_object.elements.find_by_name('airports worldwide overlay canadian airports tab').by_id_locator)
      @airports_worldwide_overlay_canadian_airports_tab if @airports_worldwide_overlay_canadian_airports_tab.displayed?
    }    
    end
    
    def airports_worldwide_overlay_canadian_airports_code_link 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
      wait.until {  
      @airports_worldwide_overlay_canadian_airports_code_link = self.driver.find_element(:id => self.db_object.elements.find_by_name('airports worldwide overlay canadian airports code link').by_id_locator)
      @airports_worldwide_overlay_canadian_airports_code_link if @airports_worldwide_overlay_canadian_airports_code_link.displayed?
    }	
    end   

    def airports_worldwide_overlay_intl_airports_tab 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
      wait.until {  
      @airports_worldwide_overlay_intl_airports_tab = self.driver.find_element(:id => self.db_object.elements.find_by_name('airports worldwide overlay intl airports tab').by_id_locator)
      @airports_worldwide_overlay_intl_airports_tab if @airports_worldwide_overlay_intl_airports_tab.displayed?
    }	
    end    

    def airports_worldwide_overlay_intl_airports_abecedary_letter_link 
        wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
        wait.until {  
        @airports_worldwide_overlay_intl_airports_abecedary_letter_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide overlay intl airports abecedary letter link').by_css_locator)
        @airports_worldwide_overlay_intl_airports_abecedary_letter_link if @airports_worldwide_overlay_intl_airports_abecedary_letter_link.displayed?
      }	
    end    
    
    def airports_worldwide_overlay_intl_airports_code_link
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
      wait.until {  
      @airports_worldwide_overlay_intl_airports_code_link = self.driver.find_element(:id => self.db_object.elements.find_by_name('airports worldwide overlay intl airports code link').by_id_locator)
      @airports_worldwide_overlay_intl_airports_code_link if @airports_worldwide_overlay_intl_airports_code_link.displayed?
    }	
    end      

    def airports_worldwide_arrival_link 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
      wait.until {  
      @airports_worldwide_arrival_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide arrival link').by_css_locator)
      @airports_worldwide_arrival_link if @airports_worldwide_arrival_link.displayed?
    }	
    end	    
    
    def airports_worldwide_overlay_us_airports_back_to_top_link 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
      wait.until {  
      @airports_worldwide_overlay_us_airports_back_to_top_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide overlay us airports back to top link').by_css_locator)
      @airports_worldwide_overlay_us_airports_back_to_top_link if @airports_worldwide_overlay_us_airports_back_to_top_link.displayed?
    }	
    end  
    
    def airports_worldwide_overlay_us_scrollpane
        wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
        wait.until {  
        @airports_worldwide_overlay_us_scrollpane = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide overlay us scrollpane').by_css_locator)
        @airports_worldwide_overlay_us_scrollpane if @airports_worldwide_overlay_us_scrollpane.displayed?
      }	
    end  
    
    def airports_worldwide_overlay_intl_airports_back_to_top_link 
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
      wait.until {  
      @airports_worldwide_overlay_intl_airports_back_to_top_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide overlay intl airports back to top link').by_css_locator)
      @airports_worldwide_overlay_intl_airports_back_to_top_link if @airports_worldwide_overlay_intl_airports_back_to_top_link.displayed?
    }	
    end

    def airports_worldwide_overlay_intl_scrollpane
      wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
      wait.until {  
      @airports_worldwide_overlay_intl_scrollpane = self.driver.find_element(:css => self.db_object.elements.find_by_name('airports worldwide overlay intl scrollpane').by_css_locator)
      @airports_worldwide_overlay_intl_scrollpane if @airports_worldwide_overlay_intl_scrollpane.displayed?
    }	
    end        
end
