class PostComment < ApplicationRecord

  belongs_to :store, optional: true #加盟店とユーザーどちらもコメントするため
  belongs_to :enduser, optional: true
  belongs_to :post
  has_many :public_notifications, dependent: :destroy
	has_many :store_notifications, dependent: :destroy

  validates :comment, presence: true
end
