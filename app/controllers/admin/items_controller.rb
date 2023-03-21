class Admin::ItemsController < ApplicationController
  def new
    @item=Item.new
  end

  def create
    item=Item.new(item_params)
    item.save
    redirect_to item_path(item.id)
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def item_params
    params.require(:item).submit(:genre_id,:name,:introduction,:price,:is_active,:image)
  end
end
