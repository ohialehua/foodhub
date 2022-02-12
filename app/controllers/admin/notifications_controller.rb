class Admin::NotificationsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @notifications = current_admin.admin_notifications.page(params[:page]).per(20)
  end

  def update
    notification = AdminNotification.find(params[:id])
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

  def admin_notification_params
    params.require(:public_notification).permit(:checked)
  end
end
