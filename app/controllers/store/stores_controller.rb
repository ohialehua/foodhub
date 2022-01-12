class Store::StoresController < ApplicationController
  before_action :authenticate_store!

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
    else
      render :edit
    end
  end

  def unsubscribe
  end

  private
  def store_params
    params.require(:store).permit(:email,:name,:name_kana,:post_address,:address,:phone_number,:introduction,:profile_image,:is_deleted)
  end
end
