class Public::ItemsController < ApplicationController
  before_action :authenticate_enduser!

  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @cart_items = current_enduser.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end
end
