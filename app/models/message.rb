class Message < ApplicationRecord

  belongs_to :enduser
  belongs_to :room

  validates :message, presence: true, length: {maximum: 140}
end
