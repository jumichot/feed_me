class Ressource < ActiveRecord::Base
  validates :resolved_id, uniqueness: :true
  validates :resolved_url, uniqueness: :true, allow_nil: true
  acts_as_taggable
end
