class Chat < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :room

  validates :message, allow_blank: true, length: { maximum: 140 }
end
