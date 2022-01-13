class Store::MarkersController < ApplicationController
  before_action :authenticate_store!

  def index
    @markers = current_store.markers.page(params[:page])
  end

  def show
    @marker = Marker.find(params[:id])
    @enduser = @marker.enduser
    @orders = @enduser.orders.joins(:order_details).where(order_details: {store_id:current_store}).distinct
  end

  private

  def marker_params
    params.require(:marker).permit(:enduser_id, :store_id)
  end
end
