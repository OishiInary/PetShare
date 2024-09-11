class Public::AlbumsController < ApplicationController
before_action :authenticate_user!
before_action :ensure_guest_user, only: [:new,:destroy,:edit]
    
    def show
      @album = Album.find(params[:id])
      @albums = @album.pet.album.all.limit(4)
      @comment = current_user.comments.new
    end 
    
    def index
      @albums = Album.all
    end

    def new
      @album = Album.new
    end
    
    def create
      @album = Album.new(album_params)
      @album.user_id = current_user.id
      @album.save
      redirect_to album_path(@album[:id])
    end 
    
    def edit
      @album = Album.find(params[:id])
    end
    
    def update
      @album = album.find(params[:id])
        if @album.update(album_params)
          flash[:notice] = "更新に成功しました"
          redirect_to album_path(@album[:id])
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
      params.require(:album).permit(:title, :body, :image, :user_id, :pet_id)
  end
    
  def ensure_guest_user
    if current_user&.guest_user?
      redirect_back(fallback_location: root_path, notice: "ゲストユーザーは投稿できません。")
    end
  end  
    
    
end
