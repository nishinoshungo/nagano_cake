class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    if order.order_status == "入金確認"
      order_items = order.order_items
      order_items.each do |order_item|
        order_item.making_status = 2
        order_item.save
      end
    end
    redirect_to admin_order_path(order.id)
  end

  private
  def order_params
    params.require(:order).permit(:order_status)
  end
end
