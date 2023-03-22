class Item < ApplicationRecord

  has_one_attached:image
  has_many:cart_items,    dependent: :destroy
  has_many:order_details, dependent: :destroy
  belongs_to:genre

  validates :name,         presence:true
  validates :introduction, length:{ minimum:1,maximum:255 }
  validates :genre_id,     presence:true
  validates :price,        presence:true
  validates :is_active,    inclusion: ["販売中","販売停止中"]


  enum is_active: {販売中:true,販売停止中:false}

  def get_image(width,height)
    unless image.attached?
      file_path=Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path),filename:'default-image.jpg',content_type:'image/jpeg')
    end
    image.variant(resize_to_limit:[width,height]).processed
  end


end
