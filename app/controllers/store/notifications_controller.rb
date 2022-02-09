class Store::NotificationsController < ApplicationController
  before_action :authenticate_store!

  def index
    @notifications = current_store.store_notifications.page(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

end
