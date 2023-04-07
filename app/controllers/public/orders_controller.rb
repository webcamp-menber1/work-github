class Public::OrdersController < ApplicationController
  def new
    @order=Order.new
  end

  def create
    @order=Order.new(order_params)
    @order.customer_id=current_customer.id
    if @order.save
       cart_items=current_customer.cart_items
       cart_items.each do |cart_item|
         order_detail=OrderDetail.new
         order_detail.order_id=@order.id
         order_detail.item_id=cart_item.item_id
         order_detail.price=cart_item.item.with_tax_price
         order_detail.amount=cart_item.amount
         order_detail.production_status="cannot_start"
         order_detail.save
    end
       current_customer.cart_items.destroy_all
       redirect_to done_orders_path
    else
       render:new
    end
  end

  def index
  end

  def show
  end

  def confirm
    @cart_items=current_customer.cart_items
    @total=0
    @postage=800
    @order=Order.new(order_params)
    @params=params[:order][:select_address].to_i
    if @params==0
       @order.delivery_postal_code=current_customer.postal_code
       @order.delivery_address=current_customer.address
       @order.delivery_name=current_customer.last_name+current_customer.first_name
    elsif @params==1
       @address=Address.find(params[:order][:address_id])
       @order.delivery_postal_code=@address.postal_code
       @order.delivery_address=@address.address
       @order.delivery_name=@address.name
    else

    end
  end

  def done
  end

  private

  def order_params
    params.require(:order).permit(:customer_id,:delivery_postal_code,:delivery_address,:delivery_name,:postage,:payment,:payment_method,:order_status)
  end
end
