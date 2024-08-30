class Favorite < ApplicationRecord
  
   validates :user_id, uniqueness: {scope: :pet_id}
    validates :user_id, uniqueness: {scope: :album_id}
end
