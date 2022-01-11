class PostComment < ApplicationRecord

  belongs_to :store, optional: true
  belongs_to :enduser, optional: true
  belongs_to :post

  validates :comment, presence: true
end
