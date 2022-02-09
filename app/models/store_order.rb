class StoreOrder < ApplicationRecord

  has_many :order_details
  belongs_to :enduser
  belongs_to :store
  belongs_to :order
  has_many :store_notifications, dependent: :destroy

  enum order_status: { payment_waiting: 0, payment_finish: 1, production: 2, ready_to_delivery: 3, delivery_finish: 4 }

  def self.search(search)
   if search == "発送完了"
     @store_orders = StoreOrder.where("order_status","delivery_finish")
   elsif search =="未発送"
     @store_orders = StoreOrder.where.not("order_status","delivery_finish")
   else
     @store_orders = StoreOrder.all
   end
  end

  #ここからはPF完成後実装予定の機能

  #エンドユーザー→加盟店の注文完了通知
  def create_store_notification_order(current_enduser, store_order_id, store_id)
    notification = StoreNotification.where(["enduser_id = ? and store_id = ? and store_order_id = ? and action = ? ",current_enduser.id, store_id, store_order_id, 'complete'])
    #検索が複数条件で複雑化しているのでプレースホルダを記述(SQLインジェクション対策)
    if notification.blank?
      store_notification = current_enduser.store_notifications.new(
        store_order_id: store_order_id,
        store_id: store_id,
        action: 'complete'
      )
      store_notification.save if store_notification.valid?
    end
  end

  #加盟店→エンドユーザーの発送完了通知
  def create_store_notification_complete(current_store, store_order_id, enduser_id)
    notification = StoreNotification.where(["store_id = ? and enduser_id = ? and store_order_id = ? and action = ? ",current_store.id, enduser_id, store_order_id, 'complete'])
    #検索が複数条件で複雑化しているのでプレースホルダを記述(SQLインジェクション対策)
    if notification.blank?
      store_notification = current_store.store_notifications.new(
        store_order_id: store_order_id,
        enduser_id: enduser_id,
        action: 'complete'
      )
      store_notification.save if store_notification.valid?
    end
  end

end
