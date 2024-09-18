class Public::PetFavoritesController < ApplicationController
before_action :authenticate_user!
before_action :ensure_guest_user, only: [:create,:destroy]

 def create 
    @pet = Pet.find(params[:pet_id])
    @favorite = current_user.pet_favorites.new(pet_id: @pet.id)
    @favorite.save
 end

 def destroy
   @pet = Pet.find(params[:pet_id])
   @favorite = current_user.pet_favorites.find_by(pet_id: @pet.id)
   @favorite.destroy
 end
 
  private

  def ensure_guest_user
    @pet = Pet.find(params[:pet_id])
    if current_user&.guest_user?
      redirect_back(fallback_location: root_path, notice: "ゲストユーザーは[いいね！]ができません。")
    end
  end
end  