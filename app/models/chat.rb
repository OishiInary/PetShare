class Chat < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :room

  validates :message, presence: true, length: { maximum: 140 }
end
