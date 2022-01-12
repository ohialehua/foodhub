class Store < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :genres, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :coupons, dependent: :destroy
  has_many :markers, dependent: :destroy
  has_many :endusers, through: :markers

  attachment :profile_image, destroy: false

  validates :name,presence:true
  validates :name_kana,presence:true
  validates :post_address,presence:true,length: { is: 7 }

  def marked_by?(enduser)
		markers.where(enduser_id: enduser.id).exists?
	end

end
