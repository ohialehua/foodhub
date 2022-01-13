class Store::OrderDetailsController < ApplicationController
  before_action :authenticate_store!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = current_store.order_details.where(order_id:@order)
    @order_detail.update(order_detail_params)
    if @order_detail.working?
       @order.production!
    elsif @order_details.count == @order_details.complete.count
      @order.ready_to_delivery!
    end
    redirect_to store_order_path(@order)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:product_status)
  end
end
