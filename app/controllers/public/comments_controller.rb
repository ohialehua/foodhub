class Public::CommentsController < ApplicationController
  before_action :authenticate_enduser!
end
