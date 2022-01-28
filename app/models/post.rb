class Post < ApplicationRecord

  belongs_to :store, optional: true #加盟店とユーザーどちらも投稿するため
  belongs_to :enduser, optional: true
	has_many :favorites, dependent: :destroy
	has_many :week_favorites, -> {where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'
	#過去一週間のいいねの数
	has_many :post_comments, dependent: :destroy

	attachment :post_image

	validates :post_image,presence:true
	validates :body,presence:true

	def favorited_by?(enduser)
		favorites.where(enduser_id: enduser.id).exists?
	end

	def self.sort(selection)
	  if selection == 'PV'
	    @posts = Post.order(impressions_count: :DESC)
	  elsif selection == 'new'
	    @posts = Post.all.order(created_at: :DESC)
	  elsif selection == 'old'
	    @posts = Post.all.order(created_at: :ASC)
	  else
      @posts = Post.left_joins(:week_favorites).group(:id).order(Arel.sql('count(post_id) desc'))
    end
	end

	is_impressionable counter_cache: true
end
