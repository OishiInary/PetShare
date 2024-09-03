class Public::AlbumsController < ApplicationController
before_action :authenticate_user!
    
    def index
    @user = User.all
    @albums = Album.all
    # @calbum = Album.find
    end
    
    def show
    @album = Album.find(params[:id])
    end  
    
    def new
      @album = Album.new
    end
    
    def create
    end 
    
    def edit
      @album = Album.find(params[:id])
    end
    
    def update
      @album = album.find(params[:id])
        if @album.update(album_params)
          flash[:notice] = "更新に成功しました"
          redirect_to albums_path(@album)
        else
          flash[:notice] = "更新に失敗しました"
          @album = album.find(params[:id])
          redirect_back(fallback_location: root_path)
        end
    end 
    
    def destroy
    end
    
    
    private
    
    def album_params
        params.require(:user).permit(:title, :body, :image)
    end
end
