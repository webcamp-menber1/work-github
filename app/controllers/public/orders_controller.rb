class Public::OrdersController < ApplicationController
  def new
    @order=Order.new
  end

  def create
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
    @order.customer_id=current_customer.id
    if params[:order][:select_address]==0
      @order.postal_code=current_customer.postal_code
      @order.address=current_customer.address
      @order.name=current_customer.last_name+current_customer.first_name
    elsif params[:order][:select_address]==1
      @address=Address.find(params[:order][:address_id])
      @order.postal_code=@address.postal_code
      @order.address=@address.address
      @order.name=@address.name
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
