class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.float :hours, default: 20.0
      t.integer :views, default: -1
      t.integer :max_views, default: 4
      t.string :token
      t.timestamps
    end

    add_index :messages, :token, unique: true
  end
end
