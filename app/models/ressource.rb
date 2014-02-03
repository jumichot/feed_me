class Ressource < ActiveRecord::Base
  validates :resolved_id, uniqueness: :true, presence: true
  validates :resolved_url, uniqueness: :true, allow_nil: true
  validates :resolved_url, presence: true
  acts_as_taggable
end
