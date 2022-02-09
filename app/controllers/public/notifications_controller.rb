class Public::NotificationsController < ApplicationController
  before_action :authenticate_enduser!

  def index
    @notifications = current_enduser.passive_public_notifications.page(params[:page]).per(20)
    @order_notifications = current_enduser.store_notifications.where(action: 'complete')
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

end
