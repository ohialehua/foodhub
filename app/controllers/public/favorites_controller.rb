class Public::FavoritesController < ApplicationController
  before_action :authenticate_enduser!

  def create
    @post = Post.find(params[:post_id])
    favorite = current_enduser.favorites.new(post_id: @post.id)
    favorite.save
    @post.create_public_notification_like(current_enduser)
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_enduser.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end

end
