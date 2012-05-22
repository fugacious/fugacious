class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.text :body
      t.integer :views, :default => -1
      t.integer :max_views, :default => 2
      t.float :hours, :default => 4
      t.string :token
      
      t.timestamps
    end
    
    add_index :messages, :token, :unique => :true
  end

  def self.down
    drop_table :messages
  end
end
