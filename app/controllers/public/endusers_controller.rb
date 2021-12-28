class Public::EndusersController < ApplicationController
  before_action :authenticate_enduser!

  def index
    @endusers = Enduser.page(params[:page])
  end

  def show
    @enduser = current_enduser
  end

  def edit
  end

  private

  def enduser_params
    params.require(:enduser).permit(:name, :introduction, :profile_image)
  end
end
