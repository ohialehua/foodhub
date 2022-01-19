class Admin::StoresController < ApplicationController
  before_action :authenticate_admin!

  def show
    @store = Store.find(params[:store_id])
  end

  def edit
    @store = Store.find(params[:store_id])
  end
end
