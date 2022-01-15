class Store::OrderDetailsController < ApplicationController
  before_action :authenticate_store!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @store_order = @order_detail.store_order
    @order_details = @store_order.order_details
    @order_detail.update(order_detail_params)
    if @order_detail.working?
       @store_order.production!
    elsif @order_details.count == @order_details.complete.count
      @store_order.ready_to_delivery!
    end
    redirect_to store_store_order_path(@store_order)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:product_status)
  end
end
