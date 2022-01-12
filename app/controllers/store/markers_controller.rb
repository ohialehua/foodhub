class Store::MarkersController < ApplicationController
  before_action :authenticate_store!

  def index
    @markers = current_store.markers.page(params[:page])
    @orders = Order.where(store_id:current_store)
  end

  def show
    @marker = Marker.find(params[:id])
    @enduser = @marker.enduser
    @orders = @marker.enduser.orders.page(params[:page])
  end

  private

  def marker_params
    params.require(:marker).permit(:enduser_id, :store_id)
  end
end
