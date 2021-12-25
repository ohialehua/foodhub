class Store::GenresController < ApplicationController
  before_action :authenticate_store!

  def index
    @genre = Genre.new
    @genres = Genre.page(params[:page])
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def create
    genre = Genre.new(genre_params)
    genre.save
    redirect_to request.referer
  end

  def update
    genre = Genre.find(params[:id])
    if genre.update(genre_params)
      redirect_to store_genres_path
    else
      redirect_to request.referer
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:store_id,:name)
  end
end
