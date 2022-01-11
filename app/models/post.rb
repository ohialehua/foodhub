class Post < ApplicationRecord

  belongs_to :store, optional: true
  belongs_to :enduser, optional: true
	has_many :favorites, dependent: :destroy
	has_many :post_comments, dependent: :destroy

	attachment :post_image

	def favorited_by?(enduser)
		favorites.where(enduser_id: enduser.id).exists?
	end
end
