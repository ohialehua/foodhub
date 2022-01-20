class Store::HomesController < ApplicationController
  before_action :authenticate_store!
  before_action :ensure_store_status

  def top
    @store = current_store
    @items = @store.items.page(params[:item_page])
    @posts = @store.posts.page(params[:post_page]).reverse_order
  end

  private
  #ステータスが無効の場合ログアウトする
  def ensure_store_status
    if current_store.is_deleted == true
      sign_out_and_redirect(current_store)
    end
  end

end
