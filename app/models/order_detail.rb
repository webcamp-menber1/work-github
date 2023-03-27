class OrderDetail < ApplicationRecord
  belongs_to:order
  belongs_to:item

  enum production_status: {cannot_start:0,wait_production:1,making:2,produced:3}



  def with_tax_price
    (price*1.1).floor
  end

  def subtotal
    with_tax_price*amount
  end
end
