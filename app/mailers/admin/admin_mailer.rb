class Admin::AdminMailer < ApplicationMailer

  def welcome_email
    @store = params[:store]
    @url = 'https://df280bcad38f46449527229623af10d2.vfs.cloud9.ap-northeast-1.amazonaws.com/stores/sign_in'
    mail(to: @store.email, subject: 'Foodhubへようこそ')
  end

  def warning_email
    @store = params[:store]
    mail(to: @store.email, subject: 'Foodhubのアカウントが無効化されました')
  end

end
