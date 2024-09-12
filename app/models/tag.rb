class Tag < ApplicationRecord
  
  has_many :album_tags, dependent: :destroy
  validates :name, presence: true ,length: { minimum: 2, maximum: 10 }
  
end
