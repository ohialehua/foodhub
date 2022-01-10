class Public::EndusersController < ApplicationController
  before_action :authenticate_enduser!

  def index
    @endusers = Enduser.page(params[:enduser_page]).per(1)
    @followings = current_enduser.followings.page(params[:following_page]).per(1)
    @followers = current_enduser.followers.page(params[:follower_page]).per(1)
  end

  def show
    @enduser = Enduser.find(params[:id])
    @posts = @enduser.posts.page(params[:page]).reverse_order
  end

  def edit
    @enduser = Enduser.find(params[:id])
  end

  def update
    @enduser = Enduser.find(params[:id])
    if @enduser.update(enduser_params)
      redirect_to enduser_path(@enduser)
    else
      render :edit
    end
  end

  private

  def enduser_params
    params.require(:enduser).permit(:name, :introduction, :profile_image, :full_name, :full_name_kana, :phone_number)
  end
end
