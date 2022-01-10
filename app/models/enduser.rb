class Enduser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :markers, dependent: :destroy
  has_many :stores, through: :markers
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :cart_items
  has_many :items, through: :cart_items
  has_many :deliveries
  has_many :orders

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :entries
  has_many :messages
  has_many :rooms, through: :entries

  attachment :profile_image, destroy: false


  def follow(enduser_id)
     relationships.create(followed_id: enduser_id)
  end

  def unfollow(enduser_id)
    relationships.find_by(followed_id: enduser_id).destroy
  end

  def follower?(enduser)
    followings.include?(enduser)
  end

end
