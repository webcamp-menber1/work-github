class Public::ItemsController < ApplicationController
  def index
    @item_count=Item.all.count
    @items=Item.all.page(params[:page]).per(8)
  end

  def show
  end
end
