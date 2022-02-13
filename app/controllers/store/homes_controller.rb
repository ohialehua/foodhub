class Store::HomesController < ApplicationController
  before_action :authenticate_store!
  before_action :ensure_store_status

  def top
    @store = current_store
    @items = @store.items.page(params[:item_page])
    @posts = @store.posts.page(params[:post_page]).reverse_order
  end

  private
  #ステータスが無効の場合ログアウトする(sign_up後)
  def ensure_store_status
    if current_store.is_deleted == true
      current_store.create_admin_notification_sign_up(current_store, 1)
      # 管理者に新規登録の通知
      sign_out_and_redirect(current_store)
    end
  end

end
