class Public::FavoritesController < ApplicationController
before_action :authenticate_user!
before_action :ensure_guest_user, only: [:create,:destroy]
 def create 
    @album = Album.find(params[:album_id])
    @favorite = current_user.favorites.new(album_id: @album.id)
    @favorite.save
    redirect_back(fallback_location: root_path)
 end

 def destroy
   @album = Album.find(params[:album_id])
   @favorite = current_user.favorites.find_by(album_id: @album.id)
   @favorite.destroy
   redirect_back(fallback_location: root_path)
 end
 
  private

  def ensure_guest_user
    @album = Album.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーは[いいね！]ができません。"
    end
  end  
 
end
