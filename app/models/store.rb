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

end
