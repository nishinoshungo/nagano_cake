class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new
    @order.shipping = 800

    if params[:order][:payment] == "0"
      @order.payment = "クレジットカード"
    elsif params[:order][:payment] == "1"
      @order.payment = "銀行振込"
    end

    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_option] == "1"
      selected_id = params[:order][:selected_address]
      selected_address = Address.find(selected_id)
      @order.postal_code = selected_address.postal_code
      @order.address = selected_address.address
      @order.name = selected_address.name
    elsif params[:order][:address_option] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end

  end

  def create
    # ordersテーブルにレコードを保存
    order = Order.new(order_params)
    order.customer_id = current_customer.id
    order.save

    # order_itemsテーブルにレコードを保存
    cart_items = current_customer.cart_items
    cart_items.each do |cart_item|
       order_item = OrderItem.new
       order_item.item_id = cart_item.item_id
       order_item.order_id = order.id
       order_item.price = cart_item.item.price
       order_item.amount = cart_item.amount
       order_item.save
    end
    CartItem.destroy_all
    redirect_to "/orders/complete"
  end

  def complete
  end


  def index
    @orders = Order.all
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping, :price, :payment)
  end

end
