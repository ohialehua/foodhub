class Enduser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :markers, dependent: :destroy
  has_many :stores, through: :markers
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  has_many :cart_items
  has_many :items, through: :cart_items
  has_many :deliveries
  has_many :orders
  has_many :store_orders

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :active_public_notifications, class_name: 'PublicNotification', foreign_key: 'sender_id', dependent: :destroy
  has_many :passive_public_notifications, class_name: 'PublicNotification', foreign_key: 'receiver_id', dependent: :destroy
  has_many :store_notifications, dependent: :destroy

  attachment :profile_image, destroy: false
  validates :name,presence:true


  def follow(enduser_id)
     relationships.create(followed_id: enduser_id)
  end

  def unfollow(enduser_id)
    relationships.find_by(followed_id: enduser_id).destroy
  end

  def follower?(enduser)
    followings.include?(enduser)
  end
  
  def create_public_notification_follow(current_enduser)
    notification = PublicNotification.where(["sender_id = ? and receiver_id = ? and action = ? ",current_enduser.id, id, 'follow'])
    if notification.blank?
      public_notification = current_enduser.active_public_notifications.new(
        receiver_id: id,
        action: 'follow'
      )
      public_notification.save if public_notification.valid?
    end
  end

  def self.search(search,word)
   if search == "forward"
     @endusers = Enduser.where("name LIKE?","#{word}%")
   elsif search =="partial"
     @endusers = Enduser.where("name LIKE?","%#{word}%")
   else
     @endusers = Enduser.all
   end
  end

end
