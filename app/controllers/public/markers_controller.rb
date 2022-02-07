class Public::MarkersController < ApplicationController
  before_action :authenticate_enduser!

  def create
    @store = Store.find(params[:store_id])
    marker = current_enduser.markers.new(store_id: @store.id)
    marker.save
    @store.create_store_notification_mark(current_enduser)
  end

  def destroy
    @store = Store.find(params[:store_id])
    marker = current_enduser.markers.find_by(store_id: @store.id)
    marker.destroy
  end
end
