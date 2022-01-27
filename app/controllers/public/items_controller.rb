class Public::ItemsController < ApplicationController
  before_action :authenticate_enduser!

  def index
    @items = Item.sort(params[:selection]).page(params[:page])
    @rank_items = Item.find(OrderDetail.rank(5).pluck(:item_id))
    @markers = current_enduser.markers
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @cart_items = current_enduser.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @store = @item.store
    unless @item.is_active == true
      flash[:danger] = "この商品は現在販売停止中のため購入できません"
    end
  end
end
