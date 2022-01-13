class Store::MarkersController < ApplicationController
  before_action :authenticate_store!

  def index
    @markers = current_store.markers.page(params[:page])
  end

  def show
    @marker = Marker.find(params[:id])
    @enduser = @marker.enduser
    @orders = current_store.orders.where(enduser_id:@enduser).distinct
  end

  private

  def marker_params
    params.require(:marker).permit(:enduser_id, :store_id)
  end
end
