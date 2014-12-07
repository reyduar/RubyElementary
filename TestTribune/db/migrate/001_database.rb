class Database < ActiveRecord::Migration
  def self.up
    create_table :shopping_lists do |t|
      t.string :username
      t.string :store, :limit => 30, :null => false
      t.string :description
      t.timestamps
    end
    
    create_table :items do |t|
      t.integer :shopping_list_id
      t.string :description
      t.integer :cost
      t.boolean :bought
      t.timestamps
    end
  end
  
  def self.down
    drop_table :shopping_lists
    drop_table :items
  end
end
