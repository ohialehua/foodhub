class Store::OrdersController < ApplicationController
  before_action :authenticate_store!

  def index
    @orders = current_store.orders.distinct
  end

  def show
    @order = Order.find(params[:id])
    @order_details = current_store.order_details.where(order_id:@order)
    @postage = 200
  end

  def update
    @order = Order.find(params[:id])
    @order_details = current_store.order_details.where(order_id:@order)
    @order.update(order_params)
      if @order.payment_finish?
        @order_details.each do |order_detail|
          order_detail.waiting!
        end
      end
    redirect_to store_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end
