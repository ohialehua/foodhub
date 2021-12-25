class Store::ItemsController < ApplicationController
  before_action :authenticate_store!

  def index
    @items = Item.page(params[:page])
  end
  
  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    @item.store_id = current_store.id
    if @item.save
      redirect_to store_item_path(@item)
    else
      @items = Item.all
      render :index
    end
  end

  def edit
  end
  
  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :body, :price_before_tax, :image, :is_active)
  end

end
