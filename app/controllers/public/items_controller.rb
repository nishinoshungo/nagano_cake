class Public::ItemsController < ApplicationController
  def index
    if params[:search] == "genre"
      genre = Genre.find(params[:genre_id])
      @items = genre.items
      @genre_name = genre.name
    else
      @items = Item.all
      @genre_name = "商品"
    end
    @genres = Genre.all
  end

  def search
    if params[:keyword].present?
      @items = Item.where('name LIKE ?', "%#{params[:keyword]}%")
    else
      @items = Item.none
    end
    @genres = Genre.all
    @genre_name = "検索商品"
    render :index
  end

  def show
    @item = Item.find(params[:id])
    @tax_include_price = @item.price * 1.1
    @cart_item = CartItem.new
    @genres = Genre.all
  end
end
