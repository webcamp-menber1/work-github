class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail=OrderDetail.find(params[:id])
    @order_detail.update(order_detail_paramas)
    flash[:notice]="更新が成功しました"
    redirect_to admin_order_path(@order_detail.order.id)
  end

  private

  def order_detail_paramas
    params.require(:order_detail).permit(:order_id,:item_id,:price,:amount,:production_status)
  end
end
