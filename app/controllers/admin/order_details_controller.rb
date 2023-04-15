class Admin::OrderDetailsController < ApplicationController
  before_action:authenticate_admin!
  
  def update
    order=Order.find(params[:order_id])
    order_detail=OrderDetail.find(params[:id])
    order_details=order.order_details
    order_detail.order_id=order.id
    order_detail.update(order_detail_paramas)
    if order_detail.production_status=="making"
       order.update(order_status: "production")
    elsif order_details.all?{|order_detail| order_detail.production_status=="produced"}
          order.update(order_status: "preparing_to_ship")
    else

    end
    flash[:notice]="更新が成功しました"
    redirect_to admin_order_path(order_detail.order_id)
  end

  private

  def order_detail_paramas
    params.require(:order_detail).permit(:order_id,:item_id,:price,:amount,:production_status)
  end
end
