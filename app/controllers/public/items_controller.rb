class Public::ItemsController < ApplicationController
  before_action :authenticate_enduser!

  def index
    @items = Item.sort(params[:selection]).page(params[:page])
    @rank_items = Item.find(OrderDetail.rank(5).pluck(:item_id))
    #注文詳細にあるランキング上位5個までの商品IDを取得
    #この取得の仕方だとOrderDetailに紐づいているitemであるため、itemを削除した後に削除したitemがランキングに入っているとIDが取得できないエラーになる。
    #思いつく解消法はItemのカラムに"今までに購入された個数"を付け加え、購入されるたびにその個数が更新されるようにし、そのカラムからランキングに並び変える方法。
    @markers = current_enduser.markers
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @cart_items = current_enduser.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    #カート内商品の小計それぞれを合計する
    @store = @item.store
    unless @item.is_active == true
      flash[:danger] = "この商品は現在販売停止中のため購入できません"
    end
  end
end
