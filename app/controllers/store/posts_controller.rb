class Store::PostsController < ApplicationController
  before_action :authenticate_store!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.store_id = current_store.id
    if @post.save
      redirect_to store_root_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = PostComment.new
  end

  private

  def post_params
    params.require(:post).permit(:store_id, :post_image, :body)
  end
end
