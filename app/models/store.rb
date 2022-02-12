class Store < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :store_orders
  has_many :genres, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :markers, dependent: :destroy
  has_many :endusers, through: :markers
  has_many :store_notifications, dependent: :destroy
  has_many :public_notifications
  has_many :admin_notifications

  attachment :profile_image, destroy: false

  validates :name,presence:true
  validates :name_kana,presence:true
  validates :post_address,presence:true,length: { is: 7 }

  def marked_by?(enduser)
		markers.where(enduser_id: enduser.id).exists?
	end

	def self.sort(selection)
	  if selection == 'markers'
	    @stores = Store.joins(:markers).group(:id).order(Arel.sql('count(store_id) desc'))
	  elsif selection == 'items'
	    @stores = Store.joins(:items).group(:id).order(Arel.sql('count(store_id) desc'))
	  elsif selection == 'posts'
	    @stores = Store.joins(:posts).group(:id).order(Arel.sql('count(store_id) desc'))
	  elsif selection == 'old'
	    @stores = Store.all.order(created_at: :ASC)
	  elsif selection == 'new'
	    @stores = Store.all.order(created_at: :DESC)
	  else
      @stores = Store.all.order(created_at: :DESC)
    end
	end

	def self.search(search,word)
   if search == "forward"
     @stores = Store.where("name LIKE?","#{word}%")
   elsif search =="partial"
     @stores = Store.where("name LIKE?","%#{word}%")
   else
     @stores = Store.all
   end
  end

#ここからはPF完成後実装予定の機能
  # 加盟店 → 管理者登録通知
  def create_admin_notification_sign_up(current_store, admin_id)
    notification = AdminNotification.where(["admin_id = ? and store_id = ?",admin_id, current_store.id])
    #検索が複数条件で複雑化しているのでプレースホルダを記述(SQLインジェクション対策)
    if notification.blank?
      admin_notification = current_store.admin_notifications.new(
        admin_id: admin_id,
      )
      admin_notification.save if admin_notification.valid?
    end
  end


end
