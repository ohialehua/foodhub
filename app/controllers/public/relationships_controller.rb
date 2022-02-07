class Public::RelationshipsController < ApplicationController
  before_action :authenticate_enduser!

  def create
    @enduser = Enduser.find(params[:relationship][:followed_id])
    current_enduser.follow(params[:enduser_id])
    @enduser.create_public_notification_follow(current_enduser)
    redirect_to request.referer
  end

  def destroy
    current_enduser.unfollow(params[:enduser_id])
    redirect_to request.referer
  end

end
