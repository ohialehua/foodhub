class StoreNotification < ApplicationRecord

  belongs_to :store
  belongs_to :enduser
  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true
  belongs_to :store_order, optional: true

end
