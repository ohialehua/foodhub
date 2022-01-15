class Store::StoreOrdersController < ApplicationController
  before_action :authenticate_store!

  def index
    @orders = current_store.store_orders.distinct
  end

  def show
    @store_order = StoreOrder.find(params[:id])
    @order_details = current_store.store_orders.order_details.where(store_order_id:@store_order)
    @postage = 200
  end

  def update
    @order = StoreOrder.find(params[:id])
    @order_details = current_store.order_details.where(order_id:@order)
    @order.update(store_order_params)
      if @order.payment_finish?
        @order_details.each do |order_detail|
          order_detail.waiting!
        end
      end
    redirect_to store_store_order_path(@order)
  end

  private

  def store_order_params
    params.require(:store_order).permit(:store_id, :order_id, :order_status)
  end

end
