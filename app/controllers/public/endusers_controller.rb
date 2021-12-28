class Public::EndusersController < ApplicationController
  before_action :authenticate_enduser!

  def index
  end

  def show
    @enduser = current_enduser
  end

  def edit
  end
end
