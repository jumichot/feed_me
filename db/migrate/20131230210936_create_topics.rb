class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.integer :parent_id
      t.timestamps
    end
    add_index :topics, :parent_id
  end
end
