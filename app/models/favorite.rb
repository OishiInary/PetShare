class Favorite < ApplicationRecord
  
  validates :user_id, uniqueness: {scope: :album_id}
    
  belongs_to :user
  belongs_to :album
end
