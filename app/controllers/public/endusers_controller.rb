class Public::EndusersController < ApplicationController
  before_action :authenticate_enduser!
  before_action :ensure_correct_enduser, only: [:edit, :update]

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
      flash[:info] = "ユーザー情報を編集しました"
    else
      redirect_to request.referer
      flash[:warning] = "入力漏れがあります！"
    end
  end

  private

  def enduser_params
    params.require(:enduser).permit(:name, :introduction, :profile_image, :full_name, :full_name_kana, :phone_number)
  end

  # アクセス権限
  def ensure_correct_enduser
    @enduser = Enduser.find(params[:id])
    unless @enduser == current_enduser
      redirect_to enduser_path(current_enduser)
      flash[:danger] = "他の会員の編集画面は閲覧できません"
    end
  end

end
