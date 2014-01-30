class CreateRessources < ActiveRecord::Migration
  def change
    create_table :ressources do |t|
      t.integer :resolved_id
      t.string :resolved_title
      t.string :resolved_url
      t.boolean :favorite
      t.integer :status
      t.text :excerpt
      t.integer :word_count
      t.datetime :time_added
      t.datetime :time_updated
      t.datetime :time_read
      t.datetime :time_favorited

      t.timestamps
    end
  end
end
