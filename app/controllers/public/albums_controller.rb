class Public::AlbumsController < ApplicationController
before_action :authenticate_user!
before_action :ensure_guest_user, only: [:new,:destroy,:edit]
    
    def show
      @album = Album.find(params[:id])
      @albums = @album.pet.album.all.limit(4)
      @album_tags = @album.tags
      @comment = current_user.comments.new
      @pet = @album.pet
      @favorites = Favorite.where(album_id: @pet.album_ids).count
    end 
     
    def index
      @albums = Album.all
      @tag_list = Tag.all
    end

    def new
      @album = Album.new
    end
    
    def create
      @album = Album.new(album_params)
      @album.user_id = current_user.id
      tag_list = params[:album][:name].split(nil)
      if @album.save
        @album.save_tag(tag_list)
        redirect_to album_path(@album[:id])
      end
    end 
    
    def edit
      @album = Album.find(params[:id])
      @tag_list = @album.tags.pluck(:name).join(nil)
      @tag_lists = @album.tags
    end
    
    def update
      @album = Album.find(params[:id])
      tag_list = params[:album][:name].split(nil)
        if @album.update(album_params)
          old_relations = AlbumTag.where(album_id: album.id)
          old_relations.each do |relation|
            relation.delete
          end
          album.save_tag(tag_list)
          flash[:notice] = "更新に成功しました"
          redirect_to album_path(@album[:id])
        else
          flash[:notice] = "更新に失敗しました"
          @album = Album.find(params[:id])
          redirect_back(fallback_location: root_path)
        end
    end 
    
    def destroy
      @album = Album.find(params[:id])
      @album.destroy
      redirect_to my_album_path
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
