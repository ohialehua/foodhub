class Store::OrderDetailsController < ApplicationController
  before_action :authenticate_store!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @store_order = @order_detail.store_order
    @order_details = @store_order.order_details
    @order_detail.update(order_detail_params)
    if @order_detail.working? #注文詳細に製作ステータスが製作中のものがあれば
       @store_order.production! #注文ステータスを製作中に変える
       flash[:warning] = "まだ製作中の商品があります"
    elsif @order_details.count == @order_details.complete.count #注文詳細の製作ステータスがすべて製作完了になったら
      @store_order.ready_to_delivery! #注文ステータスを発送準備中に変える
      flash[:success] = "すべての商品の製作が完了しました"
    end
    redirect_to store_store_order_path(@store_order)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:product_status)
  end
end
