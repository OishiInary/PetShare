class Album < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :pet
  belongs_to :tag
end
