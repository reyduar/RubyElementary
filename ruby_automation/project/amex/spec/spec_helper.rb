require 'rubygems'
require 'rspec'
require 'selenium-webdriver'

RSpec.configure do |config|
  config.add_setting :env
  config.add_setting :browser
  config.add_setting :timeout
  RSpec.configuration.env = 'QAFirefox' 
  RSpec.configuration.browser = 'firefox'
  RSpec.configuration.timeout = 180
end

class AMEX_Car
end

class AMEX_Air
end

class AMEX_Hotel
end

class AMEX_Package
end

class Week_50
end

class Week_52
end

class Week_52
end

class Week_02
end

class Sprint_05
end

class Sprint_06
end

class Sprint_07
end

class Script_01
end

class RSpec::Core::Example
  def passed?
    @exception.nil?
  end
  
  def failed?
    !passed?
  end
end
