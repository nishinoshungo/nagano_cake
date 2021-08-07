class Public::HomesController < ApplicationController
  def top
    @items = Item.order(created_at: :desc).where.not(is_active: false).limit(4)
    @genres = Genre.all
  end

  def about
  end
end
