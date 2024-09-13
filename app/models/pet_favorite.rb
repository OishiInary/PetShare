class PetFavorite < ApplicationRecord

validates :user_id, uniqueness: {scope: :pet_id}

belongs_to :user
belongs_to :pet

end
