class Admin::AdminMailer < ApplicationMailer

  def welcome_email
    @store = params[:store]
    @url = 'http://13.115.39.213/stores/sign_in'
    mail(to: @store.email, subject: 'Foodhubへようこそ')
  end

  def warning_email
    @store = params[:store]
    mail(to: @store.email, subject: 'Foodhubのアカウントが無効化されました')
  end

end
