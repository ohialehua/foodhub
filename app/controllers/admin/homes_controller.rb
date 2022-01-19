class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @stores = Store.sort(params[:selection])
  end
end
