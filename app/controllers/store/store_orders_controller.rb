class Store::StoreOrdersController < ApplicationController
  before_action :authenticate_store!

  def index
    @store_orders = current_store.store_orders.reverse_order
  end

  def show
    @store_order = StoreOrder.find(params[:id])
    @order_details = @store_order.order_details
    @postage = 200
  end

  def update
    @store_order = StoreOrder.find(params[:id])
    @order_details = @store_order.order_details
    @store_order.update(store_order_params)
      if @store_order.payment_finish? #入金が確認出来たら
        @order_details.each do |order_detail|
          order_detail.waiting! #注文詳細の製作ステータスを製作待ちに変える
        end
        flash[:info] = "入金が確認されました"
      elsif @store_order.delivery_finish? # 発送完了になったら
        flash[:success] = "発送が完了しました"
        @store_order.create_public_notification_complete(current_store, @store_order.id, @store_order.enduser_id)
        #加盟店 → エンドユーザーの発送完了通知
      end
    redirect_to store_store_order_path(@store_order)
  end

  private

  def store_order_params
    params.require(:store_order).permit(:store_id, :order_id, :order_status)
  end

end
