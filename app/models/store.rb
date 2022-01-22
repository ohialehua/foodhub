class Store < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :store_orders
  # has_many :orders, through: :store_orders
  has_many :genres, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :markers, dependent: :destroy
  has_many :endusers, through: :markers

  attachment :profile_image, destroy: false

  validates :name,presence:true
  validates :name_kana,presence:true
  validates :post_address,presence:true,length: { is: 7 }

  def marked_by?(enduser)
		markers.where(enduser_id: enduser.id).exists?
	end

	def self.sort(selection)
	  if selection == 'markers'  #退会していない店舗
	    @stores = Store.where(is_deleted:false).joins(:markers).group(:id).order(Arel.sql('count(store_id) desc'))
	  elsif selection == 'items'
	    @stores = Store.where(is_deleted:false).joins(:items).group(:id).order(Arel.sql('count(store_id) desc'))
	  elsif selection == 'posts'
	    @stores = Store.where(is_deleted:false).joins(:posts).group(:id).order(Arel.sql('count(store_id) desc'))
	  elsif selection == 'old'
	    @stores = Store.where(is_deleted:false).all.order(created_at: :ASC)
	  elsif selection == 'new'
	    @stores = Store.where(is_deleted:false).all.order(created_at: :DESC)
	  else
      @stores = Store.where(is_deleted:false).all.order(created_at: :DESC)
    end
	end

end
