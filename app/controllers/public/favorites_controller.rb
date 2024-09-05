class Public::FavoritesController < ApplicationController
before_action :authenticate_user!

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
 
end
