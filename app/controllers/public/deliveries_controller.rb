class Public::DeliveriesController < ApplicationController
  before_action :authenticate_enduser!

def index
  if current_enduser.full_name.blank? || current_enduser.full_name_kana.blank? || current_enduser.phone_number.blank?
    redirect_to edit_enduser_path(current_enduser.id)
    flash[:info] = "個人情報を入力してください"
  else
    @delivery = Delivery.new
    @deliveries = current_enduser.deliveries.page(params[:page])
  end
end

def create
  delivery = Delivery.new(delivery_params)
  delivery.enduser_id = current_enduser.id
  if delivery.save
    redirect_to request.referer
    flash[:success] = "新しい配送先を追加しました"
  else
    redirect_to request.referer
    flash[:warning] = "入力漏れがあります！"
  end
end

def destroy
  delivery = Delivery.find(params[:id])
  delivery.destroy
  redirect_back(fallback_location:root_path)
  flash[:danger] = "宛名「#{delivery.name}」様の配送先情報を削除しました"
end

def edit
  @delivery = Delivery.find(params[:id])
end

def update
  @delivery = Delivery.find(params[:id])
  if @delivery.update(delivery_params)
    redirect_to  deliveries_path
    flash[:info] = "配送先情報を変更しました"
  else
    redirect_to request.referer
    flash[:warning] = "入力漏れがあります！"
  end
end

private

  def delivery_params
    params.require(:delivery).permit(:enduser_id, :post_address, :address, :name)
  end

end
