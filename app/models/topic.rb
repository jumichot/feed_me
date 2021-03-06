class Topic < ActiveRecord::Base
  validates :name, uniqueness: true
  # has_many :ressources

  acts_as_tree

  def self.json_tree(nodes)
    nodes.map do |node, sub_nodes|
      {:name => node.name, :id => node.id, :children => json_tree(sub_nodes).compact}
    end
  end

  def ressources
    Ressource.tagged_with(name)
  end
end
