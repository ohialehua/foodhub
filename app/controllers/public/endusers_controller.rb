class Public::EndusersController < ApplicationController
  before_action :authenticate_enduser!

  def index
    @endusers = Enduser.page(params[:page])
  end

  def show
    @enduser = current_enduser
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
