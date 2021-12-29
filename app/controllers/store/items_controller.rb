class Store::ItemsController < ApplicationController
  before_action :authenticate_store!

  def index
    @items = current_store.items.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    @genres = current_store.genres
  end

  def create
    @item = Item.new(item_params)
    @item.store_id = current_store.id
    if @item.save
      redirect_to store_item_path(@item)
    else
      @genres = current_store.genres
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
    @genres = current_store.genres
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to store_item_path(@item)
    else
      redirect_to request.referer
    end
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :body, :price_before_tax, :image, :is_active)
  end

end
