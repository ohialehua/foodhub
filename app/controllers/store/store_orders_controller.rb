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
      if @store_order.payment_finish?
        @order_details.each do |order_detail|
          order_detail.waiting!
        end
        flash[:info] = "入金が確認されました"
      elsif @store_order.delivery_finish?
        flash[:success] = "発送が完了しました"
      end
    redirect_to store_store_order_path(@store_order)
  end

  private

  def store_order_params
    params.require(:store_order).permit(:store_id, :order_id, :order_status)
  end

end
