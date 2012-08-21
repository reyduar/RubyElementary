require 'rubygems'
require 'selenium-webdriver'
require 'spec_helper'
require_relative '../../../lib/base_page'

TIMEOUT = RSpec.configuration.timeout

class HotelResultsPage < BasePage  
  def initialize(driver, test_env)   
    @db_object = Page.find_by_name('hotel results page')
    @url = Environment.find_by_name(test_env).base_url + Page.find_by_name('hotel results page').url
    @title = Page.find_by_name('hotel results page').title
    @driver = driver 
  end  
  
  def number_of_results 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @number_of_results = self.driver.find_element(:css => self.db_object.elements.find_by_name('number of results').by_css_locator)
	  @number_of_results if @number_of_results.displayed?
	}	
	end	 

  def results_hotel_cards
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @results_hotel_cards = self.driver.find_elements(:css => self.db_object.elements.find_by_name('results hotel cards').by_css_locator)
	  @results_hotel_cards if @results_hotel_cards[0].displayed?
	}	
	end 

  def loading_more_results_element
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @loading_more_results_element = self.driver.find_element(:css => self.db_object.elements.find_by_name('loading more results element').by_css_locator)
	  @loading_more_results_element if @loading_more_results_element.displayed?
	}	
	end 

	def hotel_card_titles
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @hotel_card_titles = self.driver.find_elements(:css => self.db_object.elements.find_by_name("hotel card titles").by_css_locator)
	  @hotel_card_titles if @hotel_card_titles[0].displayed?
	}
	end 
  
  def sort_by_combobox 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @sort_by_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('sort by combobox').by_css_locator)
	  @sort_by_combobox if @sort_by_combobox.displayed?
	}	
	end	
  
  def sort_by_combobox_values
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @sort_by_combobox_values = self.driver.find_elements(:css => self.db_object.elements.find_by_name('sort by combobox values').by_css_locator)
	  @sort_by_combobox_values if @sort_by_combobox_values[0].displayed?
	}	
	end 

	def destination_textbox
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @destination_textbox = self.driver.find_element(:id => self.db_object.elements.find_by_name('destination textbox').by_id_locator)
	  @destination_textbox if @destination_textbox.displayed?
	}
	end  
  
  def check_in_date_calendar
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @check_in_date_calendar = self.driver.find_element(:id => self.db_object.elements.find_by_name('check-in date calendar').by_id_locator)
	  @check_in_date_calendar if @check_in_date_calendar.displayed?
	}
	end
  
  def check_out_date_calendar
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @check_out_date_calendar = self.driver.find_element(:id => self.db_object.elements.find_by_name('check-out date calendar').by_id_locator)
	  @check_out_date_calendar if @check_out_date_calendar.displayed?
	}
	end
  
  def room_text_link 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @room_text_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('room text link').by_css_locator)
	  @room_text_link if @room_text_link.displayed?
	}	
	end	
  
  def guest_text_link 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @guest_text_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('guest text link').by_css_locator)
	  @guest_text_link if @guest_text_link.displayed?
	}	
	end	
  
  def results_hotel_names
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @results_hotel_names = self.driver.find_elements(:css => self.db_object.elements.find_by_name('results hotel names').by_css_locator)
	  @results_hotel_names if @results_hotel_names[0].displayed?
	}	
	end 
  
  def results_hotel_prices
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @results_hotel_prices = self.driver.find_elements(:css => self.db_object.elements.find_by_name('results hotel prices').by_css_locator)
	  @results_hotel_prices if @results_hotel_prices[0].displayed?
	}	
	end 
  
  def first_card_star_five
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @first_card_star_five = self.driver.find_element(:css => self.db_object.elements.find_by_name('first card star five').by_css_locator)
	  @first_card_star_five if @first_card_star_five.displayed?
	}	
	end 
  
  def first_card_star_four
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @first_card_star_four = self.driver.find_element(:css => self.db_object.elements.find_by_name('first card star four').by_css_locator)
	  @first_card_star_four if @first_card_star_four.displayed?
	}	
	end  
  
  def first_card_star_three
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @first_card_star_three = self.driver.find_element(:css => self.db_object.elements.find_by_name('first card star three').by_css_locator)
	  @first_card_star_three if @first_card_star_three.displayed?
	}	
	end 
  
  def second_card_star_five
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @second_card_star_five = self.driver.find_element(:css => self.db_object.elements.find_by_name('second card star five').by_css_locator)
	  @second_card_star_five if @second_card_star_five.displayed?
	}	
	end
  
  def second_card_star_four
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @second_card_star_four = self.driver.find_element(:css => self.db_object.elements.find_by_name('second card star four').by_css_locator)
	  @second_card_star_four if @second_card_star_four.displayed?
	}	
	end
  
  def second_card_star_three
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @second_card_star_three = self.driver.find_element(:css => self.db_object.elements.find_by_name('second card star three').by_css_locator)
	  @second_card_star_three if @second_card_star_three.displayed?
	}	
	end
  
  def third_card_star_five
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @third_card_star_five = self.driver.find_element(:css => self.db_object.elements.find_by_name('third card star five').by_css_locator)
	  @third_card_star_five if @third_card_star_five.displayed?
	}	
	end
  
  def third_card_star_four
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @third_card_star_four = self.driver.find_element(:css => self.db_object.elements.find_by_name('third card star four').by_css_locator)
	  @third_card_star_four if @third_card_star_four.displayed?
	}	
	end
  
  def third_card_star_three
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @third_card_star_three = self.driver.find_element(:css => self.db_object.elements.find_by_name('third card star three').by_css_locator)
	  @third_card_star_three if @third_card_star_three.displayed?
	}	
	end
  
  def icon_magnifying_glass
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @icon_magnifying_glass = self.driver.find_element(:css => self.db_object.elements.find_by_name('icon magnifying glass').by_css_locator)
	  @icon_magnifying_glass if @icon_magnifying_glass.displayed?
	}	
	end
  
  def map_image_location_hotel
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @map_image_location_hotel = self.driver.find_element(:css => self.db_object.elements.find_by_name('map image location hotel').by_css_locator)
	  @map_image_location_hotel if @map_image_location_hotel.displayed?
	}	
	end
  
  def hide_hotel_highlights_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hide_hotel_highlights_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('hide hotel highlights button').by_css_locator)
	  @hide_hotel_highlights_button if @hide_hotel_highlights_button.displayed?
	}	
	end

  def show_hotel_highlights_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @show_hotel_highlights_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('show hotel highlights button').by_css_locator)
	  @show_hotel_highlights_button if @show_hotel_highlights_button.displayed?
	}	
	end
  
  def update_button  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @update_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('update button').by_css_locator)
	  @update_button if @update_button.displayed?
	}	
	end  
  
  def hotel_card_description_div  
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @hotel_card_description_div = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel card description div').by_css_locator)
	  @hotel_card_description_div if @hotel_card_description_div.displayed?
	}	
	end  
  
  def hotel_card_more_description_link
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @hotel_card_more_description_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel card more description link').by_css_locator)
	  @hotel_card_more_description_link if @hotel_card_more_description_link.displayed?
	}	
	end  
  
  def hotel_card_select_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @hotel_card_select_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel card select button').by_css_locator)
	  @hotel_card_select_button if @hotel_card_select_button.displayed?
	}	
	end 
  
  def hotel_card_more_details_link
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @hotel_card_more_details_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel card more details link').by_css_locator)
	  @hotel_card_more_details_link if @hotel_card_more_details_link.displayed?
	}	
	end 
  
  def hotel_card_login_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @hotel_card_login_button = self.driver.find_elements(:css => self.db_object.elements.find_by_name('hotel card login buttons').by_css_locator)[0]
	  @hotel_card_login_button if @hotel_card_login_button.displayed?
	}	
	end  

  def hotel_card_book_now_pay_later_divs
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @hotel_card_book_now_pay_later_divs = self.driver.find_elements(:css => self.db_object.elements.find_by_name('hotel card book now pay later divs').by_css_locator)
	  @hotel_card_book_now_pay_later_divs if @hotel_card_book_now_pay_later_divs[0].displayed?
	}	
	end 
  
  def lowest_rate_guaranteed_banner_title
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @lowest_rate_guaranteed_banner_title = self.driver.find_element(:css => self.db_object.elements.find_by_name('lowest rate guaranteed banner title').by_css_locator)
	  @lowest_rate_guaranteed_banner_title if @lowest_rate_guaranteed_banner_title.displayed?
	}	
	end   

  def start_a_new_search_link
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @start_a_new_search_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('start a new search link').by_css_locator)
	  @start_a_new_search_link if @start_a_new_search_link.displayed?
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
    
  def interstitial_main_text_label
    wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
    wait.until {
    @interstitial_main_text_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('interstitial main text label').by_css_locator)
    @interstitial_main_text_label if @interstitial_main_text_label.displayed?
    }
  end
   
  def hotel_card_more_details_links
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_card_more_details_links = self.driver.find_elements(:css => self.db_object.elements.find_by_name('hotel card more details links').by_css_locator)
	  @hotel_card_more_details_links if @hotel_card_more_details_links[0].displayed?
	}	
	end

  def hotel_card_photos_img
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_card_photos_img = self.driver.find_elements(:css => self.db_object.elements.find_by_name('hotel card photos img').by_css_locator)
	  @hotel_card_photos_img if @hotel_card_photos_img[0].displayed?
	}	
	end   
  
  def lowest_rate_guaranteed_banner_points_logos
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @lowest_rate_guaranteed_banner_points_logos = self.driver.find_element(:css => self.db_object.elements.find_by_name('lowest rate guaranteed banner points logos').by_css_locator)
	  @lowest_rate_guaranteed_banner_points_logos if @lowest_rate_guaranteed_banner_points_logos.displayed?
	}	
	end 

  def hotel_card_pay_points_divs
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @hotel_card_pay_points_divs = self.driver.find_element(:css => self.db_object.elements.find_by_name('hotel card pay points divs').by_css_locator)
	  @hotel_card_pay_points_divs if @hotel_card_pay_points_divs.displayed?
	}	
	end 
  
  def hotel_card_lowest_rate_question_buttons
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @hotel_card_lowest_rate_question_buttons = self.driver.find_elements(:css => self.db_object.elements.find_by_name('hotel card lowest rate question buttons').by_css_locator)
	  @hotel_card_lowest_rate_question_buttons if @hotel_card_lowest_rate_question_buttons[0].displayed?
	}	
	end 
  
  def hotel_card_special_offer_question_buttons
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @hotel_card_special_offer_question_buttons = self.driver.find_elements(:css => self.db_object.elements.find_by_name('hotel card special offer question buttons').by_css_locator)
	  @hotel_card_special_offer_question_buttons if @hotel_card_special_offer_question_buttons[0].displayed?
	}	
	end 
  
  def hotel_card_show_hotel_highlights_buttons
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @hotel_card_show_hotel_highlights_buttons = self.driver.find_elements(:css => self.db_object.elements.find_by_name('hotel card show hotel highlights buttons').by_css_locator)
	  @hotel_card_show_hotel_highlights_buttons if @hotel_card_show_hotel_highlights_buttons[0].displayed?
	}	
	end 
  
  def hotel_card_promo_more_links
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @hotel_card_promo_more_links = self.driver.find_elements(:css => self.db_object.elements.find_by_name('hotel card promo more links').by_css_locator)
	  @hotel_card_promo_more_links if @hotel_card_promo_more_links[0].displayed?
	}	
	end
  
  def hotel_card_description_text_divs
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @hotel_card_description_text_divs = self.driver.find_elements(:css => self.db_object.elements.find_by_name('hotel card description text divs').by_css_locator)
	  @hotel_card_description_text_divs if @hotel_card_description_text_divs[0].displayed?
	}	
	end
  
  def overlay_special_offer_for_you_title_1
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @overlay_special_offer_for_you_title_1 = self.driver.find_element(:css => self.db_object.elements.find_by_name('overlay special offer for you title 1').by_css_locator)
	  @overlay_special_offer_for_you_title_1 if @overlay_special_offer_for_you_title_1.displayed?
	}	
	end
  
  def overlay_special_offer_for_you_title_2
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @overlay_special_offer_for_you_title_2 = self.driver.find_element(:css => self.db_object.elements.find_by_name('overlay special offer for you title 2').by_css_locator)
	  @overlay_special_offer_for_you_title_2 if @overlay_special_offer_for_you_title_2.displayed?
	}	
	end
  
  def hotel_card_hide_hotel_highlights_buttons
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @hotel_card_hide_hotel_highlights_buttons = self.driver.find_elements(:css => self.db_object.elements.find_by_name('hotel card hide hotel highlights buttons').by_css_locator)
	  @hotel_card_hide_hotel_highlights_buttons if @hotel_card_hide_hotel_highlights_buttons[0].displayed?
	}	
	end 
  
  def hotel_card_average_nightly_rate_labels
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_card_average_nightly_rate_labels = self.driver.find_elements(:css => self.db_object.elements.find_by_name('hotel card average nightly rate labels').by_css_locator)
	  @hotel_card_average_nightly_rate_labels if @hotel_card_average_nightly_rate_labels[0].displayed?
	}	
	end
  
  def hotel_card_price_number_labels
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_card_price_number_labels = self.driver.find_elements(:css => self.db_object.elements.find_by_name('hotel card price number labels').by_css_locator)
	  @hotel_card_price_number_labels if @hotel_card_price_number_labels[0].displayed?
	}	
	end
  
  def sort_by_combobox 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @sort_by_combobox = self.driver.find_element(:css => self.db_object.elements.find_by_name('sort by combobox').by_css_locator)
	  @sort_by_combobox if @sort_by_combobox.displayed?
	}	
	end  
  
  def sort_by_combobox_values
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @sort_by_combobox_values = self.driver.find_elements(:css => self.db_object.elements.find_by_name('sort by combobox values').by_css_locator)
	  @sort_by_combobox_values if @sort_by_combobox_values[0].displayed?
	}	
	end 
  
  def hotel_card_price_currencies
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @hotel_card_price_currencies = self.driver.find_elements(:css => self.db_object.elements.find_by_name('hotel card price currencies').by_css_locator)
	  @hotel_card_price_currencies if @hotel_card_price_currencies[0].displayed?
	}	
	end
  
  def map_view_tab 
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @map_view_tab = self.driver.find_element(:css => self.db_object.elements.find_by_name('map view tab').by_css_locator)
	  @map_view_tab if @map_view_tab.displayed?
	}	
	end  
  
  def plot_location_label
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @plot_location_label = self.driver.find_element(:css => self.db_object.elements.find_by_name('plot location label').by_css_locator)
	  @plot_location_label if @plot_location_label.displayed?
	}	
	end 
  
  def map_pin_number_1
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @map_pin_number_1 = self.driver.find_element(:xpath => self.db_object.elements.find_by_name('map pin number 1').by_xpath_locator)
	  @map_pin_number_1 if @map_pin_number_1.displayed?
	}	
	end 
  
  def map_pin_number_2
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @map_pin_number_2 = self.driver.find_element(:xpath => self.db_object.elements.find_by_name('map pin number 2').by_xpath_locator)
	  @map_pin_number_2 if @map_pin_number_2.displayed?
	}	
	end 

  def map_view_detail_box_1
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @map_view_detail_box_1 = self.driver.find_element(:xpath => self.db_object.elements.find_by_name('map view detail box 1').by_xpath_locator)
	  @map_view_detail_box_1 if @map_view_detail_box_1.displayed?
	}	
	end 
  
   def map_view_detail_box_2
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @map_view_detail_box_2 = self.driver.find_element(:xpath => self.db_object.elements.find_by_name('map view detail box 2').by_xpath_locator)
	  @map_view_detail_box_2 if @map_view_detail_box_2.displayed?
	}	
	end 
  
  def map_view_detail_box_1_close_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @map_view_detail_box_1_close_button = self.driver.find_element(:xpath => self.db_object.elements.find_by_name('map view detail box 1 close button').by_xpath_locator)
	  @map_view_detail_box_1_close_button if @map_view_detail_box_1_close_button.displayed?
	}	
	end 
  
  
  def map_view_detail_box_1_more_details_link
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @map_view_detail_box_1_more_details_link = self.driver.find_element(:css => self.db_object.elements.find_by_name('map view detail box 1 more details link').by_css_locator)
	  @map_view_detail_box_1_more_details_link if @map_view_detail_box_1_more_details_link.displayed?
	}	
	end 
  
  def plot_location_quest_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @plot_location_quest_button = self.driver.find_element(:css => self.db_object.elements.find_by_name('plot location quest button').by_css_locator)
	  @plot_location_quest_button if @plot_location_quest_button.displayed?
	}	
	end 
  
  def overlay_plot_location_title
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @overlay_plot_location_title = self.driver.find_element(:css => self.db_object.elements.find_by_name('overlay plot location title').by_css_locator)
	  @overlay_plot_location_title if @overlay_plot_location_title.displayed?
	}	
	end
  
  def overlay_plot_location_close_button
	  wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {  
    @overlay_plot_location_close_button = self.driver.find_element(:xpath => self.db_object.elements.find_by_name('overlay plot location close button').by_xpath_locator)
	  @overlay_plot_location_close_button if @overlay_plot_location_close_button.displayed?
	}	
	end
  
  def entered_location_alert_error 
	   wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @entered_location_alert_error = self.driver.find_element(:css => self.db_object.elements.find_by_name('entered location alert error').by_css_locator)
	  @entered_location_alert_error if @entered_location_alert_error.displayed?
	}	
	end
  
  def plot_location_textbox 
	   wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @plot_location_textbox = self.driver.find_element(:css => self.db_object.elements.find_by_name('plot location textbox').by_css_locator)
	  @plot_location_textbox if @plot_location_textbox.displayed?
	}	
	end
  
  def plot_location_glass_icon 
	   wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @plot_location_glass_icon = self.driver.find_element(:css => self.db_object.elements.find_by_name('plot location glass icon').by_css_locator)
	  @plot_location_glass_icon if @plot_location_glass_icon.displayed?
	}	
	end
  
  def plot_location_delete_marker_icon 
	   wait = Selenium::WebDriver::Wait.new(:timeout => TIMEOUT)
	  wait.until {
	  @plot_location_delete_marker_icon = self.driver.find_element(:css => self.db_object.elements.find_by_name('plot location delete marker icon').by_css_locator)
	  @plot_location_delete_marker_icon if @plot_location_delete_marker_icon.displayed?
	}	
	end
end