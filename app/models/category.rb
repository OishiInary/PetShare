class Category < ApplicationRecord
  
  has_many :pet, dependent: :destroy
  has_one_attached :image
  validates :name, presence: { message: "の入力は必須です" },length: { minimum: 2, maximum: 20 }
  
  
  
  def get_category_image
    (image.attached?) ? image : 'no_image.jpg'
  end
  
  
end
