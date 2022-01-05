class Public::MarkersController < ApplicationController
  before_action :authenticate_enduser!

  def index
  end

  def create
    @store = Store.find(params[:store_id])
    marker = current_enduser.markers.new(store_id: @store.id)
    marker.save
  end

  def destroy
    @store = Store.find(params[:store_id])
    marker = current_enduser.markers.find_by(store_id: @store.id)
    marker.destroy
  end
end
