class Store::MarkersController < ApplicationController
  before_action :authenticate_store!

  def index
    @markers = Marker.sort(params[:selection]).page(params[:page])
  end

  def show
    @marker = Marker.find(params[:id])
    @enduser = @marker.enduser
    # フォロワーの店毎の注文から自分の店のものを取得
    @store_orders = @enduser.store_orders.where(store_id:current_store).reverse_order
    # フォロワーの注文から自分の店の注文を取得
    #@orders = @enduser.orders.joins(:store_orders).where(store_orders: {store_id:current_store})
  end

  private

  def marker_params
    params.require(:marker).permit(:enduser_id, :store_id)
  end
end
