class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @tax_include_price = @item.price * 1.1
    @cart_item = CartItem.new
  end
end
