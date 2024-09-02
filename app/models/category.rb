class Category < ApplicationRecord
  
  has_many :pet, dependent: :destroy
  
  validates :name, presence: { message: "の入力は必須です" }
  
end
