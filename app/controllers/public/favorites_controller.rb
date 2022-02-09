class Public::FavoritesController < ApplicationController
  before_action :authenticate_enduser!

  def create
    @post = Post.find(params[:post_id])
    favorite = current_enduser.favorites.new(post_id: @post.id)
    if favorite.save
      if @post.enduser_id.present?
        @post.create_public_notification_like(current_enduser)
      else
        @post.create_store_notification_like(current_enduser)
      end
      
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_enduser.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end

end
