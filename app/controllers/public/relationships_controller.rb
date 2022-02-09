class Public::RelationshipsController < ApplicationController
  before_action :authenticate_enduser!

  def create
    current_enduser.follow(params[:enduser_id])
    current_enduser.create_public_notification_follow(current_enduser)
    #フォロー通知
    redirect_to request.referer
  end

  def destroy
    current_enduser.unfollow(params[:enduser_id])
    redirect_to request.referer
  end

end
