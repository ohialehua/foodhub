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
  has_many :public_notifications, dependent: :destroy
  has_many :store_notifications

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

  def self.search(search,word)
   if search == "forward"
     @endusers = Enduser.where("name LIKE?","#{word}%")
   elsif search =="partial"
     @endusers = Enduser.where("name LIKE?","%#{word}%")
   else
     @endusers = Enduser.all
   end
  end

#ここからはPF完成後実装予定の機能

  #エンドユーザー同士のフォロー通知                     #receiver_id がないとsender_idと一致してしまう
  def create_public_notification_follow(current_enduser, receiver_id)
    notification = PublicNotification.where(["sender_id = ? and receiver_id = ? and action = ? ",current_enduser.id, receiver_id, 'follow'])
    #検索が複数条件で複雑化しているのでプレースホルダを記述(SQLインジェクション対策)
    #receiver_id: id にしてしまうとsender_idと一致してしまう
    if notification.blank?
      public_notification = current_enduser.active_public_notifications.new(
        receiver_id: receiver_id,
        action: 'follow'
      )
      public_notification.save if public_notification.valid?
    end
  end

  #エンドユーザー→加盟店のお気に入り通知
  def create_store_notification_mark(current_enduser, store_id)
    notification = StoreNotification.where(["enduser_id = ? and store_id = ? and action = ? ",current_enduser.id, store_id, 'mark'])
    #検索が複数条件で複雑化しているのでプレースホルダを記述(SQLインジェクション対策)
    if notification.blank?
      store_notification = current_enduser.store_notifications.new(
        store_id: store_id,
        action: 'mark'
      )
      store_notification.save if store_notification.valid?
    end
  end

end
