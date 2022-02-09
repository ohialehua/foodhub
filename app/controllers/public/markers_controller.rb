class Public::MarkersController < ApplicationController
  before_action :authenticate_enduser!

  def create
    @store = Store.find(params[:store_id])
    marker = current_enduser.markers.new(store_id: @store.id)
    if marker.save
      current_enduser.create_store_notification_mark(current_enduser, @store.id)
      #エンドユーザー → 加盟店のお気に入り通知
    end
  end

  def destroy
    @store = Store.find(params[:store_id])
    marker = current_enduser.markers.find_by(store_id: @store.id)
    marker.destroy
  end
end
