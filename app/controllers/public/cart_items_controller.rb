class Public::CartItemsController < ApplicationController
  def index
    @cart_items=current_customer.cart_items
    @total=0
  end

  def create
    @item_id=cart_item_params[:item_id]
    if CartItem.find_by(customer_id:current_customer.id,item_id:@item_id)
       cart_item=CartItem.find_by(customer_id:current_customer.id,item_id:@item_id)
       change_amount=cart_item.amount+(cart_item_params[:amount]).to_i
       cart_item.update(amount:change_amount)
       flash[:notice]="商品の数量を変更しました。"
       redirect_to'/cart_items'
    else
      @cart_item=CartItem.new(cart_item_params)
      @cart_item.customer_id=current_customer.id
      if @cart_item.save
         flash[:notice]="カートに商品を追加しました。"
         redirect_to'/cart_items'
      else
         @item=Item.find(cart_item_params[:item_id])
         @cart_item=CartItem.new
         flash[:notice]="個数を選択してください。"
         render template: "public/items/show"
      end
    end

  end

  def update
    cart_item=CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to '/cart_items'
  end

  def destroy
    cart_item=CartItem.find(params[:id])
    cart_item.destroy
    redirect_to '/cart_items'
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to '/cart_items'

  end

  private

  def cart_item_params
  params.require(:cart_item).permit(:item_id,:customer_id,:amount)

  end


end
