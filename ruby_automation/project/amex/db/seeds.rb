require 'active_record'

class Page < ActiveRecord::Base
	has_many :elements
	has_one :pages
end

class Element < ActiveRecord::Base
	has_one :elements
  belongs_to :pages  
end

class Feature < ActiveRecord::Base
	has_many :verifications
	has_one :features
end

class Verification < ActiveRecord::Base
	has_one :verifications
  belongs_to :features  
end

class Flight < ActiveRecord::Base
    has_one :flights
end

class Hotel < ActiveRecord::Base
    has_one :hotels
end

class Car < ActiveRecord::Base
    has_one :cars
end

class Package < ActiveRecord::Base
    has_one :packages
end

class Result < ActiveRecord::Base
    has_one :results
end

class Environment < ActiveRecord::Base
    has_one :environments
end

class BaggageFee < ActiveRecord::Base
    has_one :baggage_fees
end

############# ENVIRONMENT ##############
Environment.delete_all
Environment.create(:name => 'QAFirefox', 
           :base_url => 'http://amex-qa.iseatz.com/', 
           :browser_name => 'firefox',
           :browser_version => '3.6',
           :platform => 'Linux')
Environment.create(:name => 'FQAFirefox', 
           :base_url => 'http://amex-fqa.iseatz.com/', 
           :browser_name => 'firefox',
           :browser_version => '3.6',
           :platform => 'Linux')
Environment.create(:name => 'devFirefox', 
           :base_url => 'http://amex-dev.iseatz.com/', 
           :browser_name => 'firefox',
           :browser_version => '3.6',
           :platform => 'Linux')  
Environment.create(:name => 'Lucas', 
           :base_url => 'http://10.20.11.70:3005/', 
           :browser_name => 'firefox',
           :browser_version => '3.6',
           :platform => 'Linux')                    

############# FLIGHT ##############                      
Flight.delete_all
Flight.create(:name => 'basic one way', :one_way_option => true, :departure_city_1 => 'Miami International Airport, FL, US', :arrival_city_1 => 'Chicago Midway Airport, IL, US', :departure_date_1 => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
Flight.create(:name => 'basic one way - first class', :one_way_option => true, :departure_city_1 => 'Miami', :arrival_city_1 => 'Chicago', :departure_date_1 => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :fare_class => 'Business Class')
Flight.create(:name => 'one way - matrix options', :one_way_option => true, :departure_city_1 => 'Los Angeles International Airport, CA, US', :arrival_city_1 => 'Orlando International Airport, FL, US', :departure_date_1 => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
Flight.create(:name => 'basic round trip', :round_trip_option => true, :departure_city_1 => 'Miami', :arrival_city_1 => 'Chicago', :departure_date_1 => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
Flight.create(:name => 'round trip 2 adult 2 senior 4 children', :round_trip_option => true, :departure_city_1 => 'Miami', :arrival_city_1 => 'Chicago', :departure_date_1 => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
:adults => '2', :seniors => '2', :children => '4', 
:children_age_1 => '1', :children_age_2 => '2', :children_age_3 => '1', :children_age_4 => '3',
:children_lap_option_1 => true, :children_seated_option_3 => true)

Flight.create(:name => 'basic multi city', :multi_city_option => true,  
:departure_city_1 => 'Miami International Airport, FL, US (MIA)', :arrival_city_1 => 'Los Angeles International Airport, CA, US (LAX)', 
:departure_city_2 => 'Los Angeles International Airport, CA, US (LAX)', :arrival_city_2 => 'John F. Kennedy International Airport, NY, US (JFK)', 
:departure_city_3 => 'John F. Kennedy International Airport, NY, US (JFK)', :arrival_city_3 => 'Orlando International Airport, FL, US (MCO)', 
:departure_date_1 => '(Time.now + (9 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
:departure_date_2 => '(Time.now + (23 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
:departure_date_3 => '(Time.now + (46 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
)
Flight.create(:name => 'basic round trip rate card alert', :round_trip_option => true, :departure_city_1 => 'Miami International Airport, FL, US (MIA)', :arrival_city_1 => 'Benitez International Airport, CL (SCL)', :departure_date_1 => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')

Flight.create(:name => 'basic multi city 2', :multi_city_option => true, :add_another_flight => 1, 
:departure_city_1 => 'Miami International Airport, FL, US (MIA)', :arrival_city_1 => 'Chicago Midway Airport, IL, US (MDW)', 
:departure_city_2 => 'Chicago Midway Airport, IL, US (MDW)', :arrival_city_2 => 'Los Angeles International Airport, CA, US (LAX)', 
:departure_city_3 => 'Los Angeles International Airport, CA, US (LAX)', :arrival_city_3 => 'John F. Kennedy International Airport, NY, US (JFK)',
:departure_date_1 => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
:departure_date_2 => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
:departure_date_3 => '(Time.now + (6 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')

############# PACKAGE ##############

Package.create(:name => 'simple dp search', :departure_city => 'Miami International Airport, FL, US', :arrival_city => 'Chicago Midway Airport, IL, US', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')

Package.create(:name => 'advanced search options elements', 
:rooms  => 4, :adults_1 => 6, :seniors_1 => 6, :children_1 => 5, :adults_2 => 6, :seniors_2 => 6, :children_2 => 5, :adults_3 => 6,
:seniors_3 => 6, :children_3 => 5, :adults_4 => 6, :seniors_4 => 6, :children_4 => 5)

Package.create(:name => 'one adult at least in each room', :departure_city => 'Miami International Airport, FL, US', :arrival_city => 'Chicago Midway Airport, IL, US', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
:rooms  => 4, :adults_1 => 1, :seniors_1 => 0, :children_1 => 0, :adults_2 => 1, :seniors_2 => 0, :children_2 => 0, :adults_3 => 1,
:seniors_3 => 0, :children_3 => 0, :adults_4 => 1, :seniors_4 => 0, :children_4 => 0)

Package.create(:name => 'one senior at least in each room', :departure_city => 'Miami International Airport, FL, US', :arrival_city => 'Chicago Midway Airport, IL, US', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
:rooms  => 4, :adults_1 => 0, :seniors_1 => 1, :children_1 => 0, :adults_2 => 0, :seniors_2 => 1, :children_2 => 0, :adults_3 => 0,
:seniors_3 => 1, :children_3 => 0, :adults_4 => 0, :seniors_4 => 1, :children_4 => 0)

Package.create(:name => 'only children in each room', :departure_city => 'Miami International Airport, FL, US', :arrival_city => 'Chicago Midway Airport, IL, US', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
:rooms  => 4, :adults_1 => 0, :seniors_1 => 0, :children_1 => 1, :adults_2 => 0, :seniors_2 => 0, :children_2 => 1, :adults_3 => 0,
:seniors_3 => 0, :children_3 => 1, :adults_4 => 0, :seniors_4 => 0, :children_4 => 1)

Package.create(:name => 'one adult at least per Infant in lap', :departure_city => 'Miami International Airport, FL, US (MIA)', :arrival_city => 'Chicago Midway Airport, IL, US (MDW)', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
:rooms  => 2, :adults_1 => 1, :seniors_1 => 0, :children_1 => 2, :adults_2 => 0, :seniors_2 => 0, :children_2 => 2)

Package.create(:name => 'one senior at least per Infant in lap', :departure_city => 'Miami International Airport, FL, US (MIA)', :arrival_city => 'Chicago Midway Airport, IL, US (MDW)', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
:rooms  => 2, :adults_1 => 0, :seniors_1 => 0, :children_1 => 2, :adults_2 => 0, :seniors_2 => 1, :children_2 => 2)

Package.create(:name => 'six people max per room', :departure_city => 'Miami International Airport, FL, US (MIA)', :arrival_city => 'Chicago Midway Airport, IL, US (MDW)', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
:rooms  => 2, :adults_1 => 1, :seniors_1 => 1, :children_1 => 1, :adults_2 => 2, :seniors_2 => 2, :children_2 => 3)

Package.create(:name => 'nine people max all rooms', :departure_city => 'Miami International Airport, FL, US (MIA)', :arrival_city => 'Chicago Midway Airport, IL, US (MDW)', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
:rooms  => 4, :adults_1 => 2, :seniors_1 => 1, :children_1 => 1, :adults_2 => 1, :seniors_2 => 0, :children_2 => 0,
:adults_3 => 0, :seniors_3 => 1, :children_3 => 0,
:adults_4 => 3, :seniors_4 => 0, :children_4 => 1, :room_4_children_seated_option_1 => true)

Package.create(:name => 'no departure city',:arrival_city => 'Chicago Midway Airport, IL, US (MDW)', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
Package.create(:name => 'no arrival city',:departure_city => 'Miami International Airport, FL, US (MIA)', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')

Package.create(:name => 'departure city and arrival code',:departure_city => 'Miami',:arrival_city => 'MDW', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
Package.create(:name => 'departure code and arrival city',:departure_city => 'MIA',:arrival_city => 'Chicago', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
Package.create(:name => 'same departure and arrival city',:departure_city => 'Miami International Airport, FL, US',:arrival_city => 'Miami International Airport, FL, US', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
Package.create(:name => 'autocomplete cities',:departure_city => 'Miami',:arrival_city => 'Chicago Midway Airport', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
Package.create(:name => 'wrong cities',:departure_city => 'gtrhmreop',:arrival_city => 'grgjgoreg', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')

#package_wk50_axpt2605_spec
Package.create(:name => 'no departure date',:departure_city => 'Miami International Airport, FL, US',:arrival_city => 'Chicago Midway Airport, IL, US', :departure_date => '', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
Package.create(:name => 'no return date',:departure_city => 'Miami International Airport, FL, US',:arrival_city => 'Chicago Midway Airport, IL, US', :departure_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '')
Package.create(:name => 'more than 331 days',:departure_city => 'Miami International Airport, FL, US',:arrival_city => 'Chicago Midway Airport, IL, US', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (334 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
Package.create(:name => 'return date before outbound',:departure_city => 'Miami International Airport, FL, US',:arrival_city => 'Los Angeles International Airport, CA, US', :departure_date => '(Time.now + (6 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (3 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
Package.create(:name => 'date in the future',:departure_city => 'Miami International Airport, FL, US',:arrival_city => 'Los Angeles International Airport, CA, US', :departure_date => '(Time.now + (35 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (3 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
Package.create(:name => 'same day outbound and return date',:departure_city => 'Miami International Airport, FL, US',:arrival_city => 'Los Angeles International Airport, CA, US', :departure_date => 'Time.now.localtime.strftime("%m/%d/%Y")', :return_date => 'Time.now.localtime.strftime("%m/%d/%Y")')
Package.create(:name => 'no flights avail',:departure_city => 'John F. Kennedy International Airport, NY, US',:arrival_city => 'La Guardia Airport, NY, US', :departure_date => 'Time.now.localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (3 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')

#package_wk02_axpt3299_spec
Package.create(:name => 'dp search summary',:departure_city => 'Miami International Airport, FL, US',:arrival_city => 'Chico Airport , CA, US', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (14 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
Package.create(:name => 'mixed to verify summary', :departure_city => 'Miami International Airport, FL, US', :arrival_city => 'Chicago Midway Airport, IL, US', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
:rooms  => 4, :adults_1 => 1, :children_1 => 1,:seniors_2 => 1, :children_2 => 1, :room_2_children_seated_option_1 => true,
:adults_3 => 1, :seniors_4 => 1)

#package_wk02_axpt3301_spec
Package.create(:name => 'round trip time morning 6am - noon',:departure_city => 'Miami International Airport, FL, US',:arrival_city => 'Chico Airport , CA, US', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (14 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
:departure_time => 'Morning: 6am - noon', :return_time => 'Morning: 6am - noon')
Package.create(:name => 'basic round trip',:departure_city => 'Miami International Airport, FL, US',:arrival_city => 'Chicago Midway Airport, IL, US', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (8 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
#package_sp05_axpt3802_spec
Package.create(:name => 'round trip flight rate card alert',:departure_city => 'Miami International Airport, FL, US (MIA)', :arrival_city => 'Benitez International Airport, CL (SCL)', :departure_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (6 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
Package.create(:name => 'round trip flight rate card package savings amount',:departure_city => 'Washington, DC All Airports, DC, US (WAS)', :arrival_city => 'New York City All Airports, NY, US (NYC)', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (8 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
#package_sp05_axpt3801_spec
Package.create(:name => 'round trip flight 6 adult',:departure_city => 'New Orleans International Airport, LA, US (MSY)', :arrival_city => 'New York City All Airports, NY, US (NYC)', :departure_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :return_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
:adults_1 => 6)
############# CAR ##############
Car.delete_all
Car.create(:name => 'same location trip invalid coupon',
           :dropoff_same_as_pickup => true,
           :pickup_city => 'Miami', 
           :pickup_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :dropoff_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :car_rental_company => 'Avis',
           :discount_code => 'DUMMYXXXXXXX'
           )

Car.create(:name => 'same location trip NA coupon',
           :dropoff_same_as_pickup => true,
           :pickup_city => 'Santander Airport , ES',
           :pickup_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :dropoff_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :car_rental_company => 'Avis',
           :discount_code => 'X147801'
           )
           
Car.create(:name => 'US car rental with AC option',
           :dropoff_same_as_pickup => true,
           :pickup_city => 'Miami International Airport, FL, US', 
           :pickup_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :dropoff_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :ac_option => 'Yes'
           )

Car.create(:name => 'basic car same invalid location',
           :dropoff_same_as_pickup => true,
           :pickup_city => 'Invalid Location', 
           :pickup_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :dropoff_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'
           )

Car.create(:name => 'same location basic w/o discount',
           :dropoff_same_as_pickup => true,
           :pickup_city => 'Miami International Airport, FL, US', 
           :pickup_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :dropoff_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'
           )
           
Car.create(:name => 'NOLA and AVIS discount',
           :dropoff_same_as_pickup => true,
           :pickup_city => 'New Orleans International Airport, LA, US', 
           :pickup_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :dropoff_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :car_rental_company => 'Avis',
           :discount_code => 'X147801'
           )

Car.create(:name => 'NOLA and AVIS w/o discount',
           :dropoff_same_as_pickup => true,
           :pickup_city => 'New Orleans International Airport, LA, US', 
           :pickup_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :dropoff_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :car_rental_company => 'Avis'
           )

Car.create(:name => 'test date fields',
           :dropoff_same_as_pickup => true,
           :pickup_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :dropoff_date => '(Time.now + (4 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'
           )                      
           
Car.create(:name => 'NOLA pick up date only',
           :dropoff_same_as_pickup => true,
           :pickup_city => 'New Orleans International Airport, LA, US', 
           :pickup_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'
           )                      

Car.create(:name => 'NOLA drop off date only',
           :dropoff_same_as_pickup => true,
           :pickup_city => 'New Orleans International Airport, LA, US', 
           :dropoff_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'
           )          
           
Car.create(:name => 'NOLA dropoff date before pickup',
           :dropoff_same_as_pickup => true,
           :pickup_city => 'New Orleans International Airport, LA, US', 
           :pickup_date => '(Time.now + (5 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :dropoff_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'
           )                     

Car.create(:name => 'ambigous city',
           :dropoff_same_as_pickup => true,
           :pickup_city => 'Springs', 
           :pickup_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :dropoff_date => '(Time.now + (5 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'
           )
           
Car.create(:name => 'address to city or airport',
           :different_dropoff_location => true,          
           :pickup_in_address  => true,                     
           :dropoff_country => 'United States',            
           :pickup_address => '1000 Coney Island Ave',
           :pickup_city_address  => 'Brooklyn',
           :pickup_state => 'New York',            
           :pickup_zip => '11230',       
           :dropoff_city => 'Miami International Airport, FL, US', 
           :pickup_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :dropoff_date => '(Time.now + (5 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'
           )           
           
Car.create(:name => 'city or airport to address',
           :different_dropoff_location => true,
           :dropoff_in_address  => true,              
           :dropoff_country => 'United States',                   
           :pickup_city => 'Miami International Airport, FL, US', 
           :dropoff_address => '1000 Coney Island Ave',
           :dropoff_city_address  => 'Brooklyn',
           :dropoff_state => 'New York',            
           :dropoff_zip => '11230',
           :pickup_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',       
           :dropoff_date => '(Time.now + (5 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'
           )               
                                            
#############   HOTEL  ################# 
Hotel.delete_all
Hotel.create(:name => 'basic hotel search', :destination =>'Barcelona Airport, ES', :check_in_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :check_out_date => '(Time.now + (3 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
Hotel.create(:name => 'ny hotel search', :destination =>'John F. Kennedy International Airport, NY, US', :check_in_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :check_out_date => '(Time.now + (3 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
Hotel.create(:name => 'sort results hotel search', :destination =>'Arpt. Jorge Newbery, AR', :check_in_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :check_out_date => '(Time.now + (3 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
Hotel.create(:name => 'hotel search summary', :destination =>'McCarran International Airport, NV, US (LAS)', :check_in_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")', :check_out_date => '(Time.now + (3 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')


Car.create(:name => '2 airports',
           :dropoff_same_as_pickup => false,
           :pickup_city => 'New Orleans International Airport, LA, US', 
           :dropoff_city => 'Miami International Airport, FL, US',
           :pickup_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :dropoff_date => '(Time.now + (5 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'
           )
                      
Car.create(:name => '1 airport pickup',
           :dropoff_same_as_pickup => false,
           :pickup_city => 'New Orleans International Airport, LA, US', 
           :dropoff_city => 'Miami Beach, FL, US',
           :pickup_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :dropoff_date => '(Time.now + (5 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'
           )           

Car.create(:name => '1 airport dropoff',
           :dropoff_same_as_pickup => false,
           :dropoff_city => 'New Orleans International Airport, LA, US', 
           :pickup_city => 'Miami Beach, FL, US',
           :pickup_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :dropoff_date => '(Time.now + (5 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'
           )
           
Car.create(:name => '2 cities',
           :dropoff_same_as_pickup => false,
           :pickup_city => 'North Hollywood, CA, US', 
           :dropoff_city => 'El Paso, IL, US',
           :pickup_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :dropoff_date => '(Time.now + (5 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'
           )           

Car.create(:name => 'city and address',
           :dropoff_same_as_pickup => false,
           :dropoff_in_address => true,
           :pickup_city => 'North Hollywood, CA, US', 
           :dropoff_country => 'United States',
           :dropoff_address => '1000 Coney Island Ave',
           :dropoff_city_address => 'Brooklyn',
           :dropoff_zip => '11230',
           :dropoff_state => 'New York',
           :pickup_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :dropoff_date => '(Time.now + (5 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'
           )

Car.create(:name => '1 airport, 1 invalid location',
           :dropoff_same_as_pickup => false,
           :pickup_city => 'New Orleans International Airport, LA, US', 
           :dropoff_city => 'Invalid Location',
           :pickup_date => '(Time.now + (2 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")',
           :dropoff_date => '(Time.now + (5 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")'
           )
           
############# BAGGAGE FEE ##############
BaggageFee.delete_all
#flight_wk50_axpt1858_spec
BaggageFee.create(:name => 'delta darwin', :first_airline  => 'Delta Air Lines', :second_airline  => 'Darwin Airline', :third_airline => 'Zoom Airlines')
           
############# FEATURE ############## 
Feature.delete_all
#reg_sp6_car_script1_axpt323_spec
amex_login_texts = Feature.create(:name => 'amex login texts')
#reg_sp6_car_script1_axpt3865_spec
car_sections_numbers_texts = Feature.create(:name => 'car sections numbers texts')
#reg_sp6_car_script1_axpt3486_spec
triplookups_error_messages = Feature.create(:name => 'triplookups error messages')
#reg_sp5_car_script1_axpt1157_axpt1213_spec/reg_sp6_car_script1_axpt3865_spec
car_matrix_vendor_image = Feature.create(:name => 'car matrix vendor image')
#reg_sp5_car_script1_axpt1157_axpt1213_spec
car_book_car_text = Feature.create(:name => 'car book car text')
#car_sp05_axpt3769_spec
car_data_overlays_feature = Feature.create(:name => 'car data overlays feature')
#car_sp05_axpt3872_spec
car_driver_info_texts_feature =  Feature.create(:name => 'car driver info texts')
car_driver_info_error_texts_feature =  Feature.create(:name => 'car driver info error texts')
#car_sp05_axpt3767_spec
car_results_titles_banners_feature =  Feature.create(:name => 'car results titles banners')
#car_sp05_axpt3429_spec, car_sp05_axpt3769_spec
car_data_texts_feature = Feature.create(:name => 'car data texts')
#car_sp05_axpt3429_spec
car_texts_cost_feature = Feature.create(:name => 'car texts cost')
#car_sp05_axpt1204_spec
car_taxes_and_fees_texts_feature =  Feature.create(:name => 'car taxes and fees texts')
#car_sp05_axpt1206_spec
car_breadcrumbs_and_help_texts_feature =  Feature.create(:name => 'car breadcrumbs and help texts')
#car_wk02_axpt3197_spec
car_charges_restrictions_title_feature = Feature.create(:name => 'car charges restrictions title')
car_rental_rule_link_feature = Feature.create(:name => 'car rental rule link')
car_gas_charges_link_feature = Feature.create(:name => 'car gas charges link')
car_additional_costs_link_feature = Feature.create(:name => 'car additional costs link')
car_rental_rule_overlay_feature = Feature.create(:name => 'car rental rule overlay')
car_gas_charges_overlay_feature = Feature.create(:name => 'car gas charges overlay')
car_additional_costs_overlay_feature = Feature.create(:name => 'car additional costs overlay')
#car_wk52_axpt3304_spec
car_itinerary_feature = Feature.create(:name => 'car itinerary feature')
car_selected_messages_feature = Feature.create(:name => 'car selected messages')
#flight_wk50_axpt1858_spec
baggage_fees_feature = Feature.create(:name => 'baggage fees feature')
#flight_wk50_axpt2095_spec
fare_class_link_feature = Feature.create(:name => 'fare class link feature')
#flight_wk50_axpt2096_spec
edit_itinerary_on_summary_bar_feature = Feature.create(:name => 'edit itinerary on summary bar feature')
#car_wk50_axpt2890_spec
invalid_coupon_car_feature = Feature.create(:name => 'invalid coupon car')
na_coupon_car_feature = Feature.create(:name => 'N.A coupon car')
#flight_wk50_axpt2097_spec
number_of_travelers_feature = Feature.create(:name => 'number of travelers')
#car_wk50_axpt1859_spec
ac_transmission_feature = Feature.create(:name => 'air conditioning and transmission')
ac_combobox_options_feature = Feature.create(:name => 'ac combobox options') 
transmission_combobox_options_feature = Feature.create(:name => 'transmission combobox options')
ac_transmission_note = Feature.create(:name => 'ac transmission note')
car_results_generic_error_feature = Feature.create(:name => 'car generic error')
ac_error_text_feature = Feature.create(:name => 'ac not found error')
interstitial_feature = Feature.create(:name => 'interstitial')
#car_wk50_axpt1860_spec
discount_code_feature = Feature.create(:name => 'discount text')
#flight_wk50_axpt2098_spec
edit_ow_rt_itinerary_dates = Feature.create(:name => 'edit ow rt itinerary dates')
#car_wk50_axpt1864_spec
card_rate_car_feature = Feature.create(:name => 'car card rate')
# flight_wk50_axpt2610_spec
list_of_airports_worldwide_feature = Feature.create(:name => 'list of airports worldwide')
#car_wk50_axpt1871_spec
car_results_error_messages_feature = Feature.create(:name => 'car result errors')
car_results_changes_feature = Feature.create(:name => 'car result change')
#car_wk50_axpt3434_spec
car_change_feature = Feature.create(:name => 'change car')
#car_wk50_axpt3431_spec
car_taxes_display_feature = Feature.create(:name => 'car taxes')
# flight_wk50_axpt2427_spec
on_air_rate_card_alert_label_feature = Feature.create(:name => 'on air rate card alert')
# flight_wk50_axpt2713_spec
log_in_on_the_rate_card_login_label_feature = Feature.create(:name => 'log in on the rate card')
# flight_wk50_axpt2323_spec
show_only_refundable_fares_feature = Feature.create(:name => 'show only refundable fares')
# flight_wk50_axpt2391_spec
slice_flight_type_titles_feature = Feature.create(:name => 'slice flight type titles')
# flight_wk50_axpt2398_spec
price_dollar_matrix_feature = Feature.create(:name => 'price dollar matrix')
#car_wk50_axpt2913_spec
#car_wk50_axpt2232_spec
search_cars_errors = Feature.create(:name => 'search car errors')
search_cars_elements = Feature.create(:name => 'search cars elements')
#car_wk50_axpt3071_spec
search_cars_results = Feature.create(:name => 'search cars results')
#car_wk50_axpt3178_spec
search_cars_interstitial = Feature.create(:name => 'search cars interstitial')

# hotel_wk50_axpt2979_spec
truncate_hotel_name_feature = Feature.create(:name => 'truncate hotel name feature')
#package_wk50_axpt2604_spec
dp_search_form_advanced_search_options_feature = Feature.create(:name => 'dp search form - advanced search options')
#package_wk50_axpt2605_spec
pkg_search_errors_feature = Feature.create(:name => 'package search errors')
pkg_search_travel_time_feature = Feature.create(:name => 'package search travel times')
#hotel_wk50_axpt2561_spec
sort_function_on_hotel_search_results_feature = Feature.create(:name => 'sort function on hotel search results')
#hotel_wk50_axpt3074_spec
display_strikethrough_rate_feature = Feature.create(:name => 'display strikethrough rate feature')
#hotel_wk52_axpt3252_spec
information_expanded_hotel_property_card_feature = Feature.create(:name => 'information expanded hotel property card')
#package_wk52_axpt3303_spec
sort_function_on_package_search_results_feature = Feature.create(:name => 'sort function on package search results')
# hotel_wk02_axp3584_spec
details_room_property_card_feature = Feature.create(:name => 'details room property card')
#package_wk02_axpt3299_spec
dp_search_summary_bar_feature = Feature.create(:name => 'dp search summary bar')
#package_wk52_axpt3305_spec
dp_hotel_property_card_feature = Feature.create(:name => 'dp hotel property card')
#package_wk02_axpt3300_spec
package_number_of_travelers_feature = Feature.create(:name => 'package number of travelers feature')
#package_sprint5_axpt1970_spec
edit_itinerary_on_dp_search_feature = Feature.create(:name => 'edit itinerary on dp search feature')
#hotel_wk50_axpt3074_spec
display_strikethrough_rate_feature = Feature.create(:name => 'display strikethrough rate feature')
#package_sp05_axpt3303_spec
dp_result_flight_matrix_feature = Feature.create(:name => 'dp result flight matrix feature')
# reg_sp5_hotel_script1_axpt812_axpt820_axpt329_spec.rb
search_hotel_in_a_variety_of_ways_feature = Feature.create(:name => 'search hotel in a variety of ways')

############# VERIFICATION ##############
Verification.delete_all
#reg_sp6_car_script1_axpt323_spec
amex_login_texts.verifications.create(:name => 'login welcome title', :text => 'WELCOME TO AMERICAN EXPRESS TRAVEL')
amex_login_texts.verifications.create(:name => 'login form title', :text => 'LOG IN TO AMERICAN EXPRESS TRAVEL')
#reg_sp6_car_script1_axpt3865_spec
car_sections_numbers_texts.verifications.create(:name => 'car payment section title', :text => 'Payment')
car_sections_numbers_texts.verifications.create(:name => 'car book you car section title', :text => 'Book Your Car')
car_sections_numbers_texts.verifications.create(:name => 'car payment secion number', :text => '2.')
car_sections_numbers_texts.verifications.create(:name => 'car book you car section number', :text => '3.')
#reg_sp6_car_script1_axpt3486_spec
triplookups_error_messages.verifications.create(:name => 'triplookups invalid email trip id message', :text => 'Invalid E-mail/Trip ID')
#reg_sp5_car_script1_axpt1157_axpt1213_spec/reg_sp6_car_script1_axpt3865_spec
car_matrix_vendor_image.verifications.create(:name => 'car matrix advantage rent a car vendor image', :text => 'AD-1.gif')
#reg_sp5_car_script1_axpt1157_axpt1213_spec
car_book_car_text.verifications.create(:name => 'car book car terms and conditions error message', :text => 'You must agree to the terms and conditions.')
#car_sp05_axpt3769_spec
car_data_overlays_feature.verifications.create(:name => 'car data suttle information overlay title text', :text => 'Shuttle Information')
car_data_overlays_feature.verifications.create(:name => 'car data hours of operation overlay title text', :text => 'Hours of Operation')
car_data_texts_feature.verifications.create(:name => 'car data hours of operation text', :text => 'Open 24 Hours')
#car_sp05_axpt3872_spec
car_driver_info_texts_feature.verifications.create(:name => 'driver info section number', :text => '1')
car_driver_info_texts_feature.verifications.create(:name => 'driver read age policy link text', :text => 'Read age policy')
car_driver_info_texts_feature.verifications.create(:name => 'overlay age policy text', :text => 'Age Policy')
car_driver_info_texts_feature.verifications.create(:name => 'driver info require field', :text => '*')
car_driver_info_texts_feature.verifications.create(:name => 'driver info optional field', :text => 'optional')
car_driver_info_texts_feature.verifications.create(:name => 'driver info check loyalty number', :text => 'Please check your number carefully. We are unable to validate it.')
car_driver_info_texts_feature.verifications.create(:name => 'driver info special requests not guarenteed text', :text => 'These are only requests and are not guaranteed.')
car_driver_info_texts_feature.verifications.create(:name => 'driver info special requests a max of 3 special equipment text', :text => 'You can make up to three special equipment requests.')
car_driver_info_texts_feature.verifications.create(:name => 'driver info drivers flight information text', :text => "Driver's Flight Information (optional)")
car_driver_info_texts_feature.verifications.create(:name => 'driver info expanded container', :text => 'expanded')
car_driver_info_texts_feature.verifications.create(:name => 'driver info collapsed container', :text => 'collapsed')
car_driver_info_texts_feature.verifications.create(:name => 'driver info driver special requests checkboxes checked', :text => 'ui-checkbox-checked')
car_driver_info_texts_feature.verifications.create(:name => 'driver special requests car seat infant checkboxes text', :text => 'Car Seat - Infant')
car_driver_info_texts_feature.verifications.create(:name => 'driver special requests car seat toddler checkboxes text', :text => 'Car Seat - Toddler')
car_driver_info_texts_feature.verifications.create(:name => 'driver special requests navigation system checkboxes text', :text => 'Navigation System')
car_driver_info_texts_feature.verifications.create(:name => 'driver special requests luggage rack checkboxes text', :text => 'Luggage Rack')
car_driver_info_texts_feature.verifications.create(:name => 'driver special requests bicycle rack checkboxes text', :text => 'Bicycle Rack')
car_driver_info_texts_feature.verifications.create(:name => 'driver special requests ski rack checkboxes text', :text => 'Ski Rack')
car_driver_info_texts_feature.verifications.create(:name => 'driver special requests snow chains checkboxes text', :text => 'Snow Chains')
car_driver_info_texts_feature.verifications.create(:name => 'driver special requests trailer hitch checkboxes text', :text => 'Trailer Hitch')
car_driver_info_texts_feature.verifications.create(:name => 'driver special requests left hand control checkboxes text', :text => 'Left Hand Control')
car_driver_info_texts_feature.verifications.create(:name => 'driver special requests right hand control checkboxes text', :text => 'Right Hand Control')
car_driver_info_texts_feature.verifications.create(:name => 'driver first element airline combobox text', :text => 'Select Airline')
car_driver_info_error_texts_feature.verifications.create(:name => 'driver info first name field required', :text => 'First name is required')
car_driver_info_error_texts_feature.verifications.create(:name => 'driver info last name field required', :text => 'Last name is required')
car_driver_info_error_texts_feature.verifications.create(:name => 'driver info email field required', :text => 'Email is required')
car_driver_info_error_texts_feature.verifications.create(:name => 'driver info email field invalid', :text => 'Email is invalid')
car_driver_info_error_texts_feature.verifications.create(:name => 'driver info phone number field required', :text => 'Phone number is required')
car_driver_info_error_texts_feature.verifications.create(:name => 'driver info phone number field invalid', :text => 'Phone number is invalid')
#car_sp05_axpt3767_spec
car_results_titles_banners_feature.verifications.create(:name => 'car book now pay later title banner', :text => 'BOOK NOW, PAY LATER')
#car_sp05_axpt3429_spec
car_data_texts_feature.verifications.create(:name => 'car book now pay later text banner', :text => 'Book Now, Pay Later')
car_data_texts_feature.verifications.create(:name => 'car checkout automatic transmission text', :text => 'Automatic Transmission')
car_data_texts_feature.verifications.create(:name => 'car checkout air conditioning text', :text => 'Air Conditioning')
car_data_texts_feature.verifications.create(:name => 'car shuttle info link text', :text => 'Shuttle Info')
car_data_texts_feature.verifications.create(:name => 'car hours of operation link text', :text => 'Hours of operation')
car_data_texts_feature.verifications.create(:name => 'car exclusive travel benefits text', :text => 'Exclusive Travel Benefits')
car_texts_cost_feature.verifications.create(:name => 'car rate text', :text => 'Rate')
car_texts_cost_feature.verifications.create(:name => 'car extra text', :text => 'Extra')
#car_sp05_axpt1204_spec
car_taxes_and_fees_texts_feature.verifications.create(:name => 'taxes and fees title', :text => 'Taxes & Fees')
#car_sp05_axpt1206_spec
car_breadcrumbs_and_help_texts_feature.verifications.create(:name => 'car checkout crumb text', :text => 'Checkout')
car_breadcrumbs_and_help_texts_feature.verifications.create(:name => 'car confirmation crumb text', :text => 'Confirmation')
car_breadcrumbs_and_help_texts_feature.verifications.create(:name => 'car need help text', :text => 'Need Help?')
car_breadcrumbs_and_help_texts_feature.verifications.create(:name => 'car need help with this page text', :text => 'Help with this page')
#car_wk02_axpt3197_spec
car_charges_restrictions_title_feature.verifications.create(:name => 'car charges retrictions title text', :text => 'Avoid unexpected charges and restrictions:')
car_rental_rule_link_feature.verifications.create(:name => 'car rental rule link title', :text => 'Car Rental Rules')
car_gas_charges_link_feature.verifications.create(:name => 'car gas charges link title', :text => 'Gas Charges')
car_additional_costs_link_feature.verifications.create(:name => 'car additional costs link title', :text => 'Additonal Costs')
car_rental_rule_overlay_feature.verifications.create(:name => 'car rental rule overlay text title', :text => 'Car Rental Rules')
car_gas_charges_overlay_feature.verifications.create(:name => 'car gas charges text title', :text => 'Gas Charges')
car_additional_costs_overlay_feature.verifications.create(:name => 'car additional costs text title', :text => 'Mileage And Rates')
#car_wk52_axpt3304_spec
car_selected_messages_feature.verifications.create(:name => 'car selected title text', :text => 'Review Your Car Booking')
car_itinerary_feature.verifications.create(:name => 'selected car not available error message text', :text => 'The selected car was not available. Please select a different option.')
#package_wk52_axpt3305_spec
dp_hotel_property_card_feature.verifications.create(:name => 'more details link text', :text => 'More Details')
#package_wk50_axpt2604_spec
dp_search_form_advanced_search_options_feature.verifications.create(:name => 'how many rooms section text', :text => 'How many rooms and travelers?')
dp_search_form_advanced_search_options_feature.verifications.create(:name => 'on package results page verification text', :text => 'Your Flight')
dp_search_form_advanced_search_options_feature.verifications.create(:name => 'at least one adult or one senior per room error message text', :text => 'There must be at least one adult or senior selected per room')
dp_search_form_advanced_search_options_feature.verifications.create(:name => 'at least one adult or one senior per infant in lap error message text', :text => 'There must be at least one adult or senior per Infant in lap')
dp_search_form_advanced_search_options_feature.verifications.create(:name => 'maximum number of guests per room error message text', :text => 'The maximum number of guests per room is 6. Please update your selections appropriately')
dp_search_form_advanced_search_options_feature.verifications.create(:name => 'maximum number of travelers error message text', :text => 'The maximum number of travelers is 9. Please update your selections appropriately')
dp_search_form_advanced_search_options_feature.verifications.create(:name => 'help popup verification innerhtml', :text => "<div class=\"ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix\"><span id=\"ui-dialog-title-1\" class=\"ui-dialog-title\">Guests</span><a onclick=\'s_objectID=\"amex-qa.iseatz.com/package_searches/new#_879\";return this.s_oc?this.s_oc(e):true\' role=\"button\" class=\"ui-dialog-titlebar-close ui-corner-all\" href=\"#\"><span class=\"ui-icon ui-icon-closethick\">close</span></a></div><div scrollleft=\"0\" scrolltop=\"0\" style=\"width: auto; min-height: 0px; height: 91.8px;\" class=\"dialog-travelers-help dialog-modal ui-dialog-content ui-widget-content\">
<p class=\"type\">
Adults:
<span>ages 18 and over</span>
</p>
<p class=\"type\">
Children:
<span>
ages 0 - 17
</span>
</p>
<p>There must be at least one adult per room, with a maximum of six guests per room.</p>
</div><div class=\"ui-dialog-buttonpane ui-widget-content ui-helper-clearfix\"><div class=\"ui-dialog-buttonset\"><button aria-disabled=\"false\" role=\"button\" class=\"ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only ui-state-focus\" style=\"width: 100px;\" type=\"button\"><span class=\"ui-button-text\">close</span></button></div></div>")

#package_wk50_axpt2605_spec
pkg_search_errors_feature.verifications.create(:name => 'select departure date', :text => 'Please select a departure date')
pkg_search_errors_feature.verifications.create(:name => 'select return date', :text => 'Please select a return date')
pkg_search_errors_feature.verifications.create(:name => 'return before departure', :text => 'The return date cannot be before your departure date')
pkg_search_errors_feature.verifications.create(:name => 'same day outbound departure date', :text => 'The return date cannot be the same as your departure date')
pkg_search_errors_feature.verifications.create(:name => 'no results', :text => 'Your search matches no results. Please modify your search criteria and try again')

pkg_search_travel_time_feature.verifications.create(:name => '5 hours', :text => '5am')
pkg_search_travel_time_feature.verifications.create(:name => 'Early time range', :text => 'Early: 12am - 6am')

#package_wk50_axpt2607_spec
dp_search_form_advanced_search_options_feature.verifications.create(:name => 'no departure city error message text', :text => 'Please enter a departure location')
dp_search_form_advanced_search_options_feature.verifications.create(:name => 'no arrival city error message text', :text => 'Please enter an arrival location')
dp_search_form_advanced_search_options_feature.verifications.create(:name => 'same departure and arrival city error message text', :text => 'Your departure location cannot be the same as your arrival location')
dp_search_form_advanced_search_options_feature.verifications.create(:name => 'where are you going subtitle text', :text => 'Where are you going?')

#flight_wk50_axpt1858_spec
baggage_fees_feature.verifications.create(:name => 'baggage fees detail text', :text => 'Delta Airlines airline fees')
baggage_fees_feature.verifications.create(:name => 'baggage fees no data', :text => 'We are in the process of identifying the fees (if any) the airline charges for checked baggage.')
baggage_fees_feature.verifications.create(:name => 'baggage fees link text', :text => 'baggage charges')
#flight_wk50_axpt2095_spec
fare_class_link_feature.verifications.create(:name => 'fare class link text 1', :text => 'Business Class')
fare_class_link_feature.verifications.create(:name => 'fare class link text 2', :text => 'First Class')
fare_class_link_feature.verifications.create(:name => 'fare class link text 3', :text => 'Economy')
#flight_wk50_axpt2096_spec
edit_itinerary_on_summary_bar_feature.verifications.create(:name => 'departure city text', :text => 'Miami International Airport, FL, US (MIA)')
edit_itinerary_on_summary_bar_feature.verifications.create(:name => 'arrival city text', :text => 'Chicago Midway Airport, IL, US')
edit_itinerary_on_summary_bar_feature.verifications.create(:name => 'departure city ambiguous text', :text => 'miami')
edit_itinerary_on_summary_bar_feature.verifications.create(:name => 'arrival city ambiguous text', :text => 'chicago')
edit_itinerary_on_summary_bar_feature.verifications.create(:name => 'disambiguation page title', :text => 'Your Search Matches Multiple Destinations')

#package_wk02_axpt3300_spec
package_number_of_travelers_feature.verifications.create(:name => 'number of travelers link text for 6', :text => '6')
package_number_of_travelers_feature.verifications.create(:name => 'adults combobox value for 6', :text => '2')
package_number_of_travelers_feature.verifications.create(:name => 'seniors combobox value for 6', :text => '2')
package_number_of_travelers_feature.verifications.create(:name => 'children combobox value for 6', :text => '4')
package_number_of_travelers_feature.verifications.create(:name => 'children age combobox 1 value for 6', :text => '<2')
package_number_of_travelers_feature.verifications.create(:name => 'children age combobox 2 value for 6', :text => '<2')
package_number_of_travelers_feature.verifications.create(:name => '1 adult or senior per room error message text', :text => 'There must be at least one adult or senior selected per room')
package_number_of_travelers_feature.verifications.create(:name => 'maximum guests per room error message text', :text => 'The maximum number of guests per room is 6. Please update your selections appropriately.')
package_number_of_travelers_feature.verifications.create(:name => 'adult or senior per infant in lap error message text', :text => 'There must be at least one adult or senior per Infant in lap')

#package_sprint5_axpt1970_spec
edit_itinerary_on_dp_search_feature.verifications.create(:name => 'departure airport code text', :text => 'MIA')
edit_itinerary_on_dp_search_feature.verifications.create(:name => 'arrival airport code text', :text => 'MDW')
edit_itinerary_on_dp_search_feature.verifications.create(:name => 'departure city name text', :text => 'Boston Logan International Airport')
edit_itinerary_on_dp_search_feature.verifications.create(:name => 'arrival city name text', :text => 'Dayton International Airport')
edit_itinerary_on_dp_search_feature.verifications.create(:name => 'departure airport name text', :text => 'Miami International Airport')
edit_itinerary_on_dp_search_feature.verifications.create(:name => 'arrival airport name text', :text => 'Chicago Midway Airport')

#package_sprint5_axpt1767_spec
edit_itinerary_on_dp_search_feature.verifications.create(:name => 'view roundtrip flight details text', :text => '+ View Roundtrip Flight Details')
edit_itinerary_on_dp_search_feature.verifications.create(:name => 'hide roundtrip flight details text', :text => '- Hide Roundtrip Flight Details')
edit_itinerary_on_dp_search_feature.verifications.create(:name => 'cabin class alert text 1', :text => 'Economy')
edit_itinerary_on_dp_search_feature.verifications.create(:name => 'cabin class alert text 2', :text => 'Business')
edit_itinerary_on_dp_search_feature.verifications.create(:name => 'cabin class alert text 3', :text => 'First')

#package_sprint5_axpt3807_spec
edit_itinerary_on_dp_search_feature.verifications.create(:name => 'date check in src text', :text => 'date-check-in-627682f65fffb4d3eba83641af146f09.png')
edit_itinerary_on_dp_search_feature.verifications.create(:name => 'date check out src text', :text => 'date-check-out-a28974f13c34c9aff32504cf4334a7d3.png')

#package_sprint5_axpt3806_spec
edit_itinerary_on_dp_search_feature.verifications.create(:name => 'cost of flight hotel text', :text => 'Cost of Flight + Hotel:')
edit_itinerary_on_dp_search_feature.verifications.create(:name => 'nights room text', :text => '6 nights, 1 room')
edit_itinerary_on_dp_search_feature.verifications.create(:name => 'USD currency', :text => '$')
edit_itinerary_on_dp_search_feature.verifications.create(:name => 'average per person text', :text => 'Average Per Person')

#package_sprint5_axpt3801_spec
edit_itinerary_on_dp_search_feature.verifications.create(:name => 'only tickets left text', :text => 'ONLY 7 TICKETS LEFT!')

#flight_wk50_axpt2097_spec
number_of_travelers_feature.verifications.create(:name => 'number of travelers link text for 8', :text => '8 Travelers')
number_of_travelers_feature.verifications.create(:name => 'adults combobox value for 8', :text => '2')
number_of_travelers_feature.verifications.create(:name => 'seniors combobox value for 8', :text => '2')
number_of_travelers_feature.verifications.create(:name => 'children combobox value for 8', :text => '4')
number_of_travelers_feature.verifications.create(:name => 'children age combobox 1 value for 8', :text => '<2')
number_of_travelers_feature.verifications.create(:name => 'children age combobox 2 value for 8', :text => '2')
number_of_travelers_feature.verifications.create(:name => 'children age combobox 3 value for 8', :text => '<2')
number_of_travelers_feature.verifications.create(:name => 'children age combobox 4 value for 8', :text => '3')
#flight_wk50_axpt2098_spec
edit_ow_rt_itinerary_dates.verifications.create(:name => 'empty departure date error message', :text => 'Departure date is not a valid datetime')
edit_ow_rt_itinerary_dates.verifications.create(:name => 'empty return date error message', :text => 'Arrival date is not a valid datetime')
edit_ow_rt_itinerary_dates.verifications.create(:name => 'empty both dates error messages', :text => '["Departure date is not a valid datetime","Arrival date is not a valid datetime"]')
edit_ow_rt_itinerary_dates.verifications.create(:name => 'departure date too far error messages', :text => '["Departure date is too far in the future","Arrival date is not a valid datetime"]')
edit_ow_rt_itinerary_dates.verifications.create(:name => 'return date too far error messages', :text => '["Departure date is not a valid datetime","Arrival date is too far in the future"]')
edit_ow_rt_itinerary_dates.verifications.create(:name => 'both dates too far error messages', :text => '["Departure date is too far in the future","Arrival date is too far in the future"]')

number_of_travelers_feature.verifications.create(:name => 'max number of passengers error message', :text => 'The maximum number of travelers is 9. Please update your selections appropriately.')
number_of_travelers_feature.verifications.create(:name => 'lap infant accompanying error messages', :text => '["There must be at least one adult or senior per lap infant.","There must be at least one adult or senior selected per trip."]')
#flight_wk50_axpt2098_spec
edit_ow_rt_itinerary_dates.verifications.create(:name => 'empty departure date error message', :text => 'Departure date is not a valid datetime')
edit_ow_rt_itinerary_dates.verifications.create(:name => 'empty return date error message', :text => 'Arrival date is not a valid datetime')
edit_ow_rt_itinerary_dates.verifications.create(:name => 'empty both dates error messages', :text => '["Departure date is not a valid datetime","Arrival date is not a valid datetime"]')
edit_ow_rt_itinerary_dates.verifications.create(:name => 'departure date too far error messages', :text => '["Departure date is too far in the future","Arrival date is not a valid datetime"]')
edit_ow_rt_itinerary_dates.verifications.create(:name => 'return date too far error messages', :text => '["Departure date is not a valid datetime","Arrival date is too far in the future"]')
edit_ow_rt_itinerary_dates.verifications.create(:name => 'both dates too far error messages', :text => '["Departure date is too far in the future","Arrival date is too far in the future"]')

#car_wk50_axpt2890_spec
invalid_coupon_car_feature.verifications.create(:name => 'invalid coupon car text', :text => 'The discount code you entered was invalid and not applied to this search')

na_coupon_car_feature.verifications.create(:name => 'not applicable coupon car text', :text => 'The discount code you entered could not be applied, we are showing alternate available rentals for your selected time/date')
#car_wk50_axpt1859_spec
ac_combobox_options_feature.verifications.create(:name => 'ac text 1', :text => 'No Preference')
ac_combobox_options_feature.verifications.create(:name => 'ac text 2', :text => 'No')
ac_combobox_options_feature.verifications.create(:name => 'ac text 3', :text => 'Yes')
transmission_combobox_options_feature.verifications.create(:name => 'transmission text N', :text => 'N')
transmission_combobox_options_feature.verifications.create(:name => 'transmission text A', :text => 'A')
transmission_combobox_options_feature.verifications.create(:name => 'transmission text M', :text => 'M')
transmission_combobox_options_feature.verifications.create(:name => 'transmission text 1', :text => 'No Preference')
transmission_combobox_options_feature.verifications.create(:name => 'transmission text 2', :text => 'Automatic')
transmission_combobox_options_feature.verifications.create(:name => 'transmission text 3', :text => 'Manual')
ac_transmission_note.verifications.create(:name => 'ac transmission text', :text => 'Note: Air-conditioning and Transmission options apply only to non-US rentals')
car_results_generic_error_feature.verifications.create(:name => 'car results generic error message', :text => 'error-handling')
ac_error_text_feature.verifications.create(:name => 'ac not found message', :text => 'No results found for specified Air Conditioning preference')
interstitial_feature.verifications.create(:name => 'instertitial message', :text => 'We are searching our inventory to find you the best results for your trip.')
#car_wk50_axpt1860_spec
discount_code_feature.verifications.create(:name => 'discount title text', :text => 'Do you have a car discount code?')
discount_code_feature.verifications.create(:name => 'Company 1', :text => 'Avis')
#car_wk50_axpt1864_spec
card_rate_car_feature.verifications.create(:name => 'total cost label', :text => 'Total cost:')
card_rate_car_feature.verifications.create(:name => 'USD currency', :text => '$')
#car_wk50_axpt1871_spec
car_results_error_messages_feature.verifications.create(:name => 'missing dropoff', :text => 'Please select a drop-off date')
car_results_error_messages_feature.verifications.create(:name => 'missing pickup', :text => 'Please select a pick-up date')
car_results_error_messages_feature.verifications.create(:name => 'dropoff before pickup', :text => 'The drop-off date cannot be before the pick-up date')
car_results_error_messages_feature.verifications.create(:name => 'pickup after dropoff', :text => 'The pick-up date cannot be after your drop-off date')
car_results_changes_feature.verifications.create(:name => 'new pickup time', :text => '(Time.now + (5 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
car_results_changes_feature.verifications.create(:name => 'new dropoff time', :text => '(Time.now + (9 * (60 * 60 * 24))).localtime.strftime("%m/%d/%Y")')
#car_wk50_axpt3434_spec
car_change_feature.verifications.create(:name => 'change car url', :text => '/car_searches/')
#car_wk50_axpt3431_spec
car_taxes_display_feature.verifications.create(:name => 'tax and fee text', :text => 'Taxes &amp; Fees')
#car_wk50_axpt3178_spec
search_cars_interstitial.verifications.create(:name => 'interstitial main text', :text => 'Get more when you book with American Express')
#car_wk02_axpt3136_spec
search_cars_results.verifications.create(:name => 'economy car type text', :text => 'Economy Car')
search_cars_results.verifications.create(:name => 'review your car text', :text => 'Review Your Car Booking')
search_cars_results.verifications.create(:name => 'selected car not available error message text', :text => 'The selected car was not available. Please select a different option.')

# flight_wk50_axpt2610_spec
list_of_airports_worldwide_feature.verifications.create(:name => 'us airport selected full name', :text => 'Macon, GA (MCN)')
list_of_airports_worldwide_feature.verifications.create(:name => 'canadian airport selected full name', :text => 'Calgary, AB (YYC)')
list_of_airports_worldwide_feature.verifications.create(:name => 'intl airport selected full name', :text => 'Maastricht, Netherlands (MST)')
# flight_wk50_axpt2427_spec
on_air_rate_card_alert_label_feature.verifications.create(:name => 'red card alert day', :text => '+1 Day')
on_air_rate_card_alert_label_feature.verifications.create(:name => 'red card alert change planes', :text => 'Change Planes')
on_air_rate_card_alert_label_feature.verifications.create(:name => 'red card alert subject to government approval', :text => 'Subject to Government Approval')
# flight_wk50_axpt2713_spec
log_in_on_the_rate_card_login_label_feature.verifications.create(:name => 'login to see the price in', :text => 'Login to see the price in')
log_in_on_the_rate_card_login_label_feature.verifications.create(:name => 'membership rewards points', :text => 'Membership Rewards')
# flight_wk50_axpt2323_spec
show_only_refundable_fares_feature.verifications.create(:name => 'show only refundable fares label text', :text => 'Show me only refundable fares (can be more expensive)') 
show_only_refundable_fares_feature.verifications.create(:name => 'no flight found error message', :text => '["No flights found for search request"]')

# flight_wk50_axpt2391_spec
slice_flight_type_titles_feature.verifications.create(:name => 'slice titles for one way', :text => '["One Way"]')
slice_flight_type_titles_feature.verifications.create(:name => 'slice titles for round trip', :text => '["Departure Flight","Return Flight"]')
slice_flight_type_titles_feature.verifications.create(:name => 'slice titles for multi city', :text => '["First Leg","Second Leg","Third Leg","Fourth Leg"]')

# flight_wk50_axpt2398_spec
price_dollar_matrix_feature.verifications.create(:name => 'price dollar matrix stops rows', :text => '["Non-Stop","1 Stop","2 Stops","3 Stops"]')
# flight_wk50_axpt2425_spec
edit_itinerary_on_summary_bar_feature.verifications.create(:name => 'disambiguation clarify your search error message', :text => 'Please clarify your search by selecting a match below')
edit_itinerary_on_summary_bar_feature.verifications.create(:name => 'quick compare title', :text => 'Quick Compare')
#car_wk50_axpt2913_spec
search_cars_errors.verifications.create(:name => 'same url', :text => 'car_searches')
#car_wk50_axpt2512_spec
search_cars_errors.verifications.create(:name => 'choose location error', :text => 'Please fill in the required field')
search_cars_errors.verifications.create(:name => 'invalid location error', :text => 'Please enter a valid location')
search_cars_errors.verifications.create(:name => 'airport needed error', :text => 'At least one location must be an airport.')
#car_wk50_axpt2232_spec
search_cars_elements.verifications.create(:name => 'search subtitle', :text => 'Where Will You Pick Up The Car?')
search_cars_elements.verifications.create(:name => 'dropoff = pickup label', :text => 'Drop-off location same as pick-up')
search_cars_elements.verifications.create(:name => 'dropoff != pickup label', :text => 'Different drop-off location')
#car_wk52_axpt3071_spec
search_cars_results.verifications.create(:name => 'quick compare text', :text => "Rates shown include Taxes and Fees. Charges for optional services, fuel, insurance waivers, etc. are not included. Charges for additional or underage drivers may be levied if applicable. These additional fees or surcharges may be applied at the time of rental. See Car Rental Policies for additional information and restrictions. Any currency conversion for the above rate is based on today's exchange rate. The actual price may be different")
search_cars_results.verifications.create(:name => 'car rental policy text', :text => 'See Car Rental Policies for additional information and restrictions')
search_cars_results.verifications.create(:name => 'car rental policy link text', :text => 'Car Rental Policies')

# hotel_wk50_axpt2979_spec
truncate_hotel_name_feature.verifications.create(:name => 'more details link text', :text => 'More Details')

# hotel_wk50_axpt2561_spec
sort_function_on_hotel_search_results_feature.verifications.create(:name => 'sort by combobox text best Value', :text => 'Best Value')
sort_function_on_hotel_search_results_feature.verifications.create(:name => 'sort by combobox text price', :text => 'Price Low to High')
sort_function_on_hotel_search_results_feature.verifications.create(:name => 'sort by combobox text star rating', :text => 'Star Rating')
sort_function_on_hotel_search_results_feature.verifications.create(:name => 'sort by combobox text hotel name', :text => 'Hotel Name')
sort_function_on_hotel_search_results_feature.verifications.create(:name => 'sort by combobox text distance', :text => 'Distance')
sort_function_on_hotel_search_results_feature.verifications.create(:name => 'location text', :text => 'Arpt. Jorge Newbery, AR (AEP)')
sort_function_on_hotel_search_results_feature.verifications.create(:name => 'rooms text', :text => '1 Room')
sort_function_on_hotel_search_results_feature.verifications.create(:name => 'guests text', :text => '1 Guest')

#package_wk52_axpt3303_spec
sort_function_on_package_search_results_feature.verifications.create(:name => 'sort by combobox text best Value', :text => 'Best Value')
sort_function_on_package_search_results_feature.verifications.create(:name => 'sort by combobox text price', :text => 'Price in Dollars')
sort_function_on_package_search_results_feature.verifications.create(:name => 'sort by combobox text star rating', :text => 'Star Rating')
sort_function_on_package_search_results_feature.verifications.create(:name => 'sort by combobox text hotel name', :text => 'Hotel Name')
sort_function_on_package_search_results_feature.verifications.create(:name => 'sort by combobox text distance', :text => 'Distance')
sort_function_on_package_search_results_feature.verifications.create(:name => 'explaining label text', :text => '(You can change your flights and hotels at anytime before booking)')

# hotel_wk02_axp3584_spec
details_room_property_card_feature.verifications.create(:name => 'room details text', :text => 'Room details')
details_room_property_card_feature.verifications.create(:name => 'book button text', :text => 'BOOK')
details_room_property_card_feature.verifications.create(:name => 'room error message text', :text => "We found an error."+"\n"+"There was a problem booking the selected room. Please choose another room.")
details_room_property_card_feature.verifications.create(:name => 'number of days error message text', :text => "As most hotels do not accept reservations exceeding 30 days in length, please reduce the number of days to 30 or less and make another reservation for the additional days.")

#hotel_wk50_axpt3074_spec
display_strikethrough_rate_feature.verifications.create(:name => 'old price element css', :text => 'div.old-price')
display_strikethrough_rate_feature.verifications.create(:name => 'big price element css', :text => 'div.big-price div.number')
# hotel_wk52_axpt3252_spec
information_expanded_hotel_property_card_feature.verifications.create(:name => 'description text', :text => "Description")
information_expanded_hotel_property_card_feature.verifications.create(:name => 'description tab text', :text => "DESCRIPTION")

#hotel_wk02_axpt3763_spec
information_expanded_hotel_property_card_feature.verifications.create(:name => 'Lowest Rate guaranteed text', :text => 'LOWEST RATE GUARANTEED 1')
information_expanded_hotel_property_card_feature.verifications.create(:name => 'select button text', :text => 'SELECT')
information_expanded_hotel_property_card_feature.verifications.create(:name => 'checkout title text', :text => 'Checkout')
#hotel_wk02_axpt3365_spec
information_expanded_hotel_property_card_feature.verifications.create(:name => 'back to search link text', :text => '< Back To Search Results')
information_expanded_hotel_property_card_feature.verifications.create(:name => 'default combo value text', :text => 'Best Value')

#hotel_sp05_axpt2959_spec
sort_function_on_hotel_search_results_feature.verifications.create(:name => 'edit hotel destination text', :text => 'Henderson, NV, US')
sort_function_on_hotel_search_results_feature.verifications.create(:name => 'edit hotel destination ambiguous text', :text => 'McCarran')
sort_function_on_hotel_search_results_feature.verifications.create(:name => 'disambiguation page title', :text => 'Your Search Matches Multiple Destinations')

# reg_sp5_hotel_script1_axpt812_axpt820_axpt329_spec.rb
search_hotel_in_a_variety_of_ways_feature.verifications.create(:name => 'returned no results error message text', :text => 'Your search request returned no results. Please modify your search criteria and try again.')
search_hotel_in_a_variety_of_ways_feature.verifications.create(:name => 'wrong state error message text', :text => 'Please select state/province from the drop-down')
search_hotel_in_a_variety_of_ways_feature.verifications.create(:name => 'please specify a city error message text', :text => 'Please specify a city')
search_hotel_in_a_variety_of_ways_feature.verifications.create(:name => 'please select a check-in date error message text', :text => 'Please select a check-in date')
search_hotel_in_a_variety_of_ways_feature.verifications.create(:name => 'please select a check-out date error message text', :text => 'Please select a check-out date')
search_hotel_in_a_variety_of_ways_feature.verifications.create(:name => 'address 1 text', :text => '230 Fort Juckson')
search_hotel_in_a_variety_of_ways_feature.verifications.create(:name => 'city 1 text', :text => 'Buras')
search_hotel_in_a_variety_of_ways_feature.verifications.create(:name => 'zip postal code 1 text', :text => '70037')
search_hotel_in_a_variety_of_ways_feature.verifications.create(:name => 'address 2 text', :text => '186 Market St')
search_hotel_in_a_variety_of_ways_feature.verifications.create(:name => 'city 2 text', :text => 'Newark')
search_hotel_in_a_variety_of_ways_feature.verifications.create(:name => 'zip postal code 2 text', :text => 'NJ 07103')
search_hotel_in_a_variety_of_ways_feature.verifications.create(:name => 'edit hotel destination ambiguous text', :text => 'McCarrEn')
search_hotel_in_a_variety_of_ways_feature.verifications.create(:name => 'disambiguation page title', :text => 'Your Search Matches Multiple Destinations')
search_hotel_in_a_variety_of_ways_feature.verifications.create(:name => 'destination text', :text => 'Las Vegas, NM, US')
search_hotel_in_a_variety_of_ways_feature.verifications.create(:name => 'start a new search link text', :text => 'Start a new search')
search_hotel_in_a_variety_of_ways_feature.verifications.create(:name => 'edit hotel destination text', :text => 'Henderson, NV, US')
search_hotel_in_a_variety_of_ways_feature.verifications.create(:name => 'interstitial main text', :text => "GET MORE WHEN YOU BOOK WITH"+"\n"+"AMERICAN EXPRESS")

# reg_sp5_hotel_script1_axpt982_axpt977_axpt976_axpt975_axpt923_axpt1042_spec.rb
search_hotel_in_a_variety_of_ways_feature.verifications.create(:name => 'hotel map img src', :text => "http://maps.google")

#package_wk02_axpt3299_spec
dp_search_summary_bar_feature.verifications.create(:name => 'room 1 text', :text => '1 Room')
dp_search_summary_bar_feature.verifications.create(:name => 'room 2 text', :text => '2 Rooms')
dp_search_summary_bar_feature.verifications.create(:name => 'room 3 text', :text => '3 Rooms')
dp_search_summary_bar_feature.verifications.create(:name => 'room 4 text', :text => '4 Rooms')
dp_search_summary_bar_feature.verifications.create(:name => 'at least one adult or one senior error message text', :text => 'There must be at least one adult or senior selected per room')
dp_search_summary_bar_feature.verifications.create(:name => 'maximum number of guests per room is 6 error message text', :text => 'The maximum number of guests per room is 6. Please update your selections appropriately.')

#package_wk02_axpt3302_spec
dp_search_summary_bar_feature.verifications.create(:name => 'departure city text', :text => 'John F. Kennedy International Airport, NY, US (JFK)')
dp_search_summary_bar_feature.verifications.create(:name => 'arrival city text', :text => 'Chicago Midway Airport, IL, US')
dp_search_summary_bar_feature.verifications.create(:name => 'interstitial main text', :text => "GET MORE WHEN YOU BOOK WITH"+"\n"+"AMERICAN EXPRESS")
dp_search_summary_bar_feature.verifications.create(:name => 'invalid location error', :text => 'Please enter a valid location')
dp_search_summary_bar_feature.verifications.create(:name => 'enter an arrival location error', :text => 'Please enter an arrival location')
dp_search_summary_bar_feature.verifications.create(:name => 'enter an departure location error', :text => 'Please enter a departure location')
dp_search_summary_bar_feature.verifications.create(:name => 'wrong cities text', :text => 'ghhgfdhhgfhdg')
dp_search_summary_bar_feature.verifications.create(:name => 'departure city ambiguous text', :text => 'miami')
dp_search_summary_bar_feature.verifications.create(:name => 'arrival city ambiguous text', :text => 'chicago')
dp_search_summary_bar_feature.verifications.create(:name => 'disambiguation page title text', :text => 'Your Search Matches Multiple Destinations')

#package_wk02_axpt3301_spec
dp_search_summary_bar_feature.verifications.create(:name => 'select departure date error', :text => 'Please select a departure date')
dp_search_summary_bar_feature.verifications.create(:name => 'select return date error', :text => 'Please select a return date')
dp_search_summary_bar_feature.verifications.create(:name => 'dates should be within 331 days error', :text => 'Travel dates should be within 331 days from current date. Please correct search parameters appropriately')
dp_search_summary_bar_feature.verifications.create(:name => 'the maximum stay is limited to 30 days error', :text => 'As most hotels do not accept reservations exceeding 30 days in length, please reduce the number of days to 30 or less and make another reservation for the additional days.')
dp_search_summary_bar_feature.verifications.create(:name => 'same day outbound departure date', :text => 'The return date cannot be the same as your departure date')

#package_sp05_axpt3802_spec
on_air_rate_card_alert_label_feature.verifications.create(:name => 'dp flight card alert change planes', :text => 'Change Planes')
on_air_rate_card_alert_label_feature.verifications.create(:name => 'dp flight card alert subject to government approval', :text => 'Subject to Government Approval')


#package_sp05_axpt3807_spec
edit_itinerary_on_dp_search_feature.verifications.create(:name => 'hotel rate card show hotel highlights text', :text => 'Show Hotel Highlights')
edit_itinerary_on_dp_search_feature.verifications.create(:name => 'hotel rate card your room details text', :text => 'Your Room Details')

#package_sp05_axpt3303_spec
dp_result_flight_matrix_feature.verifications.create(:name => 'baggage charges link text', :text => 'baggage charges')
dp_result_flight_matrix_feature.verifications.create(:name => 'taxes and fees link text', :text => 'Taxes and Fees.')
dp_result_flight_matrix_feature.verifications.create(:name => 'packages taxes and fees title text', :text => 'PACKAGES TAXES AND FEES')
dp_result_flight_matrix_feature.verifications.create(:name => 'baggage charges title text', :text => 'BAGGAGE FEES')
dp_result_flight_matrix_feature.verifications.create(:name => 'collapse button text', :text => 'Collapse')
dp_result_flight_matrix_feature.verifications.create(:name => 'expand button text', :text => 'Expand')
############# BAGGAGE FEE ##############
BaggageFee.delete_all
#flight_wk50_axpt1858_spec
BaggageFee.create(:name => 'delta darwin', :first_airline  => 'Delta Air Lines', :second_airline  => 'Darwin Airline', :third_airline => 'Zoom Airlines')

############# PAGE PAGES ##############
Page.delete_all
flight_page = Page.create(:name => 'flight search page', :url => 'flight_searches/new', :title => ' If this is the title, OVT layout override works ')
flight_results_page = Page.create(:name => 'flight results page', :url => 'flight_searches/205', :title => ' If this is the title, OVT layout override works ')
flight_disambiguation_page = Page.create(:name => 'flight disambiguation page', :url => 'flight_searches/205', :title => ' If this is the title, OVT layout override works ')
package_disambiguation_page = Page.create(:name => 'package disambiguation page', :url => 'package_searches/', :title => ' If this is the title, OVT layout override works ')
car_page = Page.create(:name => 'car page', :url => 'car_searches/new', :title => ' If this is the title, OVT layout override works ')
car_results_page = Page.create(:name => 'car results page', :url => 'car_searches/', :title => ' If this is the title, OVT layout override works ')
home_page = Page.create(:name => 'home page', :url => '', :title => ' If this is the title, OVT layout override works ')
car_selected_page = Page.create(:name => 'car selected page', :url => 'cars/', :title => ' If this is the title, OVT layout override works ')
package_search_page = Page.create(:name => 'package search page', :url => 'package_searches/new', :title => ' If this is the title, OVT layout override works ')
package_results_page = Page.create(:name => 'package results page', :url => 'package_searches/205', :title => ' If this is the title, OVT layout override works ')
hotel_search_page = Page.create(:name => 'hotel search page', :url => 'hotel_searches/new', :title => ' If this is the title, OVT layout override works ')
hotel_results_page = Page.create(:name => 'hotel results page', :url => 'hotel_searches/381', :title => ' If this is the title, OVT layout override works ')
hotel_description_page = Page.create(:name => 'hotel description page', :url => 'hotel_searches/381', :title => ' If this is the title, OVT layout override works ')
hotel_checkout_page = Page.create(:name => 'hotel checkout page', :url => 'hotel_searches/381', :title => ' If this is the title, OVT layout override works ')
hotel_disambiguation_page = Page.create(:name => 'hotel disambiguation page', :url => 'hotel_searches/', :title => ' If this is the title, OVT layout override works ')
package_hotel_details_page = Page.create(:name => 'package hotel details page', :url => '/package_searches/67/reprice/3?where_from=details#tabs-rooms', :title => ' If this is the title, OVT layout override works ')
amex_login_page = Page.create(:name => 'amex login page', :url => '/', :title => ' If this is the title, OVT layout override works ')
test_login_page = Page.create(:name => 'test login page', :url => '/login?test_login=true', :title => ' If this is the title, OVT layout override works ')

car_confirmation_page = Page.create(:name => 'car confirmation page', :url => '/', :title => ' If this is the title, OVT layout override works ')
car_mytriplookups_page = Page.create(:name => 'car mytriplookups page', :url => 'trip_lookups/test_mytrips', :title => ' If this is the title, OVT layout override works ')
car_triplookups_page = Page.create(:name => 'car triplookups page', :url => '/', :title => ' If this is the title, OVT layout override works ')
############# ELEMENT ##############
Element.delete_all

# reg_sp6_hotel_script1_axpt4544_axpt4339_axpt4720_axpt512_spec
test_login_page.elements.create(:name => 'test user1 login button', :by_css_locator => "div.logins form:nth-of-type(1) input[type='submit']")
test_login_page.elements.create(:name => 'test user2 login button', :by_css_locator => "div.logins form:nth-of-type(2) input[type='submit']")
test_login_page.elements.create(:name => 'test user4 login button', :by_css_locator => "div.logins form:nth-of-type(4) input[type='submit']")
test_login_page.elements.create(:name => 'logout button', :by_css_locator => "div.logins div a")

#package_wk52_axpt3305_spec
package_hotel_details_page.elements.create(:name => 'dp room details card titles', :by_css_locator => 'div.col-card div.bg div.first-result-column div.room-detail h2')

# reg_sp6_hotel_script1_axpt4544_axpt4339_axpt4720_axpt512_spec
package_hotel_details_page.elements.create(:name => 'package hotel details hotel name', :by_css_locator => 'div.summary-up h2')
package_hotel_details_page.elements.create(:name => 'package hotel details check dates', :by_css_locator => 'div.summary-down span.date')
package_hotel_details_page.elements.create(:name => 'package hotel details guests and rooms', :by_css_locator => 'div.summary-down span.rooms')
package_hotel_details_page.elements.create(:name => 'package hotel details stars container', :by_css_locator => 'div.summary-up div.star-container')
package_hotel_details_page.elements.create(:name => 'package hotel details stars help link', :by_css_locator => 'div.star-container a.question')
package_hotel_details_page.elements.create(:name => 'package hotel details start a new search link', :by_css_locator => 'div.new-search a')
package_hotel_details_page.elements.create(:name => 'package hotel details first select this hotel button', :by_css_locator => 'li:nth-of-type(1) div.col-card div.select-container-modify-you-flight a.select-button')
package_hotel_details_page.elements.create(:name => 'package hotel details address', :by_class_locator => 'address')

#package_wk50_axpt2604_spec
package_search_page.elements.create(:name => 'help popup close button', :by_css_locator => 'div.ui-dialog * span.ui-icon')
package_search_page.elements.create(:name => 'departure city textbox', :by_id_locator => '_jq-dep-loc-from')
package_search_page.elements.create(:name => 'arrival city textbox', :by_id_locator => '_jq-dep-loc-to')
package_search_page.elements.create(:name => 'departure date textbox', :by_id_locator => 'package_search_flight_search_slices_attributes_2_departure_date')
package_search_page.elements.create(:name => 'departure time combobox', :by_css_locator => 'form.search-form fieldset.main-fieldset li._jq-dep-time:nth-of-type(2) a.selectBox')
package_search_page.elements.create(:name => 'return date textbox', :by_id_locator => 'package_search_flight_search_slices_attributes_3_departure_date')
package_search_page.elements.create(:name => 'return time combobox', :by_css_locator => 'form.search-form fieldset.main-fieldset li._jq-dep-time:nth-of-type(4) a.selectBox')        
package_search_page.elements.create(:name => 'rooms combobox', :by_css_locator => 'form.search-form li.rooms-quantity a.selectBox') 
package_search_page.elements.create(:name => 'rooms combobox selected option', :by_css_locator => 'form.search-form li.rooms-quantity a.selectBox span.selectBox-label')               
package_search_page.elements.create(:name => 'adults combobox 1', :by_css_locator => 'li.rooms-details fieldset._jq-room-fieldset:nth-of-type(1) li#package_search_traveler_groups_adults_input.select a.selectBox')        
package_search_page.elements.create(:name => 'adults combobox selected option 1', :by_css_locator => 'li.rooms-details fieldset._jq-room-fieldset:nth-of-type(1) li#package_search_traveler_groups_adults_input.select a.selectBox span.selectBox-label')        
package_search_page.elements.create(:name => 'adults combobox 2', :by_css_locator => 'li.rooms-details fieldset._jq-room-fieldset:nth-of-type(2) li#package_search_traveler_groups_adults_input.select a.selectBox')    
package_search_page.elements.create(:name => 'adults combobox 3', :by_css_locator => 'li.rooms-details fieldset._jq-room-fieldset:nth-of-type(3) li#package_search_traveler_groups_adults_input.select a.selectBox')    
package_search_page.elements.create(:name => 'adults combobox 4', :by_css_locator => 'li.rooms-details fieldset._jq-room-fieldset:nth-of-type(4) li#package_search_traveler_groups_adults_input.select a.selectBox')    
package_search_page.elements.create(:name => 'seniors combobox 1', :by_css_locator => 'li.rooms-details fieldset._jq-room-fieldset:nth-of-type(1) li#package_search_traveler_groups_seniors_input.select a.selectBox')
package_search_page.elements.create(:name => 'seniors combobox 2', :by_css_locator => 'li.rooms-details fieldset._jq-room-fieldset:nth-of-type(2) li#package_search_traveler_groups_seniors_input.select a.selectBox')
package_search_page.elements.create(:name => 'seniors combobox 3', :by_css_locator => 'li.rooms-details fieldset._jq-room-fieldset:nth-of-type(3) li#package_search_traveler_groups_seniors_input.select a.selectBox')
package_search_page.elements.create(:name => 'seniors combobox 4', :by_css_locator => 'li.rooms-details fieldset._jq-room-fieldset:nth-of-type(4) li#package_search_traveler_groups_seniors_input.select a.selectBox')
package_search_page.elements.create(:name => 'children combobox 1', :by_css_locator => 'li.rooms-details fieldset._jq-room-fieldset:nth-of-type(1) li#package_search_traveler_groups_child_count_input.select a.selectBox')
package_search_page.elements.create(:name => 'children combobox 2', :by_css_locator => 'li.rooms-details fieldset._jq-room-fieldset:nth-of-type(2) li#package_search_traveler_groups_child_count_input.select a.selectBox')
package_search_page.elements.create(:name => 'children combobox 3', :by_css_locator => 'li.rooms-details fieldset._jq-room-fieldset:nth-of-type(3) li#package_search_traveler_groups_child_count_input.select a.selectBox')
package_search_page.elements.create(:name => 'children combobox 4', :by_css_locator => 'li.rooms-details fieldset._jq-room-fieldset:nth-of-type(4) li#package_search_traveler_groups_child_count_input.select a.selectBox')
package_search_page.elements.create(:name => 'show only non-stop flights checkbox', :by_id_locator => 'package_search_nonstop_only') 
package_search_page.elements.create(:name => 'search button', :by_css_locator => 'input.search-package-button') 
package_search_page.elements.create(:name => 'how many rooms and travelers labels', :by_css_locator => 'form.search-form fieldset.main-fieldset:nth-of-type(3) legend') 
package_search_page.elements.create(:name => 'room 1 - age of child combobox 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(1) li.child_age_inputs:nth-of-type(1) li#package_search_traveler_groups_child_age_input.select a.selectBox')        
package_search_page.elements.create(:name => 'room 1 - age of child combobox 2', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(1) li.child_age_inputs:nth-of-type(2) li#package_search_traveler_groups_child_age_input.select a.selectBox')        
package_search_page.elements.create(:name => 'room 1 - age of child combobox 3', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(1) li.child_age_inputs:nth-of-type(3) li#package_search_traveler_groups_child_age_input.select a.selectBox')        
package_search_page.elements.create(:name => 'room 1 - age of child combobox 4', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(1) li.child_age_inputs:nth-of-type(4) li#package_search_traveler_groups_child_age_input.select a.selectBox')        
package_search_page.elements.create(:name => 'room 1 - age of child combobox 5', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(1) li.child_age_inputs:nth-of-type(5) li#package_search_traveler_groups_child_age_input.select a.selectBox')        
package_search_page.elements.create(:name => 'room 2 - age of child combobox 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(2) li.child_age_inputs:nth-of-type(1) li#package_search_traveler_groups_child_age_input.select a.selectBox')        
package_search_page.elements.create(:name => 'room 2 - age of child combobox 2', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(2) li.child_age_inputs:nth-of-type(2) li#package_search_traveler_groups_child_age_input.select a.selectBox')        
package_search_page.elements.create(:name => 'room 2 - age of child combobox 3', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(2) li.child_age_inputs:nth-of-type(3) li#package_search_traveler_groups_child_age_input.select a.selectBox')        
package_search_page.elements.create(:name => 'room 2 - age of child combobox 4', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(2) li.child_age_inputs:nth-of-type(4) li#package_search_traveler_groups_child_age_input.select a.selectBox')        
package_search_page.elements.create(:name => 'room 2 - age of child combobox 5', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(2) li.child_age_inputs:nth-of-type(5) li#package_search_traveler_groups_child_age_input.select a.selectBox')  
package_search_page.elements.create(:name => 'room 3 - age of child combobox 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(3) li.child_age_inputs:nth-of-type(1) li#package_search_traveler_groups_child_age_input.select a.selectBox')        
package_search_page.elements.create(:name => 'room 3 - age of child combobox 2', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(3) li.child_age_inputs:nth-of-type(2) li#package_search_traveler_groups_child_age_input.select a.selectBox')        
package_search_page.elements.create(:name => 'room 3 - age of child combobox 3', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(3) li.child_age_inputs:nth-of-type(3) li#package_search_traveler_groups_child_age_input.select a.selectBox')        
package_search_page.elements.create(:name => 'room 3 - age of child combobox 4', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(3) li.child_age_inputs:nth-of-type(4) li#package_search_traveler_groups_child_age_input.select a.selectBox')        
package_search_page.elements.create(:name => 'room 3 - age of child combobox 5', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(3) li.child_age_inputs:nth-of-type(5) li#package_search_traveler_groups_child_age_input.select a.selectBox')  
package_search_page.elements.create(:name => 'room 4 - age of child combobox 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(4) li.child_age_inputs:nth-of-type(1) li#package_search_traveler_groups_child_age_input.select a.selectBox')        
package_search_page.elements.create(:name => 'room 4 - age of child combobox 2', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(4) li.child_age_inputs:nth-of-type(2) li#package_search_traveler_groups_child_age_input.select a.selectBox')        
package_search_page.elements.create(:name => 'room 4 - age of child combobox 3', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(4) li.child_age_inputs:nth-of-type(3) li#package_search_traveler_groups_child_age_input.select a.selectBox')        
package_search_page.elements.create(:name => 'room 4 - age of child combobox 4', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(4) li.child_age_inputs:nth-of-type(4) li#package_search_traveler_groups_child_age_input.select a.selectBox')        
package_search_page.elements.create(:name => 'room 4 - age of child combobox 5', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(4) li.child_age_inputs:nth-of-type(5) li#package_search_traveler_groups_child_age_input.select a.selectBox')  
package_search_page.elements.create(:name => 'room 1 - child in seat option 1', :by_css_locator => 'label[for="package_search_traveler_groups_child_seated_0_1"]')  
package_search_page.elements.create(:name => 'room 1 - child in seat option 2', :by_css_locator => 'label[for="package_search_traveler_groups_child_seated_0_2"]')   
package_search_page.elements.create(:name => 'room 1 - child in seat option 3', :by_css_locator => 'label[for="package_search_traveler_groups_child_seated_0_3"]')
package_search_page.elements.create(:name => 'room 1 - child in seat option 4', :by_css_locator => 'label[for="package_search_traveler_groups_child_seated_0_4"]')
package_search_page.elements.create(:name => 'room 1 - child in seat option 5', :by_css_locator => 'label[for="package_search_traveler_groups_child_seated_0_5"]')
package_search_page.elements.create(:name => 'room 2 - child in seat option 1', :by_css_locator => 'label[for="package_search_traveler_groups_child_seated_1_1"]')  
package_search_page.elements.create(:name => 'room 2 - child in seat option 2', :by_css_locator => 'label[for="package_search_traveler_groups_child_seated_1_2"]')   
package_search_page.elements.create(:name => 'room 2 - child in seat option 3', :by_css_locator => 'label[for="package_search_traveler_groups_child_seated_1_3"]')
package_search_page.elements.create(:name => 'room 2 - child in seat option 4', :by_css_locator => 'label[for="package_search_traveler_groups_child_seated_1_4"]')
package_search_page.elements.create(:name => 'room 2 - child in seat option 5', :by_css_locator => 'label[for="package_search_traveler_groups_child_seated_1_5"]')
package_search_page.elements.create(:name => 'room 3 - child in seat option 1', :by_css_locator => 'label[for="package_search_traveler_groups_child_seated_2_1"]')  
package_search_page.elements.create(:name => 'room 3 - child in seat option 2', :by_css_locator => 'label[for="package_search_traveler_groups_child_seated_2_2"]')   
package_search_page.elements.create(:name => 'room 3 - child in seat option 3', :by_css_locator => 'label[for="package_search_traveler_groups_child_seated_2_3"]')
package_search_page.elements.create(:name => 'room 3 - child in seat option 4', :by_css_locator => 'label[for="package_search_traveler_groups_child_seated_2_4"]')
package_search_page.elements.create(:name => 'room 3 - child in seat option 5', :by_css_locator => 'label[for="package_search_traveler_groups_child_seated_2_5"]')
package_search_page.elements.create(:name => 'room 4 - child in seat option 1', :by_css_locator => 'label[for="package_search_traveler_groups_child_seated_3_1"]')  
package_search_page.elements.create(:name => 'room 4 - child in seat option 2', :by_css_locator => 'label[for="package_search_traveler_groups_child_seated_3_2"]')   
package_search_page.elements.create(:name => 'room 4 - child in seat option 3', :by_css_locator => 'label[for="package_search_traveler_groups_child_seated_3_3"]')
package_search_page.elements.create(:name => 'room 4 - child in seat option 4', :by_css_locator => 'label[for="package_search_traveler_groups_child_seated_3_4"]')
package_search_page.elements.create(:name => 'room 4 - child in seat option 5', :by_css_locator => 'label[for="package_search_traveler_groups_child_seated_3_5"]')
package_search_page.elements.create(:name => 'room 1 - child in lap option 1', :by_css_locator => 'label[for="package_search_traveler_groups_child_lap_0_1"]')  
package_search_page.elements.create(:name => 'room 1 - child in lap option 2', :by_css_locator => 'label[for="package_search_traveler_groups_child_lap_0_2"]')   
package_search_page.elements.create(:name => 'room 1 - child in lap option 3', :by_css_locator => 'label[for="package_search_traveler_groups_child_lap_0_3"]')
package_search_page.elements.create(:name => 'room 1 - child in lap option 4', :by_css_locator => 'label[for="package_search_traveler_groups_child_lap_0_4"]')
package_search_page.elements.create(:name => 'room 1 - child in lap option 5', :by_css_locator => 'label[for="package_search_traveler_groups_child_lap_0_5"]')
package_search_page.elements.create(:name => 'room 2 - child in lap option 1', :by_css_locator => 'label[for="package_search_traveler_groups_child_lap_1_1"]')  
package_search_page.elements.create(:name => 'room 2 - child in lap option 2', :by_css_locator => 'label[for="package_search_traveler_groups_child_lap_1_2"]')   
package_search_page.elements.create(:name => 'room 2 - child in lap option 3', :by_css_locator => 'label[for="package_search_traveler_groups_child_lap_1_3"]')
package_search_page.elements.create(:name => 'room 2 - child in lap option 4', :by_css_locator => 'label[for="package_search_traveler_groups_child_lap_1_4"]')
package_search_page.elements.create(:name => 'room 2 - child in lap option 5', :by_css_locator => 'label[for="package_search_traveler_groups_child_lap_1_5"]')
package_search_page.elements.create(:name => 'room 3 - child in lap option 1', :by_css_locator => 'label[for="package_search_traveler_groups_child_lap_2_1"]')  
package_search_page.elements.create(:name => 'room 3 - child in lap option 2', :by_css_locator => 'label[for="package_search_traveler_groups_child_lap_2_2"]')   
package_search_page.elements.create(:name => 'room 3 - child in lap option 3', :by_css_locator => 'label[for="package_search_traveler_groups_child_lap_2_3"]')
package_search_page.elements.create(:name => 'room 3 - child in lap option 4', :by_css_locator => 'label[for="package_search_traveler_groups_child_lap_2_4"]')
package_search_page.elements.create(:name => 'room 3 - child in lap option 5', :by_css_locator => 'label[for="package_search_traveler_groups_child_lap_2_5"]')
package_search_page.elements.create(:name => 'room 4 - child in lap option 1', :by_css_locator => 'label[for="package_search_traveler_groups_child_lap_3_1"]')  
package_search_page.elements.create(:name => 'room 4 - child in lap option 2', :by_css_locator => 'label[for="package_search_traveler_groups_child_lap_3_2"]')   
package_search_page.elements.create(:name => 'room 4 - child in lap option 3', :by_css_locator => 'label[for="package_search_traveler_groups_child_lap_3_3"]')
package_search_page.elements.create(:name => 'room 4 - child in lap option 4', :by_css_locator => 'label[for="package_search_traveler_groups_child_lap_3_4"]')
package_search_page.elements.create(:name => 'room 4 - child in lap option 5', :by_css_locator => 'label[for="package_search_traveler_groups_child_lap_3_5"]')
package_search_page.elements.create(:name => 'room 1 - child in seat option input 1', :by_id_locator => 'package_search_traveler_groups_child_seated_0_1')  
package_search_page.elements.create(:name => 'room 1 - child in seat option input 2', :by_id_locator => 'package_search_traveler_groups_child_seated_0_2')   
package_search_page.elements.create(:name => 'room 1 - child in seat option input 3', :by_id_locator => 'package_search_traveler_groups_child_seated_0_3')
package_search_page.elements.create(:name => 'room 1 - child in seat option input 4', :by_id_locator => 'package_search_traveler_groups_child_seated_0_4')
package_search_page.elements.create(:name => 'room 1 - child in seat option input 5', :by_id_locator => 'package_search_traveler_groups_child_seated_0_5')
package_search_page.elements.create(:name => 'room 2 - child in seat option input 1', :by_id_locator => 'package_search_traveler_groups_child_seated_1_1')  
package_search_page.elements.create(:name => 'room 2 - child in seat option input 2', :by_id_locator => 'package_search_traveler_groups_child_seated_1_2')   
package_search_page.elements.create(:name => 'room 2 - child in seat option input 3', :by_id_locator => 'package_search_traveler_groups_child_seated_1_3')
package_search_page.elements.create(:name => 'room 2 - child in seat option input 4', :by_id_locator => 'package_search_traveler_groups_child_seated_1_4')
package_search_page.elements.create(:name => 'room 2 - child in seat option input 5', :by_id_locator => 'package_search_traveler_groups_child_seated_1_5')
package_search_page.elements.create(:name => 'room 3 - child in seat option input 1', :by_id_locator => 'package_search_traveler_groups_child_seated_2_1')  
package_search_page.elements.create(:name => 'room 3 - child in seat option input 2', :by_id_locator => 'package_search_traveler_groups_child_seated_2_2')   
package_search_page.elements.create(:name => 'room 3 - child in seat option input 3', :by_id_locator => 'package_search_traveler_groups_child_seated_2_3')
package_search_page.elements.create(:name => 'room 3 - child in seat option input 4', :by_id_locator => 'package_search_traveler_groups_child_seated_2_4')
package_search_page.elements.create(:name => 'room 3 - child in seat option input 5', :by_id_locator => 'package_search_traveler_groups_child_seated_2_5')
package_search_page.elements.create(:name => 'room 4 - child in seat option input 1', :by_id_locator => 'package_search_traveler_groups_child_seated_3_1')  
package_search_page.elements.create(:name => 'room 4 - child in seat option input 2', :by_id_locator => 'package_search_traveler_groups_child_seated_3_2')   
package_search_page.elements.create(:name => 'room 4 - child in seat option input 3', :by_id_locator => 'package_search_traveler_groups_child_seated_3_3')
package_search_page.elements.create(:name => 'room 4 - child in seat option input 4', :by_id_locator => 'package_search_traveler_groups_child_seated_3_4')
package_search_page.elements.create(:name => 'room 4 - child in seat option input 5', :by_id_locator => 'package_search_traveler_groups_child_seated_3_5')
package_search_page.elements.create(:name => 'room 1 - child in lap option input 1', :by_id_locator => 'package_search_traveler_groups_child_lap_0_1')  
package_search_page.elements.create(:name => 'room 1 - child in lap option input 2', :by_id_locator => 'package_search_traveler_groups_child_lap_0_2')   
package_search_page.elements.create(:name => 'room 1 - child in lap option input 3', :by_id_locator => 'package_search_traveler_groups_child_lap_0_3')
package_search_page.elements.create(:name => 'room 1 - child in lap option input 4', :by_id_locator => 'package_search_traveler_groups_child_lap_0_4')
package_search_page.elements.create(:name => 'room 1 - child in lap option input 5', :by_id_locator => 'package_search_traveler_groups_child_lap_0_5')
package_search_page.elements.create(:name => 'room 2 - child in lap option input 1', :by_id_locator => 'package_search_traveler_groups_child_lap_1_1')  
package_search_page.elements.create(:name => 'room 2 - child in lap option input 2', :by_id_locator => 'package_search_traveler_groups_child_lap_1_2')   
package_search_page.elements.create(:name => 'room 2 - child in lap option input 3', :by_id_locator => 'package_search_traveler_groups_child_lap_1_3')
package_search_page.elements.create(:name => 'room 2 - child in lap option input 4', :by_id_locator => 'package_search_traveler_groups_child_lap_1_4')
package_search_page.elements.create(:name => 'room 2 - child in lap option input 5', :by_id_locator => 'package_search_traveler_groups_child_lap_1_5')
package_search_page.elements.create(:name => 'room 3 - child in lap option input 1', :by_id_locator => 'package_search_traveler_groups_child_lap_2_1')  
package_search_page.elements.create(:name => 'room 3 - child in lap option input 2', :by_id_locator => 'package_search_traveler_groups_child_lap_2_2')   
package_search_page.elements.create(:name => 'room 3 - child in lap option input 3', :by_id_locator => 'package_search_traveler_groups_child_lap_2_3')
package_search_page.elements.create(:name => 'room 3 - child in lap option input 4', :by_id_locator => 'package_search_traveler_groups_child_lap_2_4')
package_search_page.elements.create(:name => 'room 3 - child in lap option input 5', :by_id_locator => 'package_search_traveler_groups_child_lap_2_5')
package_search_page.elements.create(:name => 'room 4 - child in lap option input 1', :by_id_locator => 'package_search_traveler_groups_child_lap_3_1')  
package_search_page.elements.create(:name => 'room 4 - child in lap option input 2', :by_id_locator => 'package_search_traveler_groups_child_lap_3_2')   
package_search_page.elements.create(:name => 'room 4 - child in lap option input 3', :by_id_locator => 'package_search_traveler_groups_child_lap_3_3')
package_search_page.elements.create(:name => 'room 4 - child in lap option input 4', :by_id_locator => 'package_search_traveler_groups_child_lap_3_4')
package_search_page.elements.create(:name => 'room 4 - child in lap option input 5', :by_id_locator => 'package_search_traveler_groups_child_lap_3_5')
package_search_page.elements.create(:name => 'how many rooms and travelers help link', :by_css_locator => 'form.search-form * a.question')
package_search_page.elements.create(:name => 'help popup text paragraphs', :by_css_locator => 'div.ui-dialog div.dialog-travelers-help p')
package_search_page.elements.create(:name => 'help popup innerhtml element', :by_css_locator => 'div.ui-dialog[aria-labelledby="ui-dialog-title-1"]')
package_search_page.elements.create(:name => 'where are you going subtitle text element', :by_css_locator => 'fieldset.main-fieldset:nth-of-type(1) legend')
package_search_page.elements.create(:name => 'package search error messages', :by_css_locator => 'div ul.errors li')
#package_wk50_axpt2605_spec
package_search_page.elements.create(:name => 'date calendar', :by_id_locator => 'ui-datepicker-div')
package_search_page.elements.create(:name => 'date calendar next icon', :by_css_locator => 'div.ui-datepicker-header a.ui-datepicker-next')
package_results_page.elements.create(:name => 'package results page head title', :by_css_locator => 'div.your-flight div.page-width * div.your-option-text h2')
package_results_page.elements.create(:name => 'package results error messages', :by_css_locator => 'div ul.errors li')

#package_wk52_axpt3303_spec
package_results_page.elements.create(:name => 'sort by combobox', :by_css_locator => 'div.sorting-options a.selectBox')	
package_results_page.elements.create(:name => 'sort by combobox values', :by_xpath_locator => '/html/body/ul[39]/li/a')                                                                                                                               
package_results_page.elements.create(:name => 'results hotel names', :by_css_locator => 'div.results-title')	                 
package_results_page.elements.create(:name => 'results hotel prices', :by_css_locator => 'span._jq-rate-card-price')                                                                                                                                                                                    
package_results_page.elements.create(:name => 'first card star five', :by_css_locator => 'li.col-card:nth-of-type(1) div.blocksep div:nth-of-type(5)')
package_results_page.elements.create(:name => 'first card star four', :by_css_locator => 'li.col-card:nth-of-type(1) div.blocksep div:nth-of-type(4)')
package_results_page.elements.create(:name => 'first card star three', :by_css_locator => 'li.col-card:nth-of-type(1) div.blocksep div:nth-of-type(3)')
package_results_page.elements.create(:name => 'second card star five', :by_css_locator => 'li.col-card:nth-of-type(2) div.blocksep div:nth-of-type(5)')
package_results_page.elements.create(:name => 'second card star four', :by_css_locator => 'li.col-card:nth-of-type(2) div.blocksep div:nth-of-type(4)')
package_results_page.elements.create(:name => 'second card star three', :by_css_locator => 'li.col-card:nth-of-type(2) div.blocksep div:nth-of-type(3)')
package_results_page.elements.create(:name => 'third card star five', :by_css_locator => 'li.col-card:nth-of-type(3) div.blocksep div:nth-of-type(5)')
package_results_page.elements.create(:name => 'third card star four', :by_css_locator => 'li.col-card:nth-of-type(3) div.blocksep div:nth-of-type(4)')
package_results_page.elements.create(:name => 'third card star three', :by_css_locator => 'li.col-card:nth-of-type(3) div.blocksep div:nth-of-type(3)')
package_results_page.elements.create(:name => 'help sorting icon', :by_class_locator => 'quest-mark-img') 
package_results_page.elements.create(:name => 'help sorting overlay title', :by_css_locator => 'div.ui-dialog div.ui-dialog-titlebar span#ui-dialog-title-2.ui-dialog-title') 
package_results_page.elements.create(:name => 'see all flights button', :by_css_locator => 'input._jq-open-loading') 
package_results_page.elements.create(:name => 'explanation text label', :by_css_locator => 'div.your-flight ul.dp-options li.last-li span') 
package_results_page.elements.create(:name => 'your hotel text element', :by_css_locator => 'div.your-hotel div.page-width div.bar div.your-option-text h2') 
package_results_page.elements.create(:name => 'hotel card titles', :by_css_locator => 'li.col-card * span._jq-rate-card-name') 
package_results_page.elements.create(:name => 'more details links', :by_css_locator => 'li.col-card div.bg div.second-result-column div.results-title a.more-links') 
#package_wk52_axpt3305_spec
package_results_page.elements.create(:name => 'rate card prices', :by_css_locator => 'li.col-card span._jq-rate-card-price')
package_results_page.elements.create(:name => 'booked separately prices', :by_css_locator => 'div.prices div.price-table div.row span.right-col span:nth-of-type(1)')
package_results_page.elements.create(:name => 'package savings prices', :by_css_locator => 'div.price-table div.second-row span.right-col span:nth-of-type(1)')
package_results_page.elements.create(:name => 'booked separately currencies', :by_css_locator => 'div.prices div.price-table div.row span.right-col span:nth-of-type(2)')
package_results_page.elements.create(:name => 'package savings currencies', :by_css_locator => 'div.price-table div.second-row span.right-col span:nth-of-type(2)')
#package_wk52_axpt3310_spec
package_results_page.elements.create(:name => 'results package cards', :by_css_locator => 'li.col-card')
#package_wk02_axpt3300_spec
package_results_page.elements.create(:name => 'adults combobox 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(1) li#package_search_traveler_groups_adults_input.select a.selectBox')                                                                                    
package_results_page.elements.create(:name => 'adults combobox 2', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(2) li#package_search_traveler_groups_adults_input.select a.selectBox')                                                                                    
package_results_page.elements.create(:name => 'adults combobox 3', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(3) li#package_search_traveler_groups_adults_input.select a.selectBox')                                                                                    
package_results_page.elements.create(:name => 'adults combobox 4', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(4) li#package_search_traveler_groups_adults_input.select a.selectBox')                                                                                    
package_results_page.elements.create(:name => 'seniors combobox 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(1) li#package_search_traveler_groups_seniors_input.select a.selectBox')                         
package_results_page.elements.create(:name => 'seniors combobox 2', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(2) li#package_search_traveler_groups_seniors_input.select a.selectBox')                         
package_results_page.elements.create(:name => 'seniors combobox 3', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(3) li#package_search_traveler_groups_seniors_input.select a.selectBox')                         
package_results_page.elements.create(:name => 'seniors combobox 4', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(4) li#package_search_traveler_groups_seniors_input.select a.selectBox')                          
package_results_page.elements.create(:name => 'children combobox 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(1) li#package_search_traveler_groups_child_count_input.select a.selectBox')                         
package_results_page.elements.create(:name => 'children combobox 2', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(2) li#package_search_traveler_groups_child_count_input.select a.selectBox')    
package_results_page.elements.create(:name => 'children combobox 3', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(3) li#package_search_traveler_groups_child_count_input.select a.selectBox')    
package_results_page.elements.create(:name => 'children combobox 4', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(4) li#package_search_traveler_groups_child_count_input.select a.selectBox')    
package_results_page.elements.create(:name => 'room 1 - children age combobox 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(1) li.child_age_inputs:nth-of-type(1) li#package_search_traveler_groups_child_age_input.select a.selectBox')    
package_results_page.elements.create(:name => 'room 2 - children age combobox 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(2) li.child_age_inputs:nth-of-type(1) li#package_search_traveler_groups_child_age_input.select a.selectBox')    
package_results_page.elements.create(:name => 'room 3 - children age combobox 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(3) li.child_age_inputs:nth-of-type(1) li#package_search_traveler_groups_child_age_input.select a.selectBox')    
package_results_page.elements.create(:name => 'room 4 - children age combobox 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(4) li.child_age_inputs:nth-of-type(1) li#package_search_traveler_groups_child_age_input.select a.selectBox')    
package_results_page.elements.create(:name => 'room 1 - child seated option 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(1) li.child_age_inputs:nth-of-type(1) li.choice:nth-of-type(1) label.ui-radio')       
package_results_page.elements.create(:name => 'room 2 - child seated option 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(2) li.child_age_inputs:nth-of-type(1) li.choice:nth-of-type(1) label.ui-radio')       
package_results_page.elements.create(:name => 'room 3 - child seated option 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(3) li.child_age_inputs:nth-of-type(1) li.choice:nth-of-type(1) label.ui-radio')       
package_results_page.elements.create(:name => 'room 4 - child seated option 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(4) li.child_age_inputs:nth-of-type(1) li.choice:nth-of-type(1) label.ui-radio')       
package_results_page.elements.create(:name => 'room 1 - child lap option 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(1) li.child_age_inputs:nth-of-type(1) li.choice:nth-of-type(2) label.ui-radio')    
package_results_page.elements.create(:name => 'room 2 - child lap option 2', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(2) li.child_age_inputs:nth-of-type(1) li.choice:nth-of-type(2) label.ui-radio')    
package_results_page.elements.create(:name => 'room 3 - child lap option 3', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(3) li.child_age_inputs:nth-of-type(1) li.choice:nth-of-type(2) label.ui-radio')    
package_results_page.elements.create(:name => 'room 4 - child lap option 4', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(4) li.child_age_inputs:nth-of-type(1) li.choice:nth-of-type(2) label.ui-radio')    
package_results_page.elements.create(:name => 'room 1 - child seated option input 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(1) li.child_age_inputs:nth-of-type(1) li.choice:nth-of-type(1) input')       
package_results_page.elements.create(:name => 'room 2 - child seated option input 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(2) li.child_age_inputs:nth-of-type(1) li.choice:nth-of-type(1) input')       
package_results_page.elements.create(:name => 'room 3 - child seated option input 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(3) li.child_age_inputs:nth-of-type(1) li.choice:nth-of-type(1) input')       
package_results_page.elements.create(:name => 'room 4 - child seated option input 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(4) li.child_age_inputs:nth-of-type(1) li.choice:nth-of-type(1) input')       
package_results_page.elements.create(:name => 'room 1 - child lap option input 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(1) li.child_age_inputs:nth-of-type(1) li.choice:nth-of-type(2) input')    
package_results_page.elements.create(:name => 'room 2 - child lap option input 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(2) li.child_age_inputs:nth-of-type(1) li.choice:nth-of-type(2) input')    
package_results_page.elements.create(:name => 'room 3 - child lap option input 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(3) li.child_age_inputs:nth-of-type(1) li.choice:nth-of-type(2) input')    
package_results_page.elements.create(:name => 'room 4 - child lap option input 1', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(4) li.child_age_inputs:nth-of-type(1) li.choice:nth-of-type(2) input')    
package_results_page.elements.create(:name => 'number of rooms link', :by_css_locator => 'fieldset.traveler-groups a.selectBox')
package_results_page.elements.create(:name => 'update button', :by_class_locator => 'button-update')

#package_wk02_axpt3299_spec
package_results_page.elements.create(:name => 'room text link', :by_css_locator => 'fieldset.traveler-groups a.selectBox')	
package_results_page.elements.create(:name => 'update button', :by_css_locator => 'input.button-update')	
package_results_page.elements.create(:name => 'room 1 adults combobox', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(1) ol li#package_search_traveler_groups_adults_input.select a.selectBox')	
package_results_page.elements.create(:name => 'room 2 adults combobox', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(2) ol li#package_search_traveler_groups_adults_input.select a.selectBox')	
package_results_page.elements.create(:name => 'room 3 adults combobox', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(3) ol li#package_search_traveler_groups_adults_input.select a.selectBox')	
package_results_page.elements.create(:name => 'room 4 adults combobox', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(4) ol li#package_search_traveler_groups_adults_input.select a.selectBox')	
package_results_page.elements.create(:name => 'room 1 seniors combobox', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(1) ol li#package_search_traveler_groups_seniors_input.select a.selectBox')	
package_results_page.elements.create(:name => 'room 2 seniors combobox', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(2) ol li#package_search_traveler_groups_seniors_input.select a.selectBox')	
package_results_page.elements.create(:name => 'room 3 seniors combobox', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(3) ol li#package_search_traveler_groups_seniors_input.select a.selectBox')	
package_results_page.elements.create(:name => 'room 4 seniors combobox', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(4) ol li#package_search_traveler_groups_seniors_input.select a.selectBox')	
package_results_page.elements.create(:name => 'first dp hotel card', :by_css_locator => 'li.col-card:nth-of-type(1) div.bg')	
package_results_page.elements.create(:name => 'travelers count link', :by_css_locator => 'span#_js-travelers-count')	 
package_results_page.elements.create(:name => 'room 1 children combobox', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(1) ol li#package_search_traveler_groups_child_count_input.select a.selectBox')	
package_results_page.elements.create(:name => 'room 2 children combobox', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(2) ol li#package_search_traveler_groups_child_count_input.select a.selectBox')	
package_results_page.elements.create(:name => 'room 3 children combobox', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(3) ol li#package_search_traveler_groups_child_count_input.select a.selectBox')	
package_results_page.elements.create(:name => 'room 4 children combobox', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(4) ol li#package_search_traveler_groups_child_count_input.select a.selectBox')	

#package_wk02_axpt3302_spec
package_results_page.elements.create(:name => 'departure city textbox', :by_id_locator => '_jq-dep-loc-from')
package_results_page.elements.create(:name => 'arrival city textbox', :by_id_locator => '_jq-dep-loc-to')
package_results_page.elements.create(:name => 'arrival city clean text input', :by_css_locator => 'img.dep_from_img')	
package_results_page.elements.create(:name => 'results error messages', :by_css_locator => 'div ul.errors li')
package_results_page.elements.create(:name => 'departure city clean text input', :by_css_locator => 'img.dep_to_img')	
package_disambiguation_page.elements.create(:name => 'disambiguation page title', :by_css_locator => 'div.dp-disambiguate h2')	
#package_wk02_axpt3301_spec
package_results_page.elements.create(:name => 'check-in date calendar', :by_id_locator => 'package_search_flight_search_slices_attributes_2_departure_date')
package_results_page.elements.create(:name => 'check-out date calendar', :by_id_locator => 'package_search_flight_search_slices_attributes_3_departure_date')	
package_results_page.elements.create(:name => 'calendar datepicker', :by_css_locator => 'div.ui-datepicker div.ui-datepicker-group')
package_results_page.elements.create(:name => 'calendar datepicker current months', :by_css_locator => 'div.ui-datepicker div.ui-datepicker-group div.ui-datepicker-header div.ui-datepicker-title span.ui-datepicker-month')
package_results_page.elements.create(:name => 'calendar datepicker next button', :by_css_locator => 'div.ui-datepicker div.ui-datepicker-group div.ui-datepicker-header a.ui-datepicker-next span.ui-icon')
package_results_page.elements.create(:name => 'calendar datepicker previous button', :by_css_locator => 'div.ui-datepicker div.ui-datepicker-group div.ui-datepicker-header a.ui-datepicker-prev span.ui-icon')
package_results_page.elements.create(:name => 'calendar datepicker day numbers', :by_css_locator => 'div.ui-datepicker div.ui-datepicker-group table.ui-datepicker-calendar tbody tr td.ui-datepicker-unselectable span.ui-state-default')
package_results_page.elements.create(:name => 'departure flight time label', :by_css_locator => 'div.slice:nth-of-type(1) div.segment div.endpoint:nth-of-type(2) span.time')
package_results_page.elements.create(:name => 'return flight time label', :by_css_locator => 'div.slice:nth-of-type(2) div.segment div.endpoint:nth-of-type(1) span.time')
package_results_page.elements.create(:name => 'flight times label', :by_css_locator => 'ul.dp-flight-cards li.flight-sol div.slice div.segment div.endpoint span.time')
package_results_page.elements.create(:name => 'interstitial main text label', :by_css_locator => 'div#_iz div.promo-section div.page-width h2')

#flight_wk50_axpt1858_spec
flight_results_page.elements.create(:name => 'baggage charges link', :by_css_locator => 'a.baggage-charges-link')
flight_results_page.elements.create(:name => 'baggage fees combobox', :by_css_locator => 'div.ui-dialog form.baggage-charges-lookup a.selectBox')
flight_results_page.elements.create(:name => 'baggage fees close button', :by_xpath_locator => '//div[11]/div/a/span') 
flight_results_page.elements.create(:name => 'baggage fees no data message', :by_css_locator => 'div.ui-dialog form.baggage-charges-lookup div.charges div.articleContent')
#flight_wk50_axpt2095_spec
flight_results_page.elements.create(:name => 'fare class link', :by_css_locator => 'form.search-form ul.edit-links li.select-box-link a.selectBox')
flight_results_page.elements.create(:name => 'update button', :by_css_locator => 'form.search-form ul.submit-button-update * input.update')
#flight_wk50_axpt2096_spec
flight_results_page.elements.create(:name => 'departure city textbox', :by_id_locator => 'flight_search_flight_search_slices_attributes_0_departure_search_for')
flight_results_page.elements.create(:name => 'arrival city textbox', :by_id_locator => 'flight_search_flight_search_slices_attributes_0_arrival_search_for')
flight_results_page.elements.create(:name => 'departure city clear button', :by_css_locator => 'form.search-form * img.dep_from_img')
flight_results_page.elements.create(:name => 'arrival city clear button', :by_css_locator => 'form.search-form * img.dep_to_img')
#flight_wk50_axpt2097_spec
flight_results_page.elements.create(:name => 'number of travelers link', :by_css_locator => 'form.search-form * a._jq-travelers-flyout-tab')
flight_results_page.elements.create(:name => 'adults combobox', :by_css_locator => 'form.search-form li#flight_search_traveler_groups_adults_input.select a.selectBox')                                                                                    
flight_results_page.elements.create(:name => 'seniors combobox', :by_css_locator => 'form.search-form li#flight_search_traveler_groups_seniors_input.select a.selectBox')
flight_results_page.elements.create(:name => 'children combobox', :by_css_locator => 'form.search-form li#flight_search_traveler_groups_child_count_input.select a.selectBox')
flight_results_page.elements.create(:name => 'children age combobox 1', :by_css_locator => 'form.search-form li.child_age_inputs:nth-of-type(1) a.selectBox')
flight_results_page.elements.create(:name => 'children age combobox 2', :by_css_locator => 'form.search-form li.child_age_inputs:nth-of-type(2) a.selectBox')
flight_results_page.elements.create(:name => 'children age combobox 3', :by_css_locator => 'form.search-form li.child_age_inputs:nth-of-type(3) a.selectBox')
flight_results_page.elements.create(:name => 'children age combobox 4', :by_css_locator => 'form.search-form li.child_age_inputs:nth-of-type(4) a.selectBox')
flight_results_page.elements.create(:name => 'child seated option 1', :by_css_locator => 'li.choice label[for="flight_search_traveler_group_child_seated_1"]')
flight_results_page.elements.create(:name => 'child seated option 2', :by_css_locator => 'li.choice label[for="flight_search_traveler_group_child_seated_2"]')
flight_results_page.elements.create(:name => 'child seated option 3', :by_css_locator => 'li.choice input[id="flight_search_traveler_group_child_seated_3"]')
flight_results_page.elements.create(:name => 'child seated option 4', :by_css_locator => 'li.choice label[for="flight_search_traveler_group_child_seated_4"]')
flight_results_page.elements.create(:name => 'child lap option 1', :by_css_locator => 'li.choice input[id="flight_search_traveler_group_child_lap_1"]')
flight_results_page.elements.create(:name => 'child lap option 2', :by_css_locator => 'li.choice label[for="flight_search_traveler_group_child_lap_2"]')
flight_results_page.elements.create(:name => 'child lap option 3', :by_css_locator => 'li.choice label[for="flight_search_traveler_group_child_lap_3"]')
flight_results_page.elements.create(:name => 'child lap option 4', :by_css_locator => 'li.choice label[for="flight_search_traveler_group_child_lap_4"]')        
                          
flight_results_page.elements.create(:name => 'child seated option input 1', :by_css_locator => 'li.choice input[id="flight_search_traveler_group_child_seated_1"]')             
flight_results_page.elements.create(:name => 'child seated option input 2', :by_css_locator => 'li.choice input[id="flight_search_traveler_group_child_seated_2"]')             
flight_results_page.elements.create(:name => 'child seated option input 3', :by_css_locator => 'li.choice input[id="flight_search_traveler_group_child_seated_3"]')             
flight_results_page.elements.create(:name => 'child seated option input 4', :by_css_locator => 'li.choice input[id="flight_search_traveler_group_child_seated_4"]')             

flight_results_page.elements.create(:name => 'child lap option input 1', :by_css_locator => 'li.choice input[id="flight_search_traveler_group_child_lap_1"]')             
flight_results_page.elements.create(:name => 'child lap option input 2', :by_css_locator => 'li.choice input[id="flight_search_traveler_group_child_lap_2"]')             
flight_results_page.elements.create(:name => 'child lap option input 3', :by_css_locator => 'li.choice input[id="flight_search_traveler_group_child_lap_3"]')             
flight_results_page.elements.create(:name => 'child lap option input 4', :by_css_locator => 'li.choice input[id="flight_search_traveler_group_child_lap_4"]') 
                          
flight_results_page.elements.create(:name => 'search error messages', :by_css_locator => 'div.error-handling div.page-width ul.errors li')
#flight_wk50_axpt2098_spec
flight_results_page.elements.create(:name => 'departure date textbox 1', :by_id_locator => 'flight_search_flight_search_slices_attributes_0_departure_date')
flight_results_page.elements.create(:name => 'return date textbox 1', :by_id_locator => 'flight_search_flight_search_slices_attributes_1_departure_date')
flight_results_page.elements.create(:name => 'calendar datepicker', :by_css_locator => 'div.ui-datepicker div.ui-datepicker-group')
flight_results_page.elements.create(:name => 'calendar datepicker current months', :by_css_locator => 'div.ui-datepicker div.ui-datepicker-group div.ui-datepicker-header div.ui-datepicker-title span.ui-datepicker-month')

flight_results_page.elements.create(:name => 'return date textbox 1', :by_id_locator => 'flight_search_flight_search_slices_attributes_1_departure_date')

flight_results_page.elements.create(:name => 'calendar datepicker', :by_css_locator => 'div.ui-datepicker div.ui-datepicker-group')
flight_results_page.elements.create(:name => 'calendar datepicker current months', :by_css_locator => 'div.ui-datepicker div.ui-datepicker-group div.ui-datepicker-header div.ui-datepicker-title span.ui-datepicker-month')

flight_results_page.elements.create(:name => 'calendar datepicker next button', :by_css_locator => 'div.ui-datepicker div.ui-datepicker-group div.ui-datepicker-header a.ui-datepicker-next span.ui-icon')
flight_results_page.elements.create(:name => 'calendar datepicker previous button', :by_css_locator => 'div.ui-datepicker div.ui-datepicker-group div.ui-datepicker-header a.ui-datepicker-prev span.ui-icon')

flight_results_page.elements.create(:name => 'calendar datepicker day numbers', :by_css_locator => 'div.ui-datepicker div.ui-datepicker-group table.ui-datepicker-calendar tbody tr td.ui-datepicker-unselectable span.ui-state-default')

#flight_wk50_axpt2323_spec
flight_results_page.elements.create(:name => 'flight results container', :by_css_locator => 'ul.flight-cards')

#flight_wk50_axpt2391_spec
flight_results_page.elements.create(:name => 'slice flight type titles', :by_css_locator => 'ul.flight-cards li.flight-solution:nth-of-type(1) div.slice div.endpoints h2')
flight_results_page.elements.create(:name => 'slice show hide flight details buttons', :by_css_locator => "ul.flight-cards li.flight-solution:nth-of-type(1) a.show-details span.plus-button")

#flight_wk50_axpt2398_spec
flight_results_page.elements.create(:name => 'price dollar matrix airline columns', :by_css_locator => 'table#selectable._js-content-matrix thead tr th.colhead')
flight_results_page.elements.create(:name => 'price dollar matrix collapse button', :by_css_locator => 'div.quick-compare div.page-width div.matrix-header div.collapse-button')
flight_results_page.elements.create(:name => 'price dollar matrix scroll bar', :by_css_locator => 'div._js-matrix div.slider a.handle')
flight_results_page.elements.create(:name => 'price dollar matrix stops rows', :by_css_locator => 'table._js-content-matrix tbody th.rowhead div.matrix-cell')

flight_results_page.elements.create(:name => 'price dollar matrix us dollar value row 1', :by_css_locator => 'table._js-content-matrix tbody tr:nth-of-type(1) td.price div.matrix-cell span.amount')
flight_results_page.elements.create(:name => 'price dollar matrix us dollar value row 2', :by_css_locator => 'table._js-content-matrix tbody tr:nth-of-type(2) td.price div.matrix-cell span.amount')
flight_results_page.elements.create(:name => 'price dollar matrix us dollar value row 3', :by_css_locator => 'table._js-content-matrix tbody tr:nth-of-type(3) td.price div.matrix-cell span.amount')
flight_results_page.elements.create(:name => 'price dollar matrix us dollar value row 4', :by_css_locator => 'table._js-content-matrix tbody tr:nth-of-type(4) td.price div.matrix-cell span.amount')
flight_results_page.elements.create(:name => 'price dollar matrix us dollar value row 5', :by_css_locator => 'table._js-content-matrix tbody tr:nth-of-type(5) td.price div.matrix-cell span.amount')




flight_page.elements.create(:name => 'round trip option', :by_css_locator => 'li#flight_search_trip_type_input.radio li.choice label.ui-radio[for=flight_search_trip_type_round_trip]')
flight_page.elements.create(:name => 'one way option', :by_css_locator => ' li#flight_search_trip_type_input.radio li.choice label.ui-radio[for=flight_search_trip_type_one_way]')
flight_page.elements.create(:name => 'multi city option', :by_css_locator => 'li#flight_search_trip_type_input.radio li.choice label.ui-radio[for=flight_search_trip_type_multi-city]')
flight_page.elements.create(:name => 'departure city textbox 1', :by_id_locator => 'flight_search_flight_search_slices_attributes_0_departure_search_for')
flight_page.elements.create(:name => 'departure city textbox 2', :by_id_locator => 'flight_search_flight_search_slices_attributes_1_departure_search_for')
flight_page.elements.create(:name => 'departure city textbox 3', :by_id_locator => 'flight_search_flight_search_slices_attributes_2_departure_search_for')
flight_page.elements.create(:name => 'departure city textbox 4', :by_id_locator => 'flight_search_flight_search_slices_attributes_3_departure_search_for')
flight_page.elements.create(:name => 'departure city textbox 5', :by_id_locator => 'flight_search_flight_search_slices_attributes_4_departure_search_for')
flight_page.elements.create(:name => 'departure city textbox 6', :by_id_locator => 'flight_search_flight_search_slices_attributes_5_departure_search_for')
flight_page.elements.create(:name => 'arrival city textbox 1', :by_id_locator => 'flight_search_flight_search_slices_attributes_0_arrival_search_for')
flight_page.elements.create(:name => 'arrival city textbox 2', :by_id_locator => 'flight_search_flight_search_slices_attributes_1_arrival_search_for')
flight_page.elements.create(:name => 'arrival city textbox 3', :by_id_locator => 'flight_search_flight_search_slices_attributes_2_arrival_search_for')
flight_page.elements.create(:name => 'arrival city textbox 4', :by_id_locator => 'flight_search_flight_search_slices_attributes_3_arrival_search_for')
flight_page.elements.create(:name => 'arrival city textbox 5', :by_id_locator => 'flight_search_flight_search_slices_attributes_4_arrival_search_for')
flight_page.elements.create(:name => 'arrival city textbox 6', :by_id_locator => 'flight_search_flight_search_slices_attributes_5_arrival_search_for')
flight_page.elements.create(:name => 'departure date textbox 1', :by_id_locator => 'flight_search_flight_search_slices_attributes_0_departure_date')
flight_page.elements.create(:name => 'departure date textbox 2', :by_id_locator => 'flight_search_flight_search_slices_attributes_1_departure_date')
flight_page.elements.create(:name => 'departure date textbox 3', :by_id_locator => 'flight_search_flight_search_slices_attributes_2_departure_date')
flight_page.elements.create(:name => 'departure date textbox 4', :by_id_locator => 'flight_search_flight_search_slices_attributes_3_departure_date')
flight_page.elements.create(:name => 'departure date textbox 5', :by_id_locator => 'flight_search_flight_search_slices_attributes_4_departure_date')
flight_page.elements.create(:name => 'departure date textbox 6', :by_id_locator => 'flight_search_flight_search_slices_attributes_5_departure_date')
flight_page.elements.create(:name => 'departure time combobox 1', :by_css_locator => 'form.search-form fieldset.flight-search-locations * li#flight_search_flight_search_slices_attributes_0_departure_hour_range_input._jq-dep-time a.selectBox')
flight_page.elements.create(:name => 'departure time combobox 2', :by_css_locator => 'form.search-form fieldset.flight-search-locations * li#flight_search_flight_search_slices_attributes_1_departure_hour_range_input._jq-dep-time a.selectBox')                                                                           	
flight_page.elements.create(:name => 'departure time combobox 3', :by_css_locator => 'form.search-form fieldset.flight-search-locations * li#flight_search_flight_search_slices_attributes_2_departure_hour_range_input._jq-dep-time a.selectBox')
flight_page.elements.create(:name => 'departure time combobox 4', :by_css_locator => 'form.search-form fieldset.flight-search-locations * li#flight_search_flight_search_slices_attributes_3_departure_hour_range_input._jq-dep-time a.selectBox')                                                                           	                                                                          		
flight_page.elements.create(:name => 'departure time combobox 5', :by_css_locator => 'form.search-form fieldset.flight-search-locations * li#flight_search_flight_search_slices_attributes_4_departure_hour_range_input._jq-dep-time a.selectBox')
flight_page.elements.create(:name => 'departure time combobox 6', :by_css_locator => 'form.search-form fieldset.flight-search-locations * li#flight_search_flight_search_slices_attributes_5_departure_hour_range_input._jq-dep-time a.selectBox')
flight_page.elements.create(:name => 'return date textbox', :by_id_locator => 'flight_search_flight_search_slices_attributes_1_departure_date')
flight_page.elements.create(:name => 'return time combobox', :by_css_locator => 'form.search-form fieldset.flight-search-locations * li#flight_search_flight_search_slices_attributes_1_departure_hour_range_input._jq-dep-time a.selectBox')                                                                           
flight_page.elements.create(:name => 'adults combobox', :by_css_locator => 'form.search-form li#flight_search_traveler_groups_adults_input.select a.selectBox')                                                                           
flight_page.elements.create(:name => 'seniors combobox', :by_css_locator => 'form.search-form li#flight_search_traveler_groups_seniors_input.select a.selectBox')
flight_page.elements.create(:name => 'children combobox', :by_css_locator => 'form.search-form li#flight_search_traveler_groups_child_count_input.select a.selectBox')

flight_page.elements.create(:name => 'children age combobox 1', :by_css_locator => 'form.search-form li.child_age_inputs:nth-of-type(1) a.selectBox')
flight_page.elements.create(:name => 'children age combobox 2', :by_css_locator => 'form.search-form li.child_age_inputs:nth-of-type(2) a.selectBox')
flight_page.elements.create(:name => 'children age combobox 3', :by_css_locator => 'form.search-form li.child_age_inputs:nth-of-type(3) a.selectBox')
flight_page.elements.create(:name => 'children age combobox 4', :by_css_locator => 'form.search-form li.child_age_inputs:nth-of-type(4) a.selectBox')

flight_page.elements.create(:name => 'child seated option 1', :by_css_locator => 'li.choice label[for="flight_search_traveler_group_child_seated_1"]')
flight_page.elements.create(:name => 'child seated option 2', :by_css_locator => 'li.choice label[for="flight_search_traveler_group_child_seated_2"]')
flight_page.elements.create(:name => 'child seated option 3', :by_css_locator => 'li.choice label[for="flight_search_traveler_group_child_seated_3"]')
flight_page.elements.create(:name => 'child seated option 4', :by_css_locator => 'li.choice label[for="flight_search_traveler_group_child_seated_4"]')
flight_page.elements.create(:name => 'child lap option 1', :by_css_locator => 'li.choice label[for="flight_search_traveler_group_child_lap_1"]')
flight_page.elements.create(:name => 'child lap option 2', :by_css_locator => 'li.choice label[for="flight_search_traveler_group_child_lap_2"]')
flight_page.elements.create(:name => 'child lap option 3', :by_css_locator => 'li.choice label[for="flight_search_traveler_group_child_lap_3"]')
flight_page.elements.create(:name => 'child lap option 4', :by_css_locator => 'li.choice label[for="flight_search_traveler_group_child_lap_4"]')   

flight_page.elements.create(:name => 'fare class combobox', :by_css_locator => 'form.search-form * li#flight_search_cabin_type_input.select a.selectBox')
flight_page.elements.create(:name => 'show only non stop flights checkbox', :by_id_locator => 'flight_search_nonstop_only') 
flight_page.elements.create(:name => 'show only refundable fares checkbox', :by_id_locator => 'flight_search_refundable_only_input') 
flight_page.elements.create(:name => 'search only preferred airline checkbox', :by_id_locator => 'only-pref-all-air') 
flight_page.elements.create(:name => 'search flights button', :by_css_locator => 'form.search-form fieldset.buttons li.commit input[name=flight]')
flight_page.elements.create(:name => 'add another flight link', :by_css_locator => 'form.search-form div.add-slice a')      	
# flight_wk50_axpt2610_spec
flight_page.elements.create(:name => 'airports worldwide departure link', :by_css_locator => 'form.search-form fieldset.flight-search-locations ol li.input fieldset.inputs ol li.input fieldset._jq-location-inputs ol div.departure-and-arrival-labels span.departure-label a._jq-airport-picker-link')
flight_page.elements.create(:name => 'airports worldwide arrival link', :by_css_locator => 'form.search-form fieldset.flight-search-locations ol li.input fieldset.inputs ol li.input fieldset._jq-location-inputs ol div.departure-and-arrival-labels span.arrival-label a._jq-airport-picker-link')
flight_page.elements.create(:name => 'airports worldwide overlay title', :by_css_locator => 'span#ui-dialog-title-_jq-airport-dialog')
flight_page.elements.create(:name => 'airports worldwide overlay icon close button', :by_css_locator => 'div.ui-dialog[aria-labelledby="ui-dialog-title-_jq-airport-dialog"] span.ui-icon')
flight_page.elements.create(:name => 'airports worldwide overlay us airports tab', :by_id_locator => 'link-us')
flight_page.elements.create(:name => 'airports worldwide overlay canadian airports tab', :by_id_locator => 'link-canadian')
flight_page.elements.create(:name => 'airports worldwide overlay intl airports tab', :by_id_locator => 'link-international')
flight_page.elements.create(:name => 'airports worldwide overlay us airports abecedary letter link', :by_css_locator => 'div.airport_popup div#us._jq-airports-list-section p.letters-links a[href="#USM"]')
flight_page.elements.create(:name => 'airports worldwide overlay intl airports abecedary letter link', :by_css_locator => 'div.airport_popup div#international._jq-airports-list-section p.letters-links a[href="#INTM"]')
flight_page.elements.create(:name => 'airports worldwide overlay us airports code link', :by_css_locator => 'div.ui-dialog div.dialog-modal div.airport_popup div.ui-tabs div._jq-scrollpane div.jspContainer div.jspPane li a#MCN.iata')
flight_page.elements.create(:name => 'airports worldwide overlay canadian airports code link', :by_id_locator => 'YYC')
flight_page.elements.create(:name => 'airports worldwide overlay intl airports code link', :by_id_locator => 'MST')
flight_page.elements.create(:name => 'airports worldwide overlay us airports abecedary letter title', :by_id_locator => 'USA')
flight_page.elements.create(:name => 'airports worldwide overlay us airports back to top link', :by_css_locator => 'div.airport_popup div#us._jq-airports-list-section p.returntoTop:nth-of-type(12) a')
flight_page.elements.create(:name => 'airports worldwide overlay intl airports back to top link', :by_css_locator => 'div.airport_popup div#international._jq-airports-list-section p.returntoTop:nth-of-type(12) a')
flight_page.elements.create(:name => 'airports worldwide overlay intl airports abecedary letter title', :by_id_locator => 'INTA')
flight_page.elements.create(:name => 'airports worldwide overlay us scrollpane', :by_css_locator => 'div.airport_popup div#us._jq-airports-list-section div._jq-scrollpane div.jspContainer div.jspVerticalBar div.jspTrack div.jspDrag')
flight_page.elements.create(:name => 'airports worldwide overlay intl scrollpane', :by_css_locator => 'div.airport_popup div#airport-scroll div#international._jq-airports-list-section div._jq-scrollpane div.jspContainer div.jspVerticalBar div.jspTrack div.jspDrag')
# flight_wk50_axpt2323_spec
flight_page.elements.create(:name => 'show only refundable fares label', :by_css_locator => 'form.search-form fieldset.flight-search-more-options li#flight_search_refundable_only_input.boolean label.ui-checkbox')
# flight_wk50_axpt2427_spec
flight_page.elements.create(:name => 'on air rate card alert day label', :by_css_locator => 'ul.flight-cards li.flight-solution:nth-of-type(1) div.slice div.endpoints div.segment div.alerts-up')
flight_page.elements.create(:name => 'on air rate card alert change planes label', :by_css_locator => 'ul.flight-cards li.flight-solution:nth-of-type(1) div.slice div.endpoints div.segment div.info-layovers span.alerts-down')
flight_page.elements.create(:name => 'on air rate card alert subject to government approval label', :by_css_locator => 'ul.flight-cards li.flight-solution div.slice div.endpoints div.segment div.info-layovers span.alerts-down:nth-of-type(4)')
# flight_wk50_axpt2713_spec
flight_page.elements.create(:name => 'log in on the rate card login label', :by_css_locator => 'ul.flight-cards li.flight-solution:nth-of-type(1) div.purchase div.cost-info div.points div.login-label')
flight_page.elements.create(:name => 'log in on the rate card rewards label', :by_css_locator => 'ul.flight-cards li.flight-solution:nth-of-type(1) div.purchase div.cost-info div.points div.rewards-label')
flight_page.elements.create(:name => 'log in on the rate card log in button', :by_css_locator => 'ul.flight-cards li.flight-solution:nth-of-type(1) div.purchase a.login')
# flight_wk50_axpt2425_spec
flight_disambiguation_page.elements.create(:name => 'disambiguation destinations list titles', :by_css_locator => 'form.search-form * legend')
flight_disambiguation_page.elements.create(:name => 'disambiguation first selection in all options', :by_css_locator => 'li.choice:nth-of-type(1) label.ui-radio')
flight_disambiguation_page.elements.create(:name => 'disambiguation message error label', :by_css_locator => 'form.disambiguation-form * ul.errors li')
flight_results_page.elements.create(:name => 'quick compare air title', :by_css_locator => 'div.compare-text h2')        
#flight_wk50_axpt2096_spec
flight_disambiguation_page.elements.create(:name => 'departure city disambiguation option button', :by_css_locator => 'li.choice label[for="flight_search_flight_search_slices_attributes_0_departure_iata_code_mia"]')
flight_disambiguation_page.elements.create(:name => 'arrival city disambiguation option button', :by_css_locator => 'li.choice label[for="flight_search_flight_search_slices_attributes_0_arrival_iata_code_mdw"]')
flight_disambiguation_page.elements.create(:name => 'update flight search button', :by_css_locator => 'form.search-form input.search-buttons')
#package_wk50_axpt2608_spec
package_disambiguation_page.elements.create(:name => 'disambiguation destinations list titles', :by_css_locator => 'form.disambiguation-form * legend')
package_disambiguation_page.elements.create(:name => 'package disambiguation destinations list titles', :by_css_locator => 'form.disambiguation-form * legend')
package_disambiguation_page.elements.create(:name => 'disambiguation first selection in all options', :by_css_locator => 'li.choice:nth-of-type(1) label.ui-radio')
package_disambiguation_page.elements.create(:name => 'disambiguation message error label', :by_css_locator => 'form.disambiguation-form * ul.errors li')
package_disambiguation_page.elements.create(:name => 'departure city disambiguation option button', :by_css_locator => 'li.choice label[for="flight_search_flight_search_slices_attributes_0_departure_iata_code_mia"]')
package_disambiguation_page.elements.create(:name => 'arrival city disambiguation option button', :by_css_locator => 'li.choice label[for="flight_search_flight_search_slices_attributes_0_arrival_iata_code_mdw"]')
package_disambiguation_page.elements.create(:name => 'update package search button', :by_css_locator => 'input.disambiguation-button')
package_disambiguation_page.elements.create(:name => 'back to home link', :by_css_locator => 'div.back-home a')

#package_sp05_axpt1970_spec
package_results_page.elements.create(:name => 'start a new search link', :by_link_text_locator => 'Start a new search')
package_search_page.elements.create(:name => 'airports overlay departure link', :by_css_locator => 'span.departure-label a._jq-airport-picker-link')
package_search_page.elements.create(:name => 'airports overlay arrival link', :by_css_locator => 'span.arrival-label a._jq-airport-picker-link')

#package_sp05_axpt1767_spec
package_results_page.elements.create(:name => 'roundtrip flight details link', :by_css_locator => 'div.dp-show-details a')
package_results_page.elements.create(:name => 'air rate card departure slice alerts city name airport code', :by_css_locator => 'div.slice:nth-of-type(1) div.more-segments span.airport')
package_results_page.elements.create(:name => 'air rate card departure slice alerts cabin class', :by_css_locator => 'div.slice:nth-of-type(1) span.alerts-down:nth-of-type(1)')
package_results_page.elements.create(:name => 'air rate card departure slice alerts time', :by_css_locator => 'div.slice:nth-of-type(1) div.more-segments span.time')
package_results_page.elements.create(:name => 'air rate card departure slice alerts legs equipment', :by_css_locator => 'div.slice:nth-of-type(1) span.alerts-down:nth-of-type(3)')
package_results_page.elements.create(:name => 'air rate card departure slice alerts mileage', :by_css_locator => 'div.slice:nth-of-type(1) span.alerts-down:nth-of-type(4)')
package_results_page.elements.create(:name => 'air rate card departure slice alerts legs food beverage service', :by_css_locator => 'div.slice:nth-of-type(1) span.alerts-down:nth-of-type(5)')
package_results_page.elements.create(:name => 'air rate card departure slice logo 1 img', :by_css_locator => 'div.slice:nth-of-type(1) div.airline div.logo img')
package_results_page.elements.create(:name => 'air rate card departure slice logo 2 img', :by_css_locator => 'div.slice:nth-of-type(1) div.airline-leg div.logo img')
package_results_page.elements.create(:name => 'air rate card segments with logo', :by_css_locator => 'div.segment-with-logo div.endpoints_legs div.endpoint')

package_results_page.elements.create(:name => 'air rate card return slice alerts city name airport code', :by_css_locator => 'div.slice:nth-of-type(2) div.more-segments span.airport')
package_results_page.elements.create(:name => 'air rate card return slice alerts cabin class', :by_css_locator => 'div.slice:nth-of-type(2) span.alerts-down:nth-of-type(1)')
package_results_page.elements.create(:name => 'air rate card return slice alerts time', :by_css_locator => 'div.slice:nth-of-type(2) div.more-segments span.time')
package_results_page.elements.create(:name => 'air rate card return slice alerts legs equipment', :by_css_locator => 'div.slice:nth-of-type(2) span.alerts-down:nth-of-type(3)')
package_results_page.elements.create(:name => 'air rate card return slice alerts mileage', :by_css_locator => 'div.slice:nth-of-type(2) span.alerts-down:nth-of-type(4)')
package_results_page.elements.create(:name => 'air rate card return slice alerts legs food beverage service', :by_css_locator => 'div.slice:nth-of-type(2) span.alerts-down:nth-of-type(5)')
package_results_page.elements.create(:name => 'air rate card return slice logo 1 img', :by_css_locator => 'div.slice:nth-of-type(2) div.airline div.logo img')
package_results_page.elements.create(:name => 'air rate card return slice logo 2 img', :by_css_locator => 'div.slice:nth-of-type(2) div.airline-leg div.logo img')

#package_sp05_axpt3802_spec
#package_results_page.elements.create(:name => 'roundtrip flight details link', :by_css_locator => 'a.dp-show-details')
package_results_page.elements.create(:name => 'air rate card slice alerts connection', :by_css_locator => 'div.slice span.alerts-down:nth-of-type(6)')

#package_sp05_axpt3807_spec
package_results_page.elements.create(:name => 'hotel rate card show hotel highlights labels', :by_css_locator => 'div.dp-show-highlights span')
package_results_page.elements.create(:name => 'view hide roundtrip flight details labels', :by_css_locator => 'div.dp-show-details a')
package_results_page.elements.create(:name => 'hotel rate card dp hotel selected', :by_css_locator => 'li.col-card div.bg')
package_results_page.elements.create(:name => 'hotel rate card your room details label', :by_css_locator => 'div.your-room-details h2')
package_results_page.elements.create(:name => 'hotel rate card hotel first name best value', :by_css_locator => 'li.col-card:nth-of-type(1) span._jq-rate-card-name')
package_results_page.elements.create(:name => 'hotel rate card your dp hotel name selected', :by_css_locator => 'div.results-title span')
package_results_page.elements.create(:name => 'see all hotels button', :by_css_locator => 'input._jq-open-loading') 
package_results_page.elements.create(:name => 'hotel rate card your dp hotel selected img', :by_css_locator => 'div.hotel_image img') 
package_results_page.elements.create(:name => 'hotel rate card your dp hotel selected address', :by_css_locator => 'div.address') 
package_results_page.elements.create(:name => 'hotel rate card your dp hotel selected number of rooms', :by_css_locator => 'div.rooms') 
package_results_page.elements.create(:name => 'hotel rate card your dp hotel selected check in date', :by_css_locator => 'div.date-in span') 
package_results_page.elements.create(:name => 'hotel rate card your dp hotel selected check out date', :by_css_locator => 'div.date-out span') 
package_results_page.elements.create(:name => 'hotel rate card your dp hotel selected check in calendar icon', :by_css_locator => 'div.info div.date-in img') 
package_results_page.elements.create(:name => 'hotel rate card your dp hotel selected check out calendar icon', :by_css_locator => 'div.info div.date-out img') 
package_results_page.elements.create(:name => 'hotel rate card your dp hotel selected number of nights', :by_css_locator => 'div.info div.nights') 
package_results_page.elements.create(:name => 'hotel rate card your dp hotel selected room description', :by_css_locator => 'div.details span') 

#package_sp05_axpt3806_spec
package_results_page.elements.create(:name => 'hotel rate card cost text labels', :by_css_locator => 'li.col-card:nth-of-type(1) div.cost-text') 
package_results_page.elements.create(:name => 'hotel rate card currency booked separately', :by_css_locator => 'li.col-card:nth-of-type(1) div.row:nth-of-type(4) span.sup') 
package_results_page.elements.create(:name => 'hotel rate card currency package savings', :by_css_locator => 'li.col-card:nth-of-type(1) div.row:nth-of-type(4) span.sup') 
package_results_page.elements.create(:name => 'hotel rate card average per person', :by_css_locator => 'li.col-card:nth-of-type(1) div.price-table div.row:nth-of-type(2)') 
package_results_page.elements.create(:name => 'room 1 adults combobox', :by_css_locator => 'fieldset._jq-room-fieldset:nth-of-type(1) ol li#package_search_traveler_groups_adults_input.select a.selectBox span.selectBox-label') 
package_results_page.elements.create(:name => 'selection options adults 1 combobox', :by_css_locator => 'ul.selectBox-dropdown-menu:nth-of-type(4) li a')	
package_results_page.elements.create(:name => 'hotel rate card horizontal line', :by_css_locator => 'li.col-card:nth-of-type(1) div.horizontal-line')	

#package_sp05_axpt3801_spec
package_results_page.elements.create(:name => 'all hotel your flight rate card num tickets alert', :by_css_locator => 'li.flight-sol div.num-tickets')	
package_results_page.elements.create(:name => 'all flight rate card num tickets alerts', :by_css_locator => 'div.num-tickets')	

#package_sp05_axpt3803_spec
package_results_page.elements.create(:name => 'all flight matrix', :by_css_locator => 'div._js-matrix')	
package_results_page.elements.create(:name => 'all flight matrix rows', :by_css_locator => 'th.rowhead')	
package_results_page.elements.create(:name => 'all flight matrix top row airline names', :by_css_locator => 'div.matrix-cell div.name')	
package_results_page.elements.create(:name => 'all flight matrix top row airline logos', :by_css_locator => 'div.matrix-cell div.logo img')	
package_results_page.elements.create(:name => 'all flight rate card airline names', :by_css_locator => 'div.matrix-cell div.name')	
package_results_page.elements.create(:name => 'all flight rate card airline logos', :by_css_locator => 'div.airline div.logo img')	
package_results_page.elements.create(:name => 'all flight matrix ammounts', :by_css_locator => 'tr:nth-of-type(1) td.price span.ammount')	
package_results_page.elements.create(:name => 'all flight matrix slider', :by_css_locator => 'div.slider a.handle')	
package_results_page.elements.create(:name => 'all flight matrix airline columns', :by_css_locator => 'tr:nth-of-type(1) td.price div.matrix-cell')	
package_results_page.elements.create(:name => 'all flight matrix stop columns', :by_css_locator => 'tr th.rowhead div.matrix-cell div.cell-content')	
package_results_page.elements.create(:name => 'all flight baggage charges link', :by_css_locator => 'p.dp-fares-notice a._jq-baggage-charges-link')	
package_results_page.elements.create(:name => 'all flight taxes and fees link', :by_css_locator => 'p.dp-fares-notice a._jq-dp-fees-link')	
package_results_page.elements.create(:name => 'all flight baggage fees close button', :by_xpath_locator => '/html/body/div[14]/div/a/span')
package_results_page.elements.create(:name => 'all flight packages taxes and fees close button', :by_xpath_locator => '/html/body/div[6]/div[3]/div/button')
package_results_page.elements.create(:name => 'all flight baggage fees title', :by_css_locator => 'span#ui-dialog-title-7.ui-dialog-title')	
package_results_page.elements.create(:name => 'all flight packages taxes and fees title', :by_css_locator => 'span#ui-dialog-title-1.ui-dialog-title')	
package_results_page.elements.create(:name => 'all flight collapse expand button', :by_css_locator => 'div.collapse-button')	

# hotel_sp05_axpt2959_spec
hotel_disambiguation_page.elements.create(:name => 'disambiguation page title', :by_css_locator => 'div.column-content h2')	

# reg_sp6_hotel_script1_axpt4544_axpt4339_axpt4720_axpt512_spec
package_results_page.elements.create(:name => 'book this package buttons', :by_css_locator => 'li.col-card a.select-button')

# hotel_wk50_axpt1827_spec
hotel_results_page.elements.create(:name => 'number of results', :by_css_locator => 'span.matches span.total span.n')	
hotel_results_page.elements.create(:name => 'results hotel cards', :by_css_locator => 'div.col-card')	
hotel_results_page.elements.create(:name => 'loading more results element', :by_css_locator => 'div.hotel-searches-results div#HotelSearches_loading div.spinner-text span')	

# hotel_wk50_axpt2979_spec
hotel_results_page.elements.create(:name => 'hotel card titles', :by_css_locator => 'div.col-card * div.results-title')	

# reg_sp6_hotel_script1_axpt4544_axpt4339_axpt4720_axpt512_spec
hotel_results_page.elements.create(:name => 'hotel card flight and hotel costs upper labels', :by_css_locator => 'li.col-card:nth-of-type(1) div.third-result-column div.cost-text')	
hotel_results_page.elements.create(:name => 'hotel card book now pay later divs', :by_css_locator => 'div.col-card div.booknowpaylater')	
hotel_results_page.elements.create(:name => 'lowest rate guaranteed banner title', :by_css_locator => 'li.mr span.lowest_rate')	
hotel_results_page.elements.create(:name => 'lowest rate guaranteed banner points logos', :by_css_locator => 'li.mr span.hotel-searches span.points-img')	
hotel_results_page.elements.create(:name => 'hotel card pay points divs', :by_css_locator => 'div.col-card div.pay-points')

hotel_search_page.elements.create(:name => 'destination', :by_id_locator => 'hotel_search_location_name')
hotel_search_page.elements.create(:name => 'check-in date', :by_id_locator => 'hotel_search_start_date')
hotel_search_page.elements.create(:name => 'check-out date', :by_id_locator => 'hotel_search_end_date')
hotel_search_page.elements.create(:name => 'search hotels button', :by_name => 'commit')	
hotel_search_page.elements.create(:name => 'rooms combobox', :by_css_locator => 'li#hotel_search_num_rooms_input.select a.selectBox') 
hotel_search_page.elements.create(:name => 'rooms combobox selected option', :by_css_locator => 'li#hotel_search_num_rooms_input.select a.selectBox span.selectBox-label')               
hotel_search_page.elements.create(:name => 'adults combobox selected option 1', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_0_number_adults_input.select a.selectBox span.selectBox-label')        
hotel_search_page.elements.create(:name => 'adults combobox 1', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_0_number_adults_input.select a.selectBox')        
hotel_search_page.elements.create(:name => 'adults combobox 2', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_1_number_adults_input.select a.selectBox')    
hotel_search_page.elements.create(:name => 'adults combobox 3', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_2_number_adults_input.select a.selectBox')    
hotel_search_page.elements.create(:name => 'adults combobox 4', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_3_number_adults_input.select a.selectBox')    
hotel_search_page.elements.create(:name => 'children combobox 1', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_0_number_children_input.select a.selectBox')
hotel_search_page.elements.create(:name => 'children combobox 2', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_1_number_children_input.select a.selectBox')
hotel_search_page.elements.create(:name => 'children combobox 3', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_2_number_children_input.select a.selectBox')
hotel_search_page.elements.create(:name => 'children combobox 4', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_3_number_children_input.select a.selectBox')
hotel_search_page.elements.create(:name => 'room 1 - age of child combobox 1', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_0_child_ages_1_age_input.select a.selectBox')        
hotel_search_page.elements.create(:name => 'room 1 - age of child combobox 2', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_0_child_ages_2_age_input.select a.selectBox')        
hotel_search_page.elements.create(:name => 'room 1 - age of child combobox 3', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_0_child_ages_3_age_input.select a.selectBox')     
hotel_search_page.elements.create(:name => 'room 1 - age of child combobox 4', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_0_child_ages_4_age_input.select a.selectBox')     
hotel_search_page.elements.create(:name => 'room 1 - age of child combobox 5', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_0_child_ages_5_age_input.select a.selectBox')     
hotel_search_page.elements.create(:name => 'room 2 - age of child combobox 1', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_1_child_ages_1_age_input.select a.selectBox')        
hotel_search_page.elements.create(:name => 'room 2 - age of child combobox 2', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_1_child_ages_2_age_input.select a.selectBox')        
hotel_search_page.elements.create(:name => 'room 2 - age of child combobox 3', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_1_child_ages_3_age_input.select a.selectBox')     
hotel_search_page.elements.create(:name => 'room 2 - age of child combobox 4', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_1_child_ages_4_age_input.select a.selectBox')     
hotel_search_page.elements.create(:name => 'room 2 - age of child combobox 5', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_1_child_ages_5_age_input.select a.selectBox')     
hotel_search_page.elements.create(:name => 'room 3 - age of child combobox 1', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_2_child_ages_1_age_input.select a.selectBox')        
hotel_search_page.elements.create(:name => 'room 3 - age of child combobox 2', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_2_child_ages_2_age_input.select a.selectBox')        
hotel_search_page.elements.create(:name => 'room 3 - age of child combobox 3', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_2_child_ages_3_age_input.select a.selectBox')     
hotel_search_page.elements.create(:name => 'room 3 - age of child combobox 4', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_2_child_ages_4_age_input.select a.selectBox')     
hotel_search_page.elements.create(:name => 'room 3 - age of child combobox 5', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_2_child_ages_5_age_input.select a.selectBox')     
hotel_search_page.elements.create(:name => 'room 4 - age of child combobox 1', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_3_child_ages_1_age_input.select a.selectBox')        
hotel_search_page.elements.create(:name => 'room 4 - age of child combobox 2', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_3_child_ages_2_age_input.select a.selectBox')        
hotel_search_page.elements.create(:name => 'room 4 - age of child combobox 3', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_3_child_ages_3_age_input.select a.selectBox')     
hotel_search_page.elements.create(:name => 'room 4 - age of child combobox 4', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_3_child_ages_4_age_input.select a.selectBox')     
hotel_search_page.elements.create(:name => 'room 4 - age of child combobox 5', :by_css_locator => 'li#hotel_search_hotel_search_rooms_attributes_3_child_ages_5_age_input.select a.selectBox')     

# hotel_wk50_axpt2561_spec
hotel_results_page.elements.create(:name => 'sort by combobox', :by_css_locator => '#hotel_search_order_by_input.select a.selectBox')	
hotel_results_page.elements.create(:name => 'sort by combobox values', :by_css_locator => 'ul.selectBox-dropdown-menu:nth-of-type(30) li a')	
hotel_results_page.elements.create(:name => 'destination textbox', :by_id_locator => 'hotel_search_location_name')	
hotel_results_page.elements.create(:name => 'check-in date calendar', :by_id_locator => 'hotel_search_start_date')
hotel_results_page.elements.create(:name => 'check-out date calendar', :by_id_locator => 'hotel_search_end_date')	
hotel_results_page.elements.create(:name => 'room text link', :by_css_locator => 'form#summary-form.search-form li#hotel_guests.rooms-quantity span.selectBox-label')	
hotel_results_page.elements.create(:name => 'guest text link', :by_css_locator => 'form#summary-form.search-form li.total-guest a._js-total-guest-link')	
hotel_results_page.elements.create(:name => 'results hotel names', :by_css_locator => 'div.results-title')	
hotel_results_page.elements.create(:name => 'results hotel prices', :by_css_locator => 'div.big-price div.number')
hotel_results_page.elements.create(:name => 'first card star five', :by_css_locator => 'div.col-card:nth-of-type(1) div.blocksep div:nth-of-type(5)')
hotel_results_page.elements.create(:name => 'first card star four', :by_css_locator => 'div.col-card:nth-of-type(1) div.blocksep div:nth-of-type(4)')
hotel_results_page.elements.create(:name => 'first card star three', :by_css_locator => 'div.col-card:nth-of-type(1) div.blocksep div:nth-of-type(3)')
hotel_results_page.elements.create(:name => 'second card star five', :by_css_locator => 'div.col-card:nth-of-type(2) div.blocksep div:nth-of-type(5)')
hotel_results_page.elements.create(:name => 'second card star four', :by_css_locator => 'div.col-card:nth-of-type(2) div.blocksep div:nth-of-type(4)')
hotel_results_page.elements.create(:name => 'second card star three', :by_css_locator => 'div.col-card:nth-of-type(2) div.blocksep div:nth-of-type(3)')
hotel_results_page.elements.create(:name => 'third card star five', :by_css_locator => 'div.col-card:nth-of-type(3) div.blocksep div:nth-of-type(5)')
hotel_results_page.elements.create(:name => 'third card star four', :by_css_locator => 'div.col-card:nth-of-type(3) div.blocksep div:nth-of-type(4)')
hotel_results_page.elements.create(:name => 'third card star three', :by_css_locator => 'div.col-card:nth-of-type(3) div.blocksep div:nth-of-type(3)')

# hotel_wk52_axpt3252_spec
hotel_results_page.elements.create(:name => 'icon magnifying glass', :by_css_locator => 'div.col-card:nth-of-type(1) div.relative-q-m div.map-icon img')	
hotel_results_page.elements.create(:name => 'map image location hotel', :by_css_locator => 'div.col-card:nth-of-type(1) img.expanded')	
hotel_results_page.elements.create(:name => 'hide hotel highlights button', :by_css_locator => 'div.col-card:nth-of-type(1) span.minus img')	
hotel_results_page.elements.create(:name => 'show hotel highlights button', :by_css_locator => 'div.col-card:nth-of-type(1) span.plus img')	
hotel_results_page.elements.create(:name => 'update button', :by_css_locator => 'form#summary-form.search-form li.commit input.update')	
hotel_results_page.elements.create(:name => 'hotel card description div', :by_css_locator => 'div.col-card:nth-of-type(1) div.second-result-column div.expanded')	
hotel_results_page.elements.create(:name => 'hotel card more description link', :by_css_locator => 'div.col-card:nth-of-type(1) div.expanded a.more-links')	
hotel_description_page.elements.create(:name => 'back to search results link', :by_css_locator => 'div.go-back a')	
hotel_description_page.elements.create(:name => 'description tab', :by_css_locator => 'li.description a')	

# hotel_wk50_axpt3253_spec
hotel_results_page.elements.create(:name => 'hotel card login buttons', :by_css_locator => 'a.login')	

# hotel_wk02_axpt3763_spec
hotel_results_page.elements.create(:name => 'hotel card select button', :by_css_locator => 'div.col-card:nth-of-type(1) div.select-button a.select')	
hotel_description_page.elements.create(:name => 'rooms and rates tab', :by_css_locator => 'ul.detail-tabs li.rooms a')	
hotel_description_page.elements.create(:name => 'lowest rate guaranteed tab', :by_css_locator => '#low_rates.lowest_rate')
hotel_checkout_page.elements.create(:name => 'checkout title', :by_css_locator => 'div.column-content h1')
hotel_checkout_page.elements.create(:name => 'more details link', :by_css_locator => 'div.name a.underline')

# hotel_wk02_axpt3611_spec
hotel_results_page.elements.create(:name => 'hotel card more details link', :by_css_locator => 'div.col-card:nth-of-type(1) div.results-title a.more-links')	

# hotel_wk02_axpt3584_spec
hotel_description_page.elements.create(:name => 'results details lowest rates', :by_css_locator => 'div.second_detail_column div.prices')	
hotel_description_page.elements.create(:name => 'room combobox selection options', :by_css_locator => 'ul.selectBox-dropdown-menu:nth-of-type(29) li a')	
hotel_description_page.elements.create(:name => 'room combobox', :by_css_locator => 'li#hotel_search_name_filter_input.select span.selectBox-label')	
hotel_description_page.elements.create(:name => 'lowest rate guaranteed results detail cars', :by_css_locator => 'div#tabs-low_rates.ui-tabs-panel div.detail_card')	
hotel_description_page.elements.create(:name => 'booking the selected room error message', :by_css_locator => 'div#top.two-columns div.error-wrapper')	
hotel_description_page.elements.create(:name => 'number of days error message', :by_css_locator => 'div#top.two-columns ul.errors li')
hotel_description_page.elements.create(:name => 'book button', :by_css_locator => 'div.detail_card:nth-of-type(1) div.bg div.third_detail_column a.book')	
hotel_description_page.elements.create(:name => 'description room details label', :by_css_locator => 'div.detail_card:nth-of-type(2) p')	
hotel_description_page.elements.create(:name => 'room details label', :by_css_locator => 'div.detail_card:nth-of-type(2) div.bg div.first_detail_column span.black')	
hotel_description_page.elements.create(:name => 'update button', :by_css_locator => 'input.update')	
hotel_description_page.elements.create(:name => 'check-in date calendar', :by_id_locator => 'hotel_search_start_date')
hotel_description_page.elements.create(:name => 'check-out date calendar', :by_id_locator => 'hotel_search_end_date')

# reg_sp5_hotel_script1_axpt812_axpt820_axpt329_spec.rb
hotel_search_page.elements.create(:name => 'by address option', :by_css_locator => 'label.ui-radio:nth-of-type(2)')
hotel_search_page.elements.create(:name => 'by city or landmark option', :by_css_locator => 'label.ui-radio:nth-of-type(1)')
hotel_search_page.elements.create(:name => 'search street address textbox', :by_css_locator => '#hotel_search_street_address.input-address')
hotel_search_page.elements.create(:name => 'search city textbox', :by_css_locator => '#hotel_search_city.input-search')
hotel_search_page.elements.create(:name => 'search zip postal code textbox', :by_css_locator => '#hotel_search_zip_code.input-zip')
hotel_search_page.elements.create(:name => 'search country combobox', :by_css_locator => '#hotel_search_country_input.select a.selectBox')
hotel_search_page.elements.create(:name => 'search state combobox', :by_css_locator => 'div.state-wrapper a.selectBox')
hotel_search_page.elements.create(:name => 'search error messages', :by_css_locator => 'div#errorExplanation div.error-wrapper ul.errors li')
hotel_results_page.elements.create(:name => 'start a new search link', :by_css_locator => 'li.last a')	
hotel_disambiguation_page.elements.create(:name => 'disambiguation first selection in all options', :by_css_locator => 'li.choice:nth-of-type(1) label.ui-radio')	
hotel_disambiguation_page.elements.create(:name => 'search hotels button', :by_css_locator => 'input.disambiguation-button')	
hotel_results_page.elements.create(:name => 'promo get points', :by_css_locator => 'div.promo-ads div.promo-get-points')
hotel_results_page.elements.create(:name => 'promo pay points', :by_css_locator => 'div.promo-ads div.promo-pay-points')
hotel_results_page.elements.create(:name => 'promo competitive rates', :by_css_locator => 'div.promo-ads div.promo-competitive-rates')
hotel_results_page.elements.create(:name => 'interstitial main text label', :by_css_locator => 'div#_iz div.promo-section div.page-width h2')

# reg_sp5_hotel_script1_axpt982_axpt977_axpt976_axpt975_axpt923_axpt1042_spec.rb
hotel_results_page.elements.create(:name => 'hotel card more details links', :by_css_locator => 'div.col-card div.results-title a.more-links')	
hotel_description_page.elements.create(:name => 'see nightly rates link', :by_css_locator => 'span.nightly_rates a.underline')
hotel_description_page.elements.create(:name => 'nightly rates tab text', :by_css_locator => 'div.upper-right span.left-text')
hotel_description_page.elements.create(:name => 'room restrictions and cancellation policy link', :by_css_locator => '#tabs-low_rates div.detail_results div.conditions a')
hotel_description_page.elements.create(:name => 'dialog restrictions and cancellation policy title', :by_css_locator => 'span#ui-dialog-title-2.ui-dialog-title')
hotel_description_page.elements.create(:name => 'map tab', :by_css_locator => 'ul.detail-tabs li.map a')
hotel_description_page.elements.create(:name => 'map view 1 img', :by_css_locator => 'div.inside div.hotel-map img')
hotel_description_page.elements.create(:name => 'map view 2 img', :by_css_locator => 'div.hotel-view img')
hotel_description_page.elements.create(:name => 'dialog restrictions and ancellation policy close button', :by_css_locator => 'button.ui-button')
hotel_description_page.elements.create(:name => 'nightly rates tab close button', :by_css_locator => 'span.nightly-close')
hotel_description_page.elements.create(:name => 'description tab', :by_css_locator => 'li.description a')
hotel_description_page.elements.create(:name => 'description tab hotel name title', :by_css_locator => 'div.first-block div.name')
hotel_description_page.elements.create(:name => 'description tab hotel description general', :by_css_locator => 'div.hotel-description-general')
hotel_description_page.elements.create(:name => 'hotel name title', :by_css_locator => 'div.column-content div.name')
hotel_description_page.elements.create(:name => 'amenities tab', :by_css_locator => 'li.amenities a')
hotel_description_page.elements.create(:name => 'list of amenities', :by_css_locator => 'div#tabs-amenities.ui-tabs-panel div.inside')
hotel_description_page.elements.create(:name => 'slides control view photos', :by_css_locator => 'div.slides_control a img.slide-me')
hotel_description_page.elements.create(:name => 'carousel photo reviews buttons', :by_css_locator => 'ul.pagination li a')
hotel_description_page.elements.create(:name => 'pagination reviews button', :by_css_locator => 'ul.pagination li.current')
hotel_results_page.elements.create(:name => 'hotel card photos img', :by_css_locator => 'div.hotel_image img')
hotel_checkout_page.elements.create(:name => 'review your hotel booking label', :by_css_locator => 'div.review_content div.title')
hotel_checkout_page.elements.create(:name => 'step 1 checkout label', :by_css_locator => 'div.steps span.step-1')
hotel_checkout_page.elements.create(:name => 'step 2 information label', :by_css_locator => 'div.steps span.step-2')

# reg_sp7_hotel_script1_axpt513_axpt4544_axpt1716_axpt909_axpt910_axpt911_spec.rb
hotel_search_page.elements.create(:name => 'login in button', :by_css_locator => 'a.login-button')
hotel_results_page.elements.create(:name => 'hotel card lowest rate question buttons', :by_css_locator => 'div.lowest-rate-text a.question')
hotel_results_page.elements.create(:name => 'hotel card special offer question buttons', :by_css_locator => 'a.question-special-offer')
hotel_results_page.elements.create(:name => 'hotel card show hotel highlights buttons', :by_css_locator => 'div.show-highlights')
hotel_results_page.elements.create(:name => 'hotel card promo more links', :by_css_locator => 'div.promo a.more-links')
hotel_results_page.elements.create(:name => 'hotel card description text divs', :by_css_locator => 'div.blocksep div.black')	
hotel_results_page.elements.create(:name => 'overlay special offer for you title 1', :by_css_locator => 'span#ui-dialog-title-_jq-cent-plat-promo-dialog.ui-dialog-title')	
hotel_results_page.elements.create(:name => 'overlay special offer for you title 2', :by_css_locator => 'span#ui-dialog-title-_jq-special-promo-dialog.ui-dialog-title')	
hotel_results_page.elements.create(:name => 'hotel card average nightly rate labels', :by_css_locator => 'div.italic-comment-text')	
hotel_results_page.elements.create(:name => 'hotel card price number labels', :by_css_locator => 'div.big-price div.number')	
hotel_results_page.elements.create(:name => 'sort by combobox', :by_css_locator => '#hotel_search_order_by_input.select a.selectBox')	
hotel_results_page.elements.create(:name => 'sort by combobox values', :by_css_locator => 'ul.selectBox-dropdown-menu:nth-of-type(30) li a')  
hotel_results_page.elements.create(:name => 'hotel card price currencies', :by_css_locator => 'div.prices div.big-price div.super')  
hotel_results_page.elements.create(:name => 'map view tab', :by_css_locator => 'li.ui-state-default:nth-of-type(2)')  
hotel_results_page.elements.create(:name => 'plot location label', :by_css_locator => 'div#plot-location div.bold')  
hotel_results_page.elements.create(:name => 'map pin number 2', :by_xpath_locator => '/html/body/div[2]/div/div/div[10]/div/div/div[3]/div/div/div/div/div[4]/div[3]')
hotel_results_page.elements.create(:name => 'map pin number 1', :by_xpath_locator => '/html/body/div[2]/div/div/div[10]/div/div/div[3]/div/div/div/div/div[4]/div[2]')
hotel_results_page.elements.create(:name => 'map view detail box 2', :by_xpath_locator => '/html/body/div[2]/div/div/div[10]/div/div/div[3]/div/div/div/div/div[7]/div[2]/div[12]')
hotel_results_page.elements.create(:name => 'map view detail box 1', :by_xpath_locator => '/html/body/div[2]/div/div/div[10]/div/div/div[3]/div/div/div/div/div[7]/div[2]/div[12]')
hotel_results_page.elements.create(:name => 'map view detail box 1 close button', :by_xpath_locator => '/html/body/div[2]/div/div/div[10]/div/div/div[3]/div/div/div/div/div[7]/div[2]/div[13]/div')
hotel_results_page.elements.create(:name => 'map view detail box 1 more details link', :by_css_locator => '#map div div div div div div div div.hidden-info-window div.name span._jq-more-link a.more-links')
hotel_results_page.elements.create(:name => 'plot location quest button', :by_css_locator => 'a#_jq-plot-location-dialog-button.quest-mark-img')
hotel_results_page.elements.create(:name => 'overlay plot location title', :by_css_locator => 'span#ui-dialog-title-_jq-plot-location-dialog.ui-dialog-title')
hotel_results_page.elements.create(:name => 'overlay plot location close button', :by_xpath_locator => '/html/body/div[16]/div[3]/div/button')
hotel_results_page.elements.create(:name => 'entered location alert error', :by_css_locator => 'div#plot-location div.error-wrapper')
hotel_results_page.elements.create(:name => 'plot location textbox', :by_css_locator => '#plot-location-input.ui-autocomplete-input')
hotel_results_page.elements.create(:name => 'plot location delete marker icon', :by_css_locator => 'a#plot-location-glass.plot-location-delete-marker')
hotel_results_page.elements.create(:name => 'plot location glass icon', :by_css_locator => 'a#plot-location-glass.plot-location-search')




car_page.elements.create(:name => 'dropoff same as pickup', :by_id_locator => 'car_search_rental_type_0')
car_page.elements.create(:name => 'dropoff same as pickup label', :by_css_locator => 'li#car_search_rental_type_input fieldset.choices li.choice:nth-of-type(1) label.ui-radio')
car_page.elements.create(:name => 'different dropoff location', :by_id_locator => 'car_search_rental_type_1')
car_page.elements.create(:name => 'different dropoff location label', :by_css_locator => 'li#car_search_rental_type_input fieldset.choices li.choice:nth-of-type(2) label.ui-radio')
car_page.elements.create(:name => 'pickup city textbox', :by_id_locator => 'pick_up')
car_page.elements.create(:name => 'dropoff city textbox', :by_id_locator => 'drop_off')
car_page.elements.create(:name => 'pickup dropoff city textbox', :by_id_locator => 'pick_up')
car_page.elements.create(:name => 'pickup date textbox', :by_id_locator => 'car_search_start_date')
car_page.elements.create(:name => 'pickup time combobox', :by_id_locator => 'car_search_start_time')
car_page.elements.create(:name => 'dropoff date textbox', :by_id_locator => 'car_search_end_date')
car_page.elements.create(:name => 'dropoff time combobox', :by_id_locator => 'car_search_end_time')
car_page.elements.create(:name => 'car search form', :by_id_locator => 'new_car_search')

#car_wk50_axpt2232_spec
car_page.elements.create(:name => 'pickup country combobox', :by_css_locator => 'li#car_search_pickup_location_address_country_input.select a.selectBox')
car_page.elements.create(:name => 'pickup address', :by_id_locator => 'car_search_pickup_location_address_street')
car_page.elements.create(:name => 'pickup city address', :by_id_locator => 'car_search_pickup_location_address_city')
car_page.elements.create(:name => 'pickup state combobox', :by_css_locator => 'li#car_search_pickup_location_address_state_input.select a.selectBox')
car_page.elements.create(:name => 'pickup zip', :by_id_locator => 'car_search_pickup_location_address_zip')

car_page.elements.create(:name => 'dropoff country combobox', :by_css_locator => 'li#car_search_dropoff_location_address_country_input.select a.selectBox')
car_page.elements.create(:name => 'dropoff address', :by_id_locator => 'car_search_dropoff_location_address_street')
car_page.elements.create(:name => 'dropoff city address', :by_id_locator => 'car_search_dropoff_location_address_city')
car_page.elements.create(:name => 'dropoff state combobox', :by_css_locator => 'li#car_search_dropoff_location_address_state_input.select a.selectBox')
car_page.elements.create(:name => 'dropoff zip', :by_id_locator => 'car_search_dropoff_location_address_zip')
car_page.elements.create(:name => 'pickup input options', :by_id_locator => 'car_search_pickup_use_address_input')
car_page.elements.create(:name => 'dropoff input options', :by_id_locator => 'car_search_dropoff_use_address_input')
car_page.elements.create(:name => 'car rental type option', :by_id_locator => 'car_search_rental_type_input')
car_page.elements.create(:name => 'pickup subtitle', :by_css_locator => 'fieldset#pickup_params.radio-buttons ol legend')
car_page.elements.create(:name => 'dropoff location same as pickup input', :by_id_locator => 'car_search_rental_type_0')
car_page.elements.create(:name => 'pickup search by city or airport input', :by_id_locator => 'car_search_pickup_use_address_0')
car_page.elements.create(:name => 'dropoff search by city or airport input', :by_id_locator => 'car_search_dropoff_use_address_0')
car_page.elements.create(:name => 'pickup search by address input', :by_id_locator => 'car_search_pickup_use_address_1')
car_page.elements.create(:name => 'dropoff search by address input', :by_id_locator => 'car_search_dropoff_use_address_1')
car_page.elements.create(:name => 'pickup search by address option label', :by_css_locator => 'li#car_search_pickup_use_address_input.radio label.ui-radio[for=car_search_pickup_use_address_1]')
car_page.elements.create(:name => 'dropoff search by address option label', :by_css_locator => 'li#car_search_dropoff_use_address_input.radio label.ui-radio[for=car_search_dropoff_use_address_1]')
car_page.elements.create(:name => 'pickup search city airport option label', :by_css_locator => 'li#car_search_pickup_use_address_input.radio label.ui-radio[for=car_search_pickup_use_address_0]')
car_page.elements.create(:name => 'dropoff search city airport option label', :by_css_locator => 'li#car_search_dropoff_use_address_input.radio label.ui-radio[for=car_search_dropoff_use_address_0]')

car_page.elements.create(:name => 'car rental company combobox', :by_css_locator => 'li#car_search_vendor_code_filters_input.select a.selectBox')
car_page.elements.create(:name => 'car rental company combobox arrow', :by_css_locator => 'li#car_search_vendor_code_filters_input.select a.selectBox span.selectBox-arrow')
car_page.elements.create(:name => 'discount code textbox', :by_id_locator => 'car_search_promotion_code')
car_page.elements.create(:name => 'car type combobox', :by_css_locator => 'li#car_search_car_type_input.select a.selectBox')
car_page.elements.create(:name => 'car AC combobox', :by_css_locator => 'li#car_search_air_conditioning_input.select a.selectBox')
car_page.elements.create(:name => 'car transmission combobox', :by_css_locator => 'li#car_search_transmission_type_input.select a.selectBox')
car_page.elements.create(:name => 'search cars button', :by_css_locator => 'form.search-form input.buttoncommit')
car_page.elements.create(:name => 'ac select', :by_id_locator => 'car_search_air_conditioning_input')
car_page.elements.create(:name => 'transmission select', :by_id_locator => 'car_search_transmission_type_input')
car_page.elements.create(:name => 'car pickup date calendar', :by_id_locator => 'ui-datepicker-div')
car_page.elements.create(:name => 'car dropoff date calendar', :by_id_locator => 'ui-datepicker-div')
car_page.elements.create(:name => 'car errors', :by_css_locator => 'div.error-handling div#errorExplanation ul.errors')
car_page.elements.create(:name => 'car disambiguation form', :by_css_locator => 'form.car-disambiguation-form')
car_page.elements.create(:name => 'disambiguos options', :by_css_locator => 'li#car_search_pickup_location_input.radio fieldset.choices ol.choices-group')
car_page.elements.create(:name => 'search disambiguation button', :by_css_locator => 'fieldset.search-buttons * input.disambiguation-button')
car_page.elements.create(:name => 'disambiguation first choice', :by_css_locator => 'li#car_search_pickup_location_input.radio * li.choice label.ui-radio')
car_page.elements.create(:name => 'disambiguation back link', :by_css_locator => 'div.back-home a')
car_page.elements.create(:name => 'disambiguation search error', :by_css_locator => 'div.error-handling ol.errors li')
car_page.elements.create(:name => 'car search rental option', :by_id_locator => 'car_search_rental_type_input')
# Interstitial
car_page.elements.create(:name => 'interstitial graph', :by_id_locator => 'spinner')
car_page.elements.create(:name => 'promo get points', :by_css_locator => 'div.promo-ads div.promo-get-points')
car_page.elements.create(:name => 'promo pay points', :by_css_locator => 'div.promo-ads div.promo-pay-points')
car_page.elements.create(:name => 'promo competitive rates', :by_css_locator => 'div.promo-ads div.promo-competitive-rates')
# car_wk02_axpt3516_spec
car_page.elements.create(:name => 'airports worldwide pickup link', :by_css_locator => 'fieldset#pickup_params a._jq-airport-picker-link')
car_page.elements.create(:name => 'airports worldwide dropoff link', :by_css_locator => 'fieldset#dropoff_params a._jq-airport-picker-link')
car_page.elements.create(:name => 'airports worldwide overlay title', :by_id_locator => 'ui-dialog-title-_jq-airport-dialog')
car_page.elements.create(:name => 'airports worldwide departure link', :by_css_locator => 'li#car_search_pickup_use_address_input * a._jq-airport-picker-link')
car_page.elements.create(:name => 'airports worldwide overlay icon close button', :by_css_locator => 'div.ui-dialog[aria-labelledby="ui-dialog-title-_jq-airport-dialog"] span.ui-icon')
car_page.elements.create(:name => 'airports worldwide overlay us airports tab', :by_id_locator => 'link-us')
car_page.elements.create(:name => 'airports worldwide overlay canadian airports tab', :by_id_locator => 'link-canadian')
car_page.elements.create(:name => 'airports worldwide overlay intl airports tab', :by_id_locator => 'link-international')
car_page.elements.create(:name => 'airports worldwide overlay us airports abecedary letter link', :by_css_locator => 'div.airport_popup div#us._jq-airports-list-section p.letters-links a[href="#USM"]')
car_page.elements.create(:name => 'airports worldwide overlay intl airports abecedary letter link', :by_css_locator => 'div.airport_popup div#international._jq-airports-list-section p.letters-links a[href="#INTM"]')
car_page.elements.create(:name => 'airports worldwide overlay us airports code link', :by_id_locator => 'MCN')
car_page.elements.create(:name => 'airports worldwide overlay canadian airports code link', :by_id_locator => 'YYC')
car_page.elements.create(:name => 'airports worldwide overlay intl airports code link', :by_id_locator => 'MST')
car_page.elements.create(:name => 'airports worldwide arrival link', :by_css_locator => 'li#car_search_dropoff_use_address_input * a._jq-airport-picker-link')
# car_page.elements.create(:name => 'airports worldwide overlay us airports abecedary letter title', :by_id_locator => 'USA')
car_page.elements.create(:name => 'airports worldwide overlay us airports back to top link', :by_css_locator => 'div.airport_popup div#us._jq-airports-list-section p.returntoTop:nth-of-type(12) a')
car_page.elements.create(:name => 'airports worldwide overlay intl airports back to top link', :by_css_locator => 'div.airport_popup div#international._jq-airports-list-section p.returntoTop:nth-of-type(12) a')
# car_page.elements.create(:name => 'airports worldwide overlay intl airports abecedary letter title', :by_id_locator => 'INTA')
car_page.elements.create(:name => 'airports worldwide overlay us scrollpane', :by_css_locator => 'div.airport_popup div#us._jq-airports-list-section div._jq-scrollpane div.jspContainer div.jspVerticalBar div.jspTrack div.jspDrag')
car_page.elements.create(:name => 'airports worldwide overlay intl scrollpane', :by_css_locator => 'div.jspVerticalBar * div.jspDrag')

## Car Results
car_results_page.elements.create(:name => 'start a new search link', :by_css_locator => 'div.new-search a')
car_results_page.elements.create(:name => 'car results error message', :by_css_locator => 'ul.errors li')
car_results_page.elements.create(:name => 'car results generic error message', :text => 'error-handling')
car_results_page.elements.create(:name => 'car results invalid price', :by_css_locator => 'div.invalid')
car_results_page.elements.create(:name => 'car results companies', :by_css_locator => 'div.name')
car_results_page.elements.create(:name => 'car results total price in card', :by_css_locator => 'ul.car-cards * div.price-stuff div.italic-comment-text')
car_results_page.elements.create(:name => 'car results currency in card', :by_css_locator => 'li.car-card * div.prices div.big-price span.super')
car_results_page.elements.create(:name => 'car results old price in card', :by_css_locator => 'ul.car-cards * div.old-price')
car_results_page.elements.create(:name => 'car results update button', :by_css_locator => 'form * li.commit input.button-update')
car_results_page.elements.create(:name => 'pickup date textbox', :by_id_locator => 'car_search_start_date')
car_results_page.elements.create(:name => 'pickup time combobox', :by_id_locator => 'car_search_start_time')
car_results_page.elements.create(:name => 'dropoff date textbox', :by_id_locator => 'car_search_end_date')
car_results_page.elements.create(:name => 'dropoff time combobox', :by_id_locator => 'car_search_end_time')
car_results_page.elements.create(:name => 'car results select first car', :by_css_locator => 'form#new_car_0.formtastic * input.buttoncommit')
car_results_page.elements.create(:name => 'car results car type first cell', :by_css_locator => 'table._js-content-matrix tbody tr th')
#car_wk50_axpt3071_spec
car_results_page.elements.create(:name => 'car results rental policies link', :by_css_locator => 'div._js-matrix p.fares-notice a._jq-rental-policies-link')
car_results_page.elements.create(:name => 'car results rental policies dialog', :by_css_locator => 'div.ui-dialog')
car_results_page.elements.create(:name => 'car results rental policies dialog close btn', :by_css_locator => 'div.ui-dialog * button.ui-button')
car_results_page.elements.create(:name => 'car results rental policies dialog close cross', :by_css_locator => 'a.ui-dialog-titlebar-close span.ui-icon')
#car_wk52_axpt3109_spec
car_results_page.elements.create(:name => 'strikethrough on total matrix', :by_css_locator => 'table._js-content-matrix tbody tr td.price * div.invalid')
#car_wk52_axpt3075_spec
car_results_page.elements.create(:name => 'car matrix', :by_css_locator => 'div.quick-compare * div.car-matrix')
car_results_page.elements.create(:name => 'matrix cars first image source file', :by_css_locator => 'th:nth-of-type(2) div.td-wrapper img')
car_results_page.elements.create(:name => 'cars cards imgs', :by_css_locator => 'div.banner img')
car_results_page.elements.create(:name => 'matrix cars element highlighted', :by_css_locator => 'th.highlight')
car_results_page.elements.create(:name => 'matrix cars first car class link', :by_css_locator => 'tbody:nth-of-type(1) tr:nth-of-type(1) th div.td-wrapper a')
car_results_page.elements.create(:name => 'cars reset button', :by_css_locator => 'div.car-matrix * div.reset-button')
#car_sp05_axpt3429_spec
car_results_page.elements.create(:name => 'car cars images', :by_css_locator => 'li.car-card * div.logo img')
car_results_page.elements.create(:name => 'car first card data', :by_css_locator => 'li.car-card:nth-of-type(1) * div.car-data p.locations')
car_results_page.elements.create(:name => 'car first card details doors', :by_css_locator => 'li.car-card:nth-of-type(1) * ul.custom-details li:nth-of-type(1) span')
car_results_page.elements.create(:name => 'car first card details passengers', :by_css_locator => 'li.car-card:nth-of-type(1) * ul.custom-details li:nth-of-type(2) span')
car_results_page.elements.create(:name => 'car first card details luggage', :by_css_locator => 'li.car-card:nth-of-type(1) * ul.custom-details li:nth-of-type(3) span')
car_results_page.elements.create(:name => 'car first card details pick up location', :by_css_locator => 'li.car-card:nth-of-type(1) * div.car-data:nth-of-type(7) p.locations')
car_results_page.elements.create(:name => 'car first card details drop off location', :by_css_locator => 'li.car-card:nth-of-type(1) * div.car-data:nth-of-type(8) p.locations')
#reg_sp5_car_script1_axpt1157_axpt1213_spec
car_results_page.elements.create(:name => 'car search pickup location textbox', :by_id_locator => 'car_search_pickup_location')
car_results_page.elements.create(:name => 'car search dropoff location textbox', :by_id_locator => 'car_search_dropoff_location')
car_results_page.elements.create(:name => 'car matrix vendors images', :by_css_locator => 'div.td-wrapper img')
car_results_page.elements.create(:name => 'car select second car advantage vendor', :by_css_locator => 'form#new_car_41.formtastic * input.buttoncommit')
#reg_sp6_car_script1_axpt3486_spec
car_results_page.elements.create(:name => 'car results cards', :by_css_locator => 'ul.car-cards li.car-card')
#car_wk02_axpt3136_spec/reg_sp6_car_script1_axpt3486_spec/reg_sp6_car_script1_axpt3865_spec
car_results_page.elements.create(:name => 'car results select buttons', :by_css_locator => 'li.commit input.buttoncommit')
#car_wk02_axpt3136_spec/reg_sp6_car_script1_axpt3486_spec
car_results_page.elements.create(:name => 'car results matches text', :by_css_locator => 'div.page-width div.number-results')
#reg_sp6_car_script1_axpt323_spec
car_results_page.elements.create(:name => 'car loggin button', :by_css_locator => 'a.login-button')

## Car selected
car_selected_page.elements.create(:name => 'change car link', :by_css_locator => 'div#_iz div.page-content * div.change-car-link a')
car_selected_page.elements.create(:name => 'review your car label', :by_css_locator => 'div.car-checkout * div.banner h2')
#car_wk02_axpt3661_spec
car_selected_page.elements.create(:name => 'progress bar help text label', :by_class_locator => 'help-text')
car_selected_page.elements.create(:name => 'help with this page link', :by_link_text_locator => 'Help with this page')
#car_wk02_axpt3136_spec
car_results_page.elements.create(:name => 'car results car type titles', :by_css_locator => 'div.left-content div.car-data ul.car-summary li.first')
car_results_page.elements.create(:name => 'car matrix column car types links', :by_css_locator => 'tbody tr th div.td-wrapper a')
car_results_page.elements.create(:name => 'car matrix head car rental company links', :by_css_locator => 'thead tr th div.td-wrapper')
car_results_page.elements.create(:name => 'car results first banner rental company img', :by_css_locator => "form#new_car_0.formtastic div.banner img")
car_results_page.elements.create(:name => 'car matrix first cells prices', :by_css_locator => 'td.price:nth-of-type(1) div.td-wrapper')
car_selected_page.elements.create(:name => 'estimated cost number', :by_css_locator => 'div.estimated-cost span.number')
car_results_page.elements.create(:name => 'car matrix first banner cell img', :by_css_locator => 'th.highlight div.td-wrapper img')
car_selected_page.elements.create(:name => 'car selected banner rental company img', :by_css_locator => 'div.banner div.wrapper img')
car_selected_page.elements.create(:name => 'change your car button', :by_css_locator => 'div.change-car-link a')
#car_sp05_axpt3197_spec
car_selected_page.elements.create(:name => 'charges and restrictions car title', :by_css_locator => 'div.charges-restrictions div.title h4')
car_selected_page.elements.create(:name => 'car rental rules link', :by_css_locator => 'a._jq-car-rental-rules-link')
car_selected_page.elements.create(:name => 'car gas charges link', :by_css_locator => 'a._jq-car-gas-charges-link')
car_selected_page.elements.create(:name => 'car additional costs link', :by_css_locator => 'a._jq-car-aditional-costs-link')
car_selected_page.elements.create(:name => 'car overlay rental rules title', :by_id_locator => 'ui-dialog-title-_jq-rental-rules-dialog')
car_selected_page.elements.create(:name => 'car overlay rental rules categories', :by_css_locator => 'li._jq-car-rental-rule h4 a')
car_selected_page.elements.create(:name => 'car overlay rental rules close button', :by_css_locator => 'div.ui-dialog[aria-labelledby="ui-dialog-title-_jq-rental-rules-dialog"] * button.ui-button span.ui-button-text')
car_selected_page.elements.create(:name => 'car overlay rental rules categories expanded', :by_css_locator => 'li._jq-car-rental-rule div.text[style=""]')
car_selected_page.elements.create(:name => 'car overlay gas charges title', :by_id_locator => 'ui-dialog-title-_jq-refuel-policy-dialog')
car_selected_page.elements.create(:name => 'car overlay gas charges close button', :by_css_locator => 'div.ui-dialog[aria-labelledby="ui-dialog-title-_jq-refuel-policy-dialog"] * button.ui-button span.ui-button-text')
car_selected_page.elements.create(:name => 'car overlay aditional costs title', :by_id_locator => 'ui-dialog-title-_jq-aditional-costs-dialog')
car_selected_page.elements.create(:name => 'car overlay aditional costs button', :by_css_locator => 'div.ui-dialog[aria-labelledby="ui-dialog-title-_jq-aditional-costs-dialog"] * button.ui-button span.ui-button-text')
car_selected_page.elements.create(:name => 'car overlay aditional costs items', :by_css_locator => 'div.right')
#car_sp05_axpt1206_spec
car_selected_page.elements.create(:name => 'car checkout crumb', :by_css_locator => 'div.car-checkout-head div.review span:nth-of-type(2)')
car_selected_page.elements.create(:name => 'car arrow crumb', :by_css_locator => 'div.review img')
car_selected_page.elements.create(:name => 'car confirmation crumb', :by_class_locator => 'confirmation')
#car_sp05_axpt1204_spec
car_selected_page.elements.create(:name => 'taxes and fee dialog close icon', :by_css_locator => 'a.ui-dialog-titlebar-close span.ui-icon')
car_selected_page.elements.create(:name => 'car taxes fees number', :by_css_locator => 'div.rate-detail:nth-of-type(2) span.number')
car_selected_page.elements.create(:name => 'taxes and fee link', :by_css_locator => 'span._jq-car-taxes-fees-link')
car_selected_page.elements.create(:name => 'taxes and fee dialog', :by_id_locator => 'ui-dialog-title-_jq-fees-dialog')
car_selected_page.elements.create(:name => 'car taxes and fees currency sign', :by_css_locator => 'div.rate-detail:nth-of-type(2) span.super')
car_selected_page.elements.create(:name => 'car taxes and fees numbers', :by_css_locator => 'div.prices')
#car_sp05_axpt3429_spec
car_selected_page.elements.create(:name => 'car type and length rental title', :by_css_locator => 'div.wrapper span')
car_selected_page.elements.create(:name => 'car selected image', :by_css_locator => 'div.car-checkout * div.logo img')
car_selected_page.elements.create(:name => 'car book now pay later title banner', :by_css_locator => 'div.logo div.title')
car_selected_page.elements.create(:name => 'car data locations', :by_css_locator => 'div.car-checkout * p.locations')
car_selected_page.elements.create(:name => 'car data summary texts', :by_css_locator => 'ul.car-summary li')
car_selected_page.elements.create(:name => 'car data pick up location text', :by_css_locator => 'div.car-checkout * div.car-data:nth-of-type(5) p.locations')
car_selected_page.elements.create(:name => 'car data drop off location text', :by_css_locator => 'div.car-checkout * div.car-data:nth-of-type(6) p.locations')
car_selected_page.elements.create(:name => 'car exclusive travel benefit section', :by_class_locator => 'benefits')
car_selected_page.elements.create(:name => 'car rate details texts', :by_css_locator => 'div.rate-detail span.description')
car_selected_page.elements.create(:name => 'car rate details numbers', :by_css_locator => 'div.rate-detail span.number')
car_selected_page.elements.create(:name => 'car total cost currency sign', :by_css_locator => 'div.estimated-cost span.super')
car_selected_page.elements.create(:name => 'car data doors number', :by_css_locator => 'div.car-checkout * ul.custom-details li:nth-of-type(1) span')
car_selected_page.elements.create(:name => 'car data passengers number', :by_css_locator => 'div.car-checkout * ul.custom-details li:nth-of-type(2) span')
car_selected_page.elements.create(:name => 'car data luggage number', :by_css_locator => 'div.car-checkout * ul.custom-details li:nth-of-type(3) span')
#car_sp05_axpt3429_spec, car_sp05_axpt3769_spec
car_selected_page.elements.create(:name => 'car data suttle info link', :by_css_locator => 'a._jq-shuttle-information-link')
car_selected_page.elements.create(:name => 'car data pick up data location hour operation link', :by_css_locator => 'div.car-data:nth-of-type(5) p.locations a.hours-of-operation')
car_selected_page.elements.create(:name => 'car data drop off location hour operation link', :by_css_locator => 'div.car-data:nth-of-type(6) p.locations a.hours-of-operation')
car_selected_page.elements.create(:name => 'car data suttle information overlay title', :by_id_locator => 'ui-dialog-title-_jq-shuttle-information-dialog')                                                                                                           
car_selected_page.elements.create(:name => 'car data suttle information overlay close button', :by_css_locator => 'div.ui-dialog[aria-labelledby="ui-dialog-title-_jq-shuttle-information-dialog"] * button.ui-button span.ui-button-text')
car_selected_page.elements.create(:name => 'car data pick up location hours of operation overlay title', :by_id_locator => 'ui-dialog-title-_jq-pick-up-hours-of-operation-dialog')
car_selected_page.elements.create(:name => 'car data pick up location hours of operation overlay close button', :by_css_locator => 'div.ui-dialog[aria-labelledby="ui-dialog-title-_jq-pick-up-hours-of-operation-dialog"] * button.ui-button span.ui-button-text')
car_selected_page.elements.create(:name => 'car data drop off location hours of operation overlay title', :by_id_locator => 'ui-dialog-title-_jq-drop-off-hours-of-operation-dialog')
car_selected_page.elements.create(:name => 'car data drop off location hours of operation overlay close button', :by_css_locator => 'div.ui-dialog[aria-labelledby="ui-dialog-title-_jq-drop-off-hours-of-operation-dialog"] * button.ui-button span.ui-button-text')
car_selected_page.elements.create(:name => 'car data pick up location open hours title', :by_css_locator => 'div.car-data:nth-of-type(5) p.locations span')
car_selected_page.elements.create(:name => 'car data drop off location open hours title', :by_css_locator => 'div.car-data:nth-of-type(6) p.locations span')
#car_sp05_axpt3872_spec 
car_selected_page.elements.create(:name => 'car driver info section number', :by_css_locator => 'div#driver-info-section.checkout-section h1._jq-accordion-section-link a:nth-of-type(1)')
car_selected_page.elements.create(:name => 'car read age policy link', :by_class_locator => '_jq-car-age-policy-link')
car_selected_page.elements.create(:name => 'car overlay age policy title', :by_id_locator => 'ui-dialog-title-_jq-age-policy-dialog')
car_selected_page.elements.create(:name => 'car overlay age policy close button', :by_css_locator => 'div.ui-dialog[aria-labelledby="ui-dialog-title-_jq-age-policy-dialog"] * span.ui-button-text')
car_selected_page.elements.create(:name => 'car driver info first name textbox', :by_id_locator => 'cart_driver_attributes_first_name')
car_selected_page.elements.create(:name => 'car driver info middle name textbox', :by_id_locator => 'cart_driver_attributes_middle_name')
car_selected_page.elements.create(:name => 'car driver info last name textbox', :by_id_locator => 'cart_driver_attributes_last_name')
car_selected_page.elements.create(:name => 'car driver info labels', :by_css_locator => '#_jq-form-who-is-driving fieldset.main-fieldset ol legend')
car_selected_page.elements.create(:name => 'car driver info email texbox', :by_id_locator => 'cart_driver_attributes_email')
car_selected_page.elements.create(:name => 'car driver info phone number texbox', :by_id_locator => 'cart_driver_attributes_phone_number')
car_selected_page.elements.create(:name => 'car driver info loyalty program texbox', :by_id_locator => 'cart_driver_attributes_loyalty_program_number')
car_selected_page.elements.create(:name => 'car driver info container', :by_css_locator => '#driver-info-section.checkout-section  div.checkout-section-content')
car_selected_page.elements.create(:name => 'car driver info error messages', :by_css_locator => 'div.driver-info * ul.errors li')
car_selected_page.elements.create(:name => 'car driver info save button', :by_css_locator => 'div.driver-container * button.button-save')
car_selected_page.elements.create(:name => 'car driver info check loyalty number text', :by_css_locator => 'fieldset.main-fieldset:nth-of-type(6) ol div.note')
car_selected_page.elements.create(:name => 'car driver info edit button', :by_css_locator => '#driver-info-section.checkout-section button.button-edit')
car_selected_page.elements.create(:name => 'car driver info driver has special equipment requests link', :by_css_locator => 'div.special-requests-head  span.description')
car_selected_page.elements.create(:name => 'car driver info driver has special equipment requests section collapsed', :by_css_locator => 'div.special-requests-head a.collapsed')
car_selected_page.elements.create(:name => 'car driver info driver has special equipment requests section expanded', :by_css_locator => 'div.special-requests-head a')
car_selected_page.elements.create(:name => 'car driver info driver special requests text', :by_css_locator => 'div.special-requests-content div.note')
car_selected_page.elements.create(:name => 'car driver info driver special requests checkboxes', :by_css_locator => 'label.ui-checkbox')
car_selected_page.elements.create(:name => 'car driver info driver airlines combobox arrow', :by_css_locator => 'span.selectBox-arrow')
car_selected_page.elements.create(:name => 'car driver info driver airlines items combobox', :by_css_locator => 'ul.selectBox-dropdown-menu:nth-of-type(1) li')
car_selected_page.elements.create(:name => 'car driver info driver airlines combobox', :by_css_locator => '#_jq-form-who-is-driving.driver-info a.selectBox')
car_selected_page.elements.create(:name => 'car driver info driver flight number textbox', :by_id_locator => 'passengers')
car_selected_page.elements.create(:name => 'car payment info container', :by_css_locator => '#payment-info-section._jq-accordion-section div.checkout-section-content')
car_selected_page.elements.create(:name => 'car book you car info container', :by_css_locator => '#terms-conditions-section.checkout-section div.checkout-section-content')
car_selected_page.elements.create(:name => 'car payment info warning text', :by_css_locator => 'div.warning')
#reg_sp5_car_script1_axpt1157_axpt1213_spec
car_selected_page.elements.create(:name => 'car select book car button', :by_css_locator => 'fieldset.book-buttons * input.buttoncommit')
car_selected_page.elements.create(:name => 'car book car error message', :by_css_locator => 'div.error-handling * ul.errors li')
#reg_sp6_car_script1_axpt3486_spec
car_selected_page.elements.create(:name => 'car book car terms conditions checkbox', :by_css_locator => 'ul.checkboxes li:nth-of-type(1) span.ui-checkbox')
#reg_sp6_car_script1_axpt3865_spec
car_selected_page.elements.create(:name => 'car sections titles', :by_css_locator => 'h1._jq-accordion-section-link a:nth-of-type(2)')
car_selected_page.elements.create(:name => 'car sections numbers', :by_css_locator => 'h1._jq-accordion-section-link a:nth-of-type(1)')

## Car confirmation
#reg_sp6_car_script1_axpt3486_spec
car_confirmation_page.elements.create(:name => 'car confirmation trip id number', :by_class_locator => 'trip-id')
car_confirmation_page.elements.create(:name => 'car confirmation driver text', :by_css_locator => 'p.capitalize')

## Car mytriplookups
#reg_sp6_car_script1_axpt3486_spec
car_mytriplookups_page.elements.create(:name => 'car mytriplookups confirmation number', :by_id_locator => 'trip_lookup_confirmation_number')
car_mytriplookups_page.elements.create(:name => 'car mytriplookups lookup button', :by_css_locator => '#new_trip_lookup.new_trip_lookup input[name="commit"]')

## Car triplookups
#reg_sp6_car_script1_axpt3486_spec
car_triplookups_page.elements.create(:name => 'car triplookups invalid email trip id message', :by_css_locator => 'div.error-copy h2')



## Car amex_login_page
#reg_sp6_car_script1_axpt323_spec/reg_sp7_car_script1_axpt332_spec
amex_login_page.elements.create(:name => 'amex login welcome title', :by_css_locator => '#frmLogon h1')
#reg_sp6_car_script1_axpt323_spec
amex_login_page.elements.create(:name => 'amex login form title', :by_css_locator => 'div.leftcontent h2')
#reg_sp7_car_script1_axpt332_spec
amex_login_page.elements.create(:name => 'amex login user textbox', :by_id_locator => 'userId')
amex_login_page.elements.create(:name => 'amex login password textbox', :by_id_locator => 'password')
amex_login_page.elements.create(:name => 'amex login button', :by_class_locator => 'loginButton')

## Home page
home_page.elements.create(:name => 'home departure date calendar', :by_id_locator => 'ui-datepicker-div')
home_page.elements.create(:name => 'home return date calendar', :by_id_locator => 'ui-datepicker-div')
home_page.elements.create(:name => 'home departure date textbox', :by_id_locator => 'flight_search_flight_search_slices_attributes_0_departure_date')
home_page.elements.create(:name => 'home return date textbox', :by_id_locator => 'flight_search_flight_search_slices_attributes_1_departure_date')
home_page.elements.create(:name => 'home flight and hotel search button', :by_name => 'package')
home_page.elements.create(:name => 'departure city textbox', :by_id_locator => 'flight_search_flight_search_slices_attributes_0_departure_search_for')
home_page.elements.create(:name => 'arrival city textbox', :by_id_locator => 'flight_search_flight_search_slices_attributes_0_arrival_search_for')

