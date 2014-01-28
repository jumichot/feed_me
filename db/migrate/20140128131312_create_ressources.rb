class CreateRessources < ActiveRecord::Migration
  def change
    create_table :ressources do |t|
      t.integer :resolved_id
      t.string :resolve_title
      t.string :resolve_url
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
