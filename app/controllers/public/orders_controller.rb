class Public::OrdersController < ApplicationController
  before_action :authenticate_enduser!

  def new
    @order = Order.new
    @credit_card = Order.pay_methods.key(0)
    @transfer = Order.pay_methods.key(1)
    @credit_card_ja = Order.pay_methods_i18n[:credit_card]
    @transfer_ja = Order.pay_methods_i18n[:transfer]
    @deliveries = Delivery.where(enduser_id:current_enduser)
  end

  def confirm
    @cart_items = current_enduser.cart_items
    @order = Order.new(order_params)
    @store_amount = @cart_items.joins(:item).select(:store_id).distinct.count
    @order.postage = 200*@store_amount
    @total_price_except_postage = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @total_price = @total_price_except_postage + @order.postage

    if params[:order][:select_adress] == "0"
      @delivery = Delivery.find(params[:order][:delivery_id])
      @order.post_address = @delivery.post_address
      @order.address = @delivery.address
      @order.name = @delivery.name
    end
  end

  def create
    order = Order.new(order_params)
    order.enduser_id = current_enduser.id
    if order.save
      ActiveRecord::Base.transaction do

        # OrderDetailモデルの作成
        current_enduser.cart_items.each do |c|
          OrderDetail.create(order_id: order.id, item_id: c.item_id, order_quantity: c.quantity, price_after_tax: c.item.with_tax_price)
        end
        current_enduser.cart_items.destroy_all
        #

        # StoreOrderモデルの作成
        @order_details = order.order_details
        @order_details.each do |od|
          @store = od.store
          if @store.store_orders.where(order_id:order).count == 0
            StoreOrder.create(order_id: order.id, store_id: od.item.store_id)
          end
        end
        #
      end
      redirect_to orders_complete_path
    else
      redirect_to action: "new"
    end
  end

  def complete
  end

  def index
    @orders=current_enduser.orders.page(params[:page])
  end

  def show
    if params[:id] == "confirm"
    redirect_to new_order_path
    else
      @order = Order.find(params[:id])
    end
  end

private

  def order_params
    params.require(:order).permit(:enduser_id, :postage, :total_price, :order_status, :pay_method,:post_address, :address, :name)
  end
end
