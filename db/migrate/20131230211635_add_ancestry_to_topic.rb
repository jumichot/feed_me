class AddAncestryToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :ancestry, :string
  end
end
