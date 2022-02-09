class Public::OrdersController < ApplicationController
  before_action :authenticate_enduser!

  def new
    if current_enduser.deliveries.present?
      @order = Order.new
      #支払方法の定義
      @credit_card = Order.pay_methods.key(0)
      @transfer = Order.pay_methods.key(1)
      @credit_card_ja = Order.pay_methods_i18n[:credit_card]
      @transfer_ja = Order.pay_methods_i18n[:transfer]
      #
      @deliveries = Delivery.where(enduser_id:current_enduser)
    else
      redirect_to deliveries_path
      flash[:info] = "配送先を登録してください"
    end
  end

  def confirm
    @cart_items = current_enduser.cart_items
    @order = Order.new(order_params)
    @store_amount = @cart_items.joins(:item).select(:store_id).distinct.count
    #カート内商品にある加盟店の数を重複なく数える
    @order.postage = 200*@store_amount #配送料は加盟店の数x200円
    @total_price_except_postage = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    #カート内商品の小計の合計
    @total_price = @total_price_except_postage + @order.postage
    #請求額

    if params[:order][:select_adress] == "0" #注文の"配送先選択"の値が0(登録済み配送先)なら
      @delivery = Delivery.find(params[:order][:delivery_id])
      @order.post_address = @delivery.post_address
      @order.address = @delivery.address
      @order.name = @delivery.name
  #(else それいがいならフォームに入力された値)
    end
  end

  def create
    cart_items = current_enduser.cart_items.all
    order = Order.new(order_params)
    order.enduser_id = current_enduser.id
    if order.save
      ActiveRecord::Base.transaction do
      #支払いと注文履歴との齟齬を防ぐため。
        cart_items.each do |c|
          # StoreOrderモデルの作成
          @store = c.item.store
          store_order_id = nil  #条件分岐する前に登録しておくとnullでのエラーがなくなる
          if @store.store_orders.where(order_id:order).count == 0 #カート内商品の加盟店でまだこの注文のStoreOrderができていないなら
            store_order = StoreOrder.create(enduser_id: current_enduser.id, order_id: order.id, store_id: c.item.store_id)
            store_order_id = store_order.id
            store_order.create_store_notification_order(current_enduser, store_order.id, @store.id)
            #エンドユーザー → 加盟店に注文完了の通知
          else
            store_order_id = @store.store_orders.where(order_id:order).first.id #first.idがないと二つ目以降がStoreOrderに登録されない
            #すでに店舗ごとの注文がある場合、この注文の店舗ごとの注文の一番目を取得
          end
          #
          # OrderDetailモデルの作成
          OrderDetail.create(store_order_id: store_order_id, order_id: order.id, item_id: c.item_id, order_quantity: c.quantity, price_after_tax: c.item.with_tax_price)
          #
        end
        cart_items.destroy_all
        #カード決済
        if params[:order][:pay_method] == "credit_card"
          Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
          Payjp::Charge.create(
            :amount => params[:order][:total_price],
            :card => params['payjp-token'],
            :currency => 'jpy'
          )
        end
      end
      redirect_to orders_complete_path
    else
      redirect_to action: "new"
      flash[:danger] = "注文の確定に失敗しました。入力情報などに誤りはありませんか？"
    end
  end

  def complete
  end

  def index
    @orders = current_enduser.orders.page(params[:page]).reverse_order
  end

  def show
    if params[:id] == "confirm"
    redirect_to new_order_path
    else
      @order = Order.find(params[:id])
      @store_orders = @order.store_orders

      # 注文ステータスに"発送完了"以外のものがあればtrueを返す。
      if  @store_orders.where(order_status: [0, 1, 2, 3]).any?
        @order_status = "まだ発送されていない商品があります。"
      else
        @order_status = "すべての商品が発送されました。"
      end
      #
    end
  end

private

  def order_params
    params.require(:order).permit(:enduser_id, :postage, :total_price, :order_status, :pay_method,:post_address, :address, :name)
  end
end
