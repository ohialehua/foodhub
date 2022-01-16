class Public::StoreOrdersController < ApplicationController
  def index
    @markers = current_enduser.markers
    @markers.each do |marker|
      @store_orders = marker.store.store_orders.where(enduser_id:current_enduser)
    end
  end

  private

  def store_order_params
    params.require(:store_order).permit(:store_id, :order_id, :order_status)
  end

end
