class Tag < ApplicationRecord
  
  has_many :album_tags, dependent: :destroy
  validates :name, presence: true 
  
end
