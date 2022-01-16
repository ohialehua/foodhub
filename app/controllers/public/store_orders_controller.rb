class Public::StoreOrdersController < ApplicationController
  def index
    @store = Store.find(params[:store_id])
    @store_orders = current_enduser.store_orders.where(store_id:@store)
  end

  private

  def store_order_params
    params.require(:store_order).permit(:store_id, :order_id, :order_status)
  end

end
