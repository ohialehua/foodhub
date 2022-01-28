class Public::PostsController < ApplicationController
  before_action :authenticate_enduser!
  impressionist :actions => [:show] #詳細ページを閲覧された回数を計測

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.enduser_id = current_enduser.id
    if @post.save
      redirect_to root_path
      flash[:success] = "新規投稿に成功しました"
    else
      redirect_to request.referer
      flash[:warning] = "入力漏れがあります！"
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = PostComment.new
    if @post.enduser_id.present?  #ユーザーの投稿か加盟店の投稿か分けて考える(条件分岐させないとfalseのとき@genresがnilになる)
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
    redirect_to root_path
    flash[:danger] = "投稿を削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:enduser_id, :post_image, :body)
  end
end
