class Public::ItemsController < ApplicationController
  def index
    if params[:search] == "genre"
      genre = Genre.find(params[:genre_id])
      @items = genre.items
    else
      @items = Item.all
    end
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @tax_include_price = @item.price * 1.1
    @cart_item = CartItem.new
    @genres = Genre.all
  end
end
