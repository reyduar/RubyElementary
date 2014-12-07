require 'active_record'

dbconfig = YAML::load(File.open(File.join(File.dirname(__FILE__), 'database.yml')))

ActiveRecord::Base.establish_connection(dbconfig)

class ShoppingList < ActiveRecord::Base
  has_many :items

  def number_of_items
    Item.find_all_by_shopping_list_id(id).size
  end
end


class Item < ActiveRecord::Base

end