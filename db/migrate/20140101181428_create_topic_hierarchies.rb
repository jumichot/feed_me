class CreateTopicHierarchies < ActiveRecord::Migration
  def change
    create_table :topic_hierarchies, :id => false do |t|
      t.integer  :ancestor_id, :null => false   # ID of the parent/grandparent/great-grandparent/... tag
      t.integer  :descendant_id, :null => false # ID of the target tag
      t.integer  :generations, :null => false   # Number of generations between the ancestor and the descendant. Parent/child = 1, for example.
    end

    add_index :topic_hierarchies, [:ancestor_id, :descendant_id, :generations],
      :unique => true, :name => "topic_anc_desc_udx"

    # For "all ancestors of…" selects,
    add_index :topic_hierarchies, [:descendant_id],
      :name => "topic_desc_idx"
  end
end
