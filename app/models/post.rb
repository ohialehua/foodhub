class Post < ApplicationRecord

  belongs_to :enduser
	has_many :favorites, dependent: :destroy
	has_many :comments, dependent: :destroy

	def favorited_by?(enduser)
		favorites.where(enduser_id: enduser.id).exists?
	end
end
