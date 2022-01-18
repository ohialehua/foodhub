class Public::ItemsController < ApplicationController
  before_action :authenticate_enduser!

  def index
    @items = Item.sort(params[:selection]).page(params[:page])
    @rank_items = Item.find(OrderDetail.group(:item_id).order('count(item_id) desc').limit(5).pluck(:item_id))
    @markers = current_enduser.markers
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @cart_items = current_enduser.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @store = @item.store
  end
end
