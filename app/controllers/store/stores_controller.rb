class Store::StoresController < ApplicationController
  before_action :authenticate_store!
  before_action :ensure_correct_store, only: [:edit, :update]

  def index
    @stores = Store.page(params[:page])
  end

  def show
    @store = Store.find(params[:id])
  end

  def edit
    @store = Store.find(params[:id])
  end

  def update
    @store = Store.find(params[:id])
    if @store.update(store_params)
      redirect_to store_root_path(@store)
      flash[:info] = "店舗情報を編集しました"
    else
      redirect_to request.referer
      flash[:warning] = "入力漏れがあります！"
    end
  end

  def unsubscribe
  end

  def withdraw
    current_store.update(is_deleted: true)
    reset_session
    redirect_to root_path
    flash[:danger] = "foodhubを退会しました"
  end

  private
  def store_params
    params.require(:store).permit(:email,:name,:name_kana,:post_address,:address,:phone_number,:introduction,:profile_image,:is_deleted)
  end
  
  # アクセス権限
  def ensure_correct_store
    @store = Store.find(params[:id])
    unless @store == current_store
      redirect_to store_store_path(current_store)
      flash[:danger] = "他の加盟店の編集画面は閲覧できません"
    end
  end
end
