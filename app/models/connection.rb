class Connection < ActiveRecord::Base
  attr_accessible :connected_id

  belongs_to :connecter, class_name: "User", counter_cache: true
  belongs_to :connected, class_name: "Hotel"

  validates :connecter_id, presence: true
  validates :connected_id, presence: true
end
