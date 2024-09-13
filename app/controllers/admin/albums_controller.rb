class Admin::AlbumsController < ApplicationController
    before_action :authenticate_admin!
    
    def index
        @albums = Album.all
    end
    
    def show
      @album = Album.find(params[:id])
      @albums = @album.pet.album.all.limit(4)
    end  
    
    
    def edit
        @album = Album.find(params[:id])
    end
    
    def update
      @album = Album.find(params[:id])
        if @album.update(album_params)
          flash[:notice] = "更新に成功しました"
          redirect_to admin_album_path(@album[:id])
        else
          flash[:notice] = "更新に失敗しました"
          @album = Album.find(params[:id])
          redirect_back(fallback_location: admin_root_path)
        end
    end 
    
    def destroy
      @album = Album.find(params[:id])
      @album.destroy
      redirect_to admin_albums_path
    end
end