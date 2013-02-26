class CreateArticleMigration < ActiveRecord::Migration
  def self.up
    create_table :shopping_lists do |t|
      t.string :username
      t.string :store, :limit => 30, :null => false
      t.string :description
      t.timestamps!
    end
    
    create_table :items do |t|
      t.integer :shopping_list_id
      t.string :description
      t.integer :cost
      t.boolean :bought
      t.timestamps!
    end
  end
  
  
  
  def self.down
    drop_table :orders
    drop_table :items
  end
end



class ShoppingList < ActiveRecord::Base
  has_many :items
  def number_of_items
    Item.find_all_by_shopping_list_id(id).size
  end
end



class Item < ActiveRecord::Base
  ###Aca falta algo
end