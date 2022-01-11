class Store::HomesController < ApplicationController
  before_action :authenticate_store!

  def top
    @store = current_store
    @items = @store.items.page(params[:item_page])
    @posts = @store.posts.page(params[:post_page]).reverse_order
  end
end
