class Post < ApplicationRecord

  belongs_to :enduser
	has_many :favorites, dependent: :destroy
	has_many :comments, dependent: :destroy

	attachment :post_image

	def favorited_by?(enduser)
		favorites.where(enduser_id: enduser.id).exists?
	end
end
