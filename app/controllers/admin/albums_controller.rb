class Admin::AlbumsController < ApplicationController
    before_action :authenticate_admin!
    
    def index
        @albums = Album.all
    end
    
    def show
      @album = Album.find(params[:id])
      @albums = @album.pet.album.all.limit(4)
    end  
    
    
    def destroy
      @album = Album.find(params[:id])
      @album.destroy
      redirect_to admin_albums_path
    end
end