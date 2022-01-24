class Store::SearchController < ApplicationController

  def search
    @search = params[:search]

    @store_orders = StoreOrder.search(@search)
    @store_orders.count
    if @store_orders.count == 0
      render :search
    end
  end
end
