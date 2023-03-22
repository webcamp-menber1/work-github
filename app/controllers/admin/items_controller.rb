class Admin::ItemsController < ApplicationController
  def new
    @item=Item.new
  end

  def create
    @item=Item.new(item_params)
    if @item.save
       flash[:notice]="登録に成功しました。"
       redirect_to admin_item_path(@item.id)
    else
      render:new
    end
  end

  def index
    @items=Item.page(params[:page])
  end

  def show
  
  end

  def edit
  end

  def update
  end

  private

  def item_params
    params.require(:item).permit(:image,:name,:introduction,:genre_id,:price,:is_active)
  end
end
