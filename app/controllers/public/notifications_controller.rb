class Public::NotificationsController < ApplicationController
  before_action :authenticate_enduser!

  def index
    @notifications = current_enduser.passive_public_notifications.page(params[:page])
    @order_notifications = current_enduser.public_notifications.where(action: 'complete').page(params[:page])
    @total_notifications = @notifications | @order_notifications
  end

  def update
    notification = PublicNotification.find(params[:id])
    if notification.checked == false
      notification.update_attributes(checked: true)
      redirect_to request.referer
      flash[:info] = "通知を確認しました"
    else
      notification.update_attributes(checked: false)
      redirect_to request.referer
      flash[:success] = "通知を未読にしました"
    end
  end

  private

  def public_notification_params
    params.require(:public_notification).permit(:checked)
  end

end
