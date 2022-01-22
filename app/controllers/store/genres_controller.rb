class Store::GenresController < ApplicationController
  before_action :authenticate_store!

  def index
    @genre = Genre.new
    @genres = current_store.genres.page(params[:page])
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.store_id = current_store.id
    @genre.save
    redirect_to request.referer
    flash[:success] = "新しい商品ジャンルが追加されました。"
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to store_genres_path
      flash[:info] = "商品ジャンルが変更されました。"
    else
      redirect_to request.referer
      flash[:warning] = "未入力はできません。"
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:store_id,:name)
  end
end
