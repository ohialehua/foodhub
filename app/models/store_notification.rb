class StoreNotification < ApplicationRecord
  
  default_scope -> { order(created_at: :desc) }
  # デフォルトの並びを新しい順に

  belongs_to :store
  belongs_to :enduser
  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true
  belongs_to :store_order, optional: true

end
