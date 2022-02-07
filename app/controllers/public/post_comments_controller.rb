class Public::PostCommentsController < ApplicationController
  before_action :authenticate_enduser!

  def create
    @post = Post.find(params[:post_id])
    @comment = PostComment.new(post_comment_params)
    @comment.enduser_id = current_enduser.id
    @comment.post_id = @post.id
    if @comment.save
      if @post.store_id.blank?
        @post.create_public_notification_comment(current_enduser, @comment.id, @post.enduser_id)
      else
        @post.create_store_notification_comment(current_enduser, @comment.id, @post.store_id)
      end
      redirect_to request.referer
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = PostComment.find_by(id: params[:id])
    @comment.destroy
    redirect_to request.referer
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
