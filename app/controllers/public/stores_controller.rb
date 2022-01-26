class Public::StoresController < ApplicationController
  before_action :authenticate_enduser!

  def index
    @stores = Store.sort(params[:selection]).page(params[:page])
    @markers = current_enduser.markers
  end

  def show
    @store = Store.find(params[:id])
    if @store.is_deleted == false
      @genres = @store.genres
      @items = @store.items.page(params[:item_page]).per(9)
      if @items.count >= 3
        @rank_items = @store.items.find(OrderDetail.where(store_order_id: StoreOrder.where(store_id: @store.id).ids).group(:item_id).order('count(item_id) desc').limit(3).pluck(:item_id))
      end
      @posts = @store.posts.page(params[:post_page])
      @store_orders = @store.store_orders.where(enduser_id:current_enduser)
    else
      redirect_to stores_path
      flash[:warning] = "アクセスされた加盟店のアカウントが有効ではないため閲覧できません"
    end
  end

  private

  def store_params
    params.require(:store).permit(:email, :name, :name_kana, :post_address, :address, :phone_number, :introduction, :profile_image, :is_deleted)
  end

end
