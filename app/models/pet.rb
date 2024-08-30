class Pet < ApplicationRecord
  
  has_one_attached :image
  belongs_to :category
  belongs_to :user
end
