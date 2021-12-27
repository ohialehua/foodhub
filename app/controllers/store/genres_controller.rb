class Store::GenresController < ApplicationController
  before_action :authenticate_store!

  def index
    @genre = Genre.new
    @genres = current_store.genres
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.store_id = current_store.id
    @genre.save
    redirect_to request.referer
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to genres_path
    else
      redirect_to request.referer
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:store_id,:name)
  end
end
