class Store::OrdersController < ApplicationController
  before_action :authenticate_store!

  def index
    @orders=current_store.orders.page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
    @postage = 200
  end

end
