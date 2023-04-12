class Public::CustomersController < ApplicationController
  def show
    @customer=Customer.find(current_customer.id)
  end

  def edit
    @customer=Customer.find(current_customer.id)
  end

  def update
    @customer=Customer.find(current_customer.id)
    if @customer.update(customer_params)
      flash[:notice]="変更に成功しました"
      redirect_to '/customers/my_page'
    else
      render:edit
    end
  end

  def confirm
    @customer=Customer.find(current_customer.id)
  end

  def withdrawal
    @customer=Customer.find(current_customer.id)
    @customer.update(is_deleted: "withdrawal")
    reset_session
    redirect_to 'root_path'
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:email,:encrypted_passwprd,:postal_code,:address,:telephone_number,:is_deleted)
  end
end
