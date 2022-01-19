class Admin::StoresController < ApplicationController
  before_action :authenticate_admin!

  def show
    @store = Store.find(params[:id])
    @items = @store.items.page(params[:item_page])
    @posts = @store.posts.page(params[:post_page])
    @genres = @store.genres
  end

  def update
    @store = Store.find(params[:id])
    @store.update(store_params)
    if @store.is_deleted == false
    p "------------"
      Admin::AdminMailer.with(store: @store).welcome_email.deliver
    p "------------"
    else
    p "------------"
      Admin::AdminMailer.with(store: @store).warning_email.deliver
    p "------------"
    end
    redirect_to request.referer
  end

  def welcome_email
    @store = params[:store]
    AdminMailer.with(store: @store).welcome_email.deliver
  end

  private

  def store_params
    params.require(:store).permit(:is_deleted)
  end
end
