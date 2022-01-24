class Public::SearchController < ApplicationController
  
  def search
    @range = params[:range]
    search = params[:search]
    @word = params[:word]

    if @range == '1'
      @endusers = Enduser.search(search,@word)
      @endusers.count
      if @endusers.count == 0
        render :search
      end
    elsif @range == '2'
      @stores = Store.search(search,@word)
      @stores.count
      if @stores.count == 0
        render :search
      end
    else
      @items = Item.search(search,@word)
      @items.count
      if @items.count == 0
        render :search
      end
    end
  end
end
