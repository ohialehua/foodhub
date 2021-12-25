class Relationship < ApplicationRecord

  belongs_to :follower, class_name: "Enduser"
  belongs_to :followed, class_name: "Enduser"

end
