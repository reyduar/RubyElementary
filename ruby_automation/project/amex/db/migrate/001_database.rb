class Database < ActiveRecord::Migration
  def self.up
    ActiveRecord::Schema.define do
      create_table :pages do |t|
        t.string :name, :null => false
        t.string :url, :null => false
        t.string :title
      end
      create_table :elements do |t|
        t.integer :page_id, :null => false
        t.string :name, :null => false
        t.string :by_id_locator
        t.string :by_css_locator 
        t.string :by_xpath_locator 
        t.string :by_class_locator         
        t.string :by_link_text_locator            
        t.string :by_name            
        t.string :text
        t.timestamps
      end
      
      create_table :environments do |t|
        t.string :name, :null => false
        t.string :base_url
        t.string :browser_name
        t.string :browser_version
        t.string :platform
        t.integer :timeout
      end

      create_table :features do |t|
        t.string :name, :null => false  
      end 

      create_table :verifications do |t|
        t.integer :feature_id, :null => false
        t.string :name, :null => false
        t.string :text, :null => false
        t.timestamps
      end
      
      create_table :flights do |t|
        t.string :name, :null => false  
        t.boolean :round_trip_option
        t.boolean :one_way_option
        t.boolean :multi_city_option
        t.integer :add_another_flight
        t.string  :departure_city_1
        t.string  :departure_city_2
        t.string  :departure_city_3
        t.string  :departure_city_4
        t.string  :departure_city_5
        t.string  :departure_city_6      
        t.string  :arrival_city_1
        t.string  :arrival_city_2
        t.string  :arrival_city_3
        t.string  :arrival_city_4
        t.string  :arrival_city_5
        t.string  :arrival_city_6      
        t.string  :departure_date_1
        t.string  :departure_date_2
        t.string  :departure_date_3
        t.string  :departure_date_4
        t.string  :departure_date_5
        t.string  :departure_date_6      
        t.string  :return_date      
        t.string  :departure_time_1
        t.string  :departure_time_2
        t.string  :departure_time_3
        t.string  :departure_time_4
        t.string  :departure_time_5
        t.string  :departure_time_6      
        t.string  :return_time  
        t.integer :adults
        t.integer :seniors
        t.integer :children
        t.integer :children_age_1
        t.integer :children_age_2        
        t.integer :children_age_3
        t.integer :children_age_4
        t.boolean :children_seated_option_1
        t.boolean :children_seated_option_2
        t.boolean :children_seated_option_3
        t.boolean :children_seated_option_4
        t.boolean :children_lap_option_1        
        t.boolean :children_lap_option_2   
        t.boolean :children_lap_option_3   
        t.boolean :children_lap_option_4                   
        t.integer :infants_in_seat
        t.boolean :show_only_non_stop_flights
        t.string  :fare_class 
        t.boolean :show_only_refundable_fares
        t.boolean :search_only_preferred_airline
      end
      
      create_table :packages do |t|
        t.string :name, :null => false  
        t.string  :departure_city   
        t.string  :arrival_city    
        t.string  :departure_date    
        t.string  :return_date      
        t.string  :departure_time   
        t.string  :return_time  
        t.integer :rooms        
        t.integer :adults_1
        t.integer :seniors_1
        t.integer :children_1
        t.integer :adults_2
        t.integer :seniors_2
        t.integer :children_2
        t.integer :adults_3
        t.integer :seniors_3
        t.integer :children_3
        t.integer :adults_4
        t.integer :seniors_4
        t.integer :children_4                
        t.integer :room_1_children_age_1
        t.integer :room_1_children_age_2        
        t.integer :room_1_children_age_3
        t.integer :room_1_children_age_4
        t.integer :room_1_children_age_5        
        t.boolean :room_1_children_seated_option_1
        t.boolean :room_1_children_seated_option_2
        t.boolean :room_1_children_seated_option_3
        t.boolean :room_1_children_seated_option_4
        t.boolean :room_1_children_seated_option_5
        t.boolean :room_1_children_lap_option_1        
        t.boolean :room_1_children_lap_option_2   
        t.boolean :room_1_children_lap_option_3   
        t.boolean :room_1_children_lap_option_4  
        t.boolean :room_1_children_lap_option_5   
        t.integer :room_2_children_age_1
        t.integer :room_2_children_age_2        
        t.integer :room_2_children_age_3
        t.integer :room_2_children_age_4
        t.integer :room_2_children_age_5        
        t.boolean :room_2_children_seated_option_1
        t.boolean :room_2_children_seated_option_2
        t.boolean :room_2_children_seated_option_3
        t.boolean :room_2_children_seated_option_4
        t.boolean :room_2_children_seated_option_5
        t.boolean :room_2_children_lap_option_1        
        t.boolean :room_2_children_lap_option_2   
        t.boolean :room_2_children_lap_option_3   
        t.boolean :room_2_children_lap_option_4  
        t.boolean :room_2_children_lap_option_5  
        t.integer :room_3_children_age_1
        t.integer :room_3_children_age_2        
        t.integer :room_3_children_age_3
        t.integer :room_3_children_age_4
        t.integer :room_3_children_age_5        
        t.boolean :room_3_children_seated_option_1
        t.boolean :room_3_children_seated_option_2
        t.boolean :room_3_children_seated_option_3
        t.boolean :room_3_children_seated_option_4
        t.boolean :room_3_children_seated_option_5
        t.boolean :room_3_children_lap_option_1        
        t.boolean :room_3_children_lap_option_2   
        t.boolean :room_3_children_lap_option_3   
        t.boolean :room_3_children_lap_option_4  
        t.boolean :room_3_children_lap_option_5  
        t.integer :room_4_children_age_1
        t.integer :room_4_children_age_2        
        t.integer :room_4_children_age_3
        t.integer :room_4_children_age_4
        t.integer :room_4_children_age_5        
        t.boolean :room_4_children_seated_option_1
        t.boolean :room_4_children_seated_option_2
        t.boolean :room_4_children_seated_option_3
        t.boolean :room_4_children_seated_option_4
        t.boolean :room_4_children_seated_option_5
        t.boolean :room_4_children_lap_option_1        
        t.boolean :room_4_children_lap_option_2   
        t.boolean :room_4_children_lap_option_3   
        t.boolean :room_4_children_lap_option_4  
        t.boolean :room_4_children_lap_option_5                  
        t.boolean :show_only_non_stop_flights       
      end      
     
        create_table :hotels do |t|
        t.string :name, :null => false  
        t.boolean :by_city_or_landmark_option
        t.boolean :by_address_option             
        t.string  :destination
        t.string  :check_in_date
        t.string  :check_out_date
        t.integer :rooms        
        t.integer :adults_1
        t.integer :children_1
        t.integer :adults_2
        t.integer :children_2
        t.integer :adults_3
        t.integer :children_3
        t.integer :adults_4
        t.integer :children_4                
        t.integer :room_1_children_age_1
        t.integer :room_1_children_age_2        
        t.integer :room_1_children_age_3
        t.integer :room_1_children_age_4
        t.integer :room_1_children_age_5        
        t.boolean :room_1_children_seated_option_1
        t.boolean :room_1_children_seated_option_2
        t.boolean :room_1_children_seated_option_3
        t.boolean :room_1_children_seated_option_4
        t.boolean :room_1_children_seated_option_5
        t.boolean :room_1_children_lap_option_1        
        t.boolean :room_1_children_lap_option_2   
        t.boolean :room_1_children_lap_option_3   
        t.boolean :room_1_children_lap_option_4  
        t.boolean :room_1_children_lap_option_5   
        t.integer :room_2_children_age_1
        t.integer :room_2_children_age_2        
        t.integer :room_2_children_age_3
        t.integer :room_2_children_age_4
        t.integer :room_2_children_age_5        
        t.boolean :room_2_children_seated_option_1
        t.boolean :room_2_children_seated_option_2
        t.boolean :room_2_children_seated_option_3
        t.boolean :room_2_children_seated_option_4
        t.boolean :room_2_children_seated_option_5
        t.boolean :room_2_children_lap_option_1        
        t.boolean :room_2_children_lap_option_2   
        t.boolean :room_2_children_lap_option_3   
        t.boolean :room_2_children_lap_option_4  
        t.boolean :room_2_children_lap_option_5  
        t.integer :room_3_children_age_1
        t.integer :room_3_children_age_2        
        t.integer :room_3_children_age_3
        t.integer :room_3_children_age_4
        t.integer :room_3_children_age_5        
        t.boolean :room_3_children_seated_option_1
        t.boolean :room_3_children_seated_option_2
        t.boolean :room_3_children_seated_option_3
        t.boolean :room_3_children_seated_option_4
        t.boolean :room_3_children_seated_option_5
        t.boolean :room_3_children_lap_option_1        
        t.boolean :room_3_children_lap_option_2   
        t.boolean :room_3_children_lap_option_3   
        t.boolean :room_3_children_lap_option_4  
        t.boolean :room_3_children_lap_option_5  
        t.integer :room_4_children_age_1
        t.integer :room_4_children_age_2        
        t.integer :room_4_children_age_3
        t.integer :room_4_children_age_4
        t.integer :room_4_children_age_5        
        t.boolean :room_4_children_seated_option_1
        t.boolean :room_4_children_seated_option_2
        t.boolean :room_4_children_seated_option_3
        t.boolean :room_4_children_seated_option_4
        t.boolean :room_4_children_seated_option_5
        t.boolean :room_4_children_lap_option_1        
        t.boolean :room_4_children_lap_option_2   
        t.boolean :room_4_children_lap_option_3   
        t.boolean :room_4_children_lap_option_4  
        t.boolean :room_4_children_lap_option_5                  
      end  

      create_table :cars do |t|
        t.string :name, :null => false  
        t.boolean :dropoff_same_as_pickup
        t.boolean :different_dropoff_location        
        t.boolean :pickup_in_address
        t.boolean :dropoff_in_address        
        t.string :pickup_city
        t.string :dropoff_city
        t.string :pickup_date
        t.string :dropoff_date
        t.string :car_rental_company
        t.string :discount_code
        t.string :ac_option
        t.string :transmission_option
        t.string :pickup_country
        t.string :pickup_address
        t.string :pickup_city_address
        t.string :pickup_zip
        t.string :pickup_state
        t.string :dropoff_country
        t.string :dropoff_address
        t.string :dropoff_city_address
        t.string :dropoff_zip
        t.string :dropoff_state            
      end

      create_table :results do |t|
        t.string :departure_city
        t.text :arrival_city
      end		
      create_table :baggage_fees do |t|
        t.string :name, :null => false        
        t.string :first_airline
        t.string :second_airline
        t.string :third_airline        
      end    
    end
  end

  def self.down
    drop_table :pages
    drop_table :environments
    drop_table :elements
    drop_table :flights
    drop_table :hotels
    drop_table :cars
    drop_table :packages
    drop_table :results
    drop_table :features
    drop_table :verifications    
    drop_table :baggage_fees      
  end
end
