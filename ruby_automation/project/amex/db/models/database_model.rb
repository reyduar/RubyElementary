require 'active_record'

dbconfig = YAML::load(File.open(File.join(File.dirname(__FILE__), 'database.yml')))

ActiveRecord::Base.establish_connection(dbconfig)

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

class Environment < ActiveRecord::Base
    has_one :environments
end

class Flight < ActiveRecord::Base
    has_one :flights
end

class Hotel < ActiveRecord::Base
    has_one :hotels
end

class BaggageFee < ActiveRecord::Base
    has_one :baggage_fees
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



