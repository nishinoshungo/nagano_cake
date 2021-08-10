class Admin::OrderItemsController < ApplicationController
  before_action :authenticate_admin!

  def update
    order_item = OrderItem.find(params[:id])
    order_item.update(order_item_params)
    order = order_item.order
    if order_item.making_status == "製作中"
      order.order_status = 3
      order.save
    end

    order_items = order_item.order.order_items
    order_items.each do |order_item|
      if order_item.making_status != "制作完了"
        redirect_to admin_order_path(order_item.order.id)
        return
      elsif order_item.making_status == "制作完了"
        order.order_status = 4
      end
    end
    order.save

    redirect_to admin_order_path(order_item.order.id)
  end

  private
  def order_item_params
    params.require(:order_item).permit(:making_status)
  end
end
