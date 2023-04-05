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
  end

  def done
  end

  private

  def order_params
    params.require(:order).permit(:customer_id,:delivery_postal_code,:delivery_address,:delivery_name,:postage,:payment,:payment_method,:order_status)
  end
end
