class Public::CartItemsController < ApplicationController
  before_action :authenticate_enduser!

  def create
    @cart_item = current_enduser.cart_items.new(cart_item_params)
    @cart_item.enduser_id = current_enduser.id
    @quantity = @cart_item.quantity

    if cart_item = current_enduser.cart_items.find_by(item_id: params[:cart_item][:item_id]) 
       #今のユーザーのカートに入ってる任意の商品の情報を取得
       cart_item.quantity += params[:cart_item][:quantity].to_i
       #上の商品の個数を足す
       cart_item.save
       redirect_to request.referer
       flash[:success] = "#{cart_item.item.name}を#{@quantity}個カートに追加しました"
    else
       @cart_item.save
       redirect_to request.referer
       flash[:success] = "#{@cart_item.item.name}を#{@cart_item.quantity}個カートに入れました"
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @quantity = @cart_item.quantity
    @cart_item.update(cart_item_params)
    redirect_to request.referer
    flash[:info] = "#{@cart_item.item.name}を#{@quantity}個から#{@cart_item.quantity}個に変更しました"
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to request.referer
    flash[:danger] = "#{@cart_item.item.name}をカートから戻しました"
  end

  def destroy_all
    @cart_item = current_enduser.cart_items
    @cart_item.destroy_all
    redirect_to request.referer
    flash[:danger] = "すべての商品をカートから戻しました"
  end


  private
  def cart_item_params
    params.require(:cart_item).permit(:store_id, :item_id, :quantity)
  end
end
