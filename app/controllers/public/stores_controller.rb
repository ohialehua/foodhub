class Public::StoresController < ApplicationController
  before_action :authenticate_enduser!

  def index
    @stores = Store.page(params[:page])
    @markers = current_enduser.markers
  end

  def show
    @store = Store.find(params[:id])
    @items = @store.items.page(params[:page])
    @genres = @store.genres
  end

  private

  def store_params
    params.require(:store).permit(:email, :name, :name_kana, :post_address, :address, :phone_number, :introduction, :profile_image, :is_deleted)
  end

end
