class Admin::StoresController < ApplicationController
  before_action :authenticate_admin!

  def show
    @store = Store.find(params[:id])
    @items = @store.items.page(params[:item_page])
    @posts = @store.posts.page(params[:post_page])
    @genres = @store.genres
  end

  def update
    store = Store.find(params[:id])
    store.update(store_params)
    redirect_to request.referer
  end

   private

  def store_params
    params.require(:store).permit(:is_deleted)
  end
end
