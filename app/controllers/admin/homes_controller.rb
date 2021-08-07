class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    if params[:order_sort] == "1"
      customer = Customer.find(params[:customer_id])
      @orders = customer.orders
    else
      @orders = Order.all
    end

  end
end
