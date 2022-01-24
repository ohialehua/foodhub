class Admin::SearchController < ApplicationController

  def search
    search = params[:search]
    @word = params[:word]

    @stores = Store.search(search,@word)
    @stores.count
    if @stores.count == 0
      render :search
    end
  end
end
