class PublicNotification < ApplicationRecord

  #PF完成後実装予定の機能

  default_scope -> { order(created_at: :desc) }
  # デフォルトの並びを新しい順に

  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true

  belongs_to :sender, class_name: 'Enduser', foreign_key: 'sender_id', optional: true
  belongs_to :receiver, class_name: 'Enduser', foreign_key: 'receiver_id', optional: true
  belongs_to :store, optional: true
  belongs_to :enduser, optional: true
  belongs_to :store_order, optional: true
end
