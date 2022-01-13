class Store::OrdersController < ApplicationController
  before_action :authenticate_store!

  def index
    @orders = Order.joins(:order_details).where(order_details: {store_id:current_store}).distinct
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.where(store_id:current_store)
    @postage = 200
  end

end
