class Public::HomesController < ApplicationController

  def top
    @posts = Post.sort(params[:selection]).page(params[:page])
  end
end
