class Public::CartItemsController < ApplicationController
  before_action :authenticate_enduser!
  
  def index
  end
end
