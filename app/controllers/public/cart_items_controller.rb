class Public::CartItemsController < ApplicationController
  before_action :authenticate_enduser!

  def create
    @cart_item = current_enduser.cart_items.new(cart_item_params)
    @cart_item.enduser_id = current_enduser.id
    if cart_item = current_enduser.cart_items.find_by(item_id: params[:cart_item][:item_id])
       cart_item.quantity += params[:cart_item][:quantity].to_i
       cart_item.save
       redirect_to request.referer
    else
       @cart_item.save
       redirect_to request.referer
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to request.referer
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to request.referer
  end

  def destroy_all
    @cart_item = current_enduser.cart_items
    @cart_item.destroy_all
    redirect_to request.referer
  end


  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity)
  end
end
