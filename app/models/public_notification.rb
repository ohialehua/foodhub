class PublicNotification < ApplicationRecord

  default_scope -> { order(created_at: :desc) }
  # デフォルトの並びを新しい順に

  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true

  belongs_to :sender, class_name: 'Enduser', foreign_key: 'sender_id', optional: true
  belongs_to :receiver, class_name: 'Enduser', foreign_key: 'receiver_id', optional: true

end
