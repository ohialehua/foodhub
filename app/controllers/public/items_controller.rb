class Public::ItemsController < ApplicationController
  before_action :authenticate_enduser!

  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
