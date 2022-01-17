class Public::PostsController < ApplicationController
  before_action :authenticate_enduser!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.enduser_id = current_enduser.id
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = PostComment.new
    if @post.enduser_id.present?  #条件分岐させないとfalseのとき@genresがnilになる
      @enduser = @post.enduser
      @followings = @enduser.followings.page(params[:following_page])
      @followers = @enduser.followers.page(params[:follower_page])
    else
      @store = @post.store
      @genres = @store.genres
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:enduser_id, :post_image, :body)
  end
end
