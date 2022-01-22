class Store::PostsController < ApplicationController
  before_action :authenticate_store!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.store_id = current_store.id
    if @post.save!
      redirect_to store_root_path
      flash[:success] = "新規投稿に成功しました"
    else
      redirect_to request.referer
      flash[:warning] = "入力漏れがあります！"
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = PostComment.new
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to store_root_path
    flash[:success] = "投稿を削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:store_id, :post_image, :body)
  end
end
