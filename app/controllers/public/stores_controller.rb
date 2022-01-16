class Public::StoresController < ApplicationController
  before_action :authenticate_enduser!

  def index
    @stores = Store.page(params[:page])
    @markers = current_enduser.markers
  end

  def show
    @store = Store.find(params[:id])
    @genres = @store.genres
    @items = @store.items.page(params[:item_page]).per(9)
    @posts = @store.posts.page(params[:post_page])
    @store_orders = @store.store_orders.where(enduser_id:current_enduser)
  end

  private

  def store_params
    params.require(:store).permit(:email, :name, :name_kana, :post_address, :address, :phone_number, :introduction, :profile_image, :is_deleted)
  end

end
