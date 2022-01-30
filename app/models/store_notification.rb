class StoreNotification < ApplicationRecord
  
  default_scope -> { order(created_at: :desc) }

  belongs_to :store
  belongs_to :enduser
  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true
  belongs_to :store_order, optional: true

end
