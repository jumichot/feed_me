class AddTopicIdOnRessources < ActiveRecord::Migration
  def change
    add_column :ressources, :topic_id, :integer
    add_index :ressources, :topic_id
  end
end
