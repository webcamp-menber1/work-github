class Admin::OrdersController < ApplicationController
  before_action:authenticate_admin!
  def show
    @order=Order.find(params[:id])
    @order_details=@order.order_details
    @total=0


  end

  def update
    @order=Order.find(params[:id])
    @order_details=@order.order_details
    if @order.update(order_params)
      if @order.order_status=="payment_confirmation"
         @order_details.each do |order_detail|
           order_detail.update(production_status: "wait_production")
         end
      else
      end
       flash[:notice]="更新が成功しました"
       redirect_to admin_order_path(@order.id)
    else
       render:show
    end
  end

  private

  def order_params
    params.require(:order).permit(:customer_id,:delivery_postal_code,:delivery_address,:delivery_name,:postage,:payment,:payment_method,:order_status)
  end
end
