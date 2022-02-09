class Post < ApplicationRecord

  belongs_to :store, optional: true #加盟店とユーザーどちらも投稿するため
  belongs_to :enduser, optional: true
	has_many :favorites, dependent: :destroy
	has_many :week_favorites, -> {where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'
	#過去一週間のいいねの数
	has_many :post_comments, dependent: :destroy
	has_many :public_notifications, dependent: :destroy
	has_many :store_notifications, dependent: :destroy

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

#ここからはPF完成後実装予定の機能

	#エンドユーザー同士のいいね通知
	def create_public_notification_like(current_enduser)
    notification = PublicNotification.where(["sender_id = ? and receiver_id = ? and post_id = ? and action = ? ", current_enduser.id, enduser_id, id, 'like'])
    #検索が複数条件で複雑化しているのでプレースホルダを記述(SQLインジェクション対策)
    # すでに「いいね」されているか検索し、いいねされていない場合のみ通知レコードを作成(重複通知回避)
    if notification.blank?
      public_notification = current_enduser.active_public_notifications.new(
        post_id: id,
        receiver_id: enduser_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if public_notification.sender_id == public_notification.receiver_id
        public_notification.checked = true
      end
      public_notification.save if public_notification.valid?
    end
  end

  #エンドユーザー同士のコメント通知
  def create_public_notification_comment(current_enduser, post_comment_id, receiver_id)
    # コメントは複数回することが考えられるため、likeとは違い重複可
    public_notification = current_enduser.active_public_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      receiver_id: receiver_id,
      action: 'post_comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if public_notification.sender_id == public_notification.receiver_id
      public_notification.checked = true
    end
    public_notification.save if public_notification.valid?
  end

  #エンドユーザー→加盟店のいいね通知
  def create_store_notification_like(current_enduser)
    notification = StoreNotification.where(["enduser_id = ? and store_id = ? and post_id = ? and action = ? ", current_enduser.id, store_id, id, 'like'])
    #検索が複数条件で複雑化しているのでプレースホルダを記述(SQLインジェクション対策)
    # すでに「いいね」されているか検索し、いいねされていない場合のみ通知レコードを作成(重複通知回避)
    if notification.blank?
      store_notification = current_enduser.store_notifications.new(
        post_id: id,
        store_id: store_id,
        action: 'like'
      )
      store_notification.save if store_notification.valid?
    end
  end

  # #加盟店→エンドユーザーのコメント通知
  # def save_store_notification_comment(current_store, post_comment_id, enduser_id)
  #   # コメントは複数回することが考えられるため、likeとは違い重複可
  #   store_notification = current_store.store_notifications.new(
  #     post_id: id,
  #     post_comment_id: post_comment_id,
  #     enduser_id: enduser_id,
  #     action: 'post_comment'
  #   )
  #   store_notification.save if store_notification.valid?
  # end

  #エンドユーザー→加盟店のコメント通知
  def create_store_notification_comment(current_enduser, post_comment_id, store_id)
    # コメントは複数回することが考えられるため、likeとは違い重複可
    store_notification = current_enduser.store_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      store_id: store_id,
      action: 'post_comment'
    )
    store_notification.save if store_notification.valid?
  end

end
