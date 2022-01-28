class Public::StoresController < ApplicationController
  before_action :authenticate_enduser!

  def index
    @stores = Store.sort(params[:selection]).page(params[:page])
    @markers = current_enduser.markers
  end

  def show
    @store = Store.find(params[:id])
    if @store.is_deleted == false #加盟店のアカウントが有効なら
      @genres = @store.genres
      @items = @store.items.page(params[:item_page]).per(9)
      if @items.count >= 3 #商品の数が3つ以上なら
        @rank_items = Item.find(OrderDetail.where(store_order_id: StoreOrder.where(store_id: @store.id).ids).rank(3).pluck(:item_id))
        #注文詳細の店舗ごとの注文の、加盟店にある商品のランキング上位3つ
      end
      @posts = @store.posts.page(params[:post_page])
      @store_orders = @store.store_orders.where(enduser_id:current_enduser)
      #この加盟店でのこのユーザーの注文履歴
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
