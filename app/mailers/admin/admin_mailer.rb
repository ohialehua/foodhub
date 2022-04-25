class Admin::AdminMailer < ApplicationMailer

  def welcome_email
    @store = params[:store]
    @url = 'http://35.77.164.252/stores/sign_in'
    mail(to: @store.email, subject: 'Foodhubへようこそ')
  end

  def warning_email
    @store = params[:store]
    mail(to: @store.email, subject: 'Foodhubのアカウントが無効化されました')
  end

end
