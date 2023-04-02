class Public::AddressesController < ApplicationController

  def create
    @address=Address.new(address_params)
    @address.customer_id=current_customer.id
    if @address.save
      flash[:notice]="登録に成功しました"
      redirect_to '/addresses'
    else
      @addresses=Address.all
      render:index
    end
  end

  def index
    @address=Address.new
    @addresses=Address.all
  end

  def edit
  end

  def update
  end

  def destroy
    address=Address.find(params[:id])
    address.destroy
    redirect_to '/addresses'
  end


  private

  def address_params
    params.require(:address).permit(:customer_id,:name,:postal_code,:address)
  end
end
