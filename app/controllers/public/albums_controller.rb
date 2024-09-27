class Public::AlbumsController < ApplicationController
before_action :authenticate_user!
before_action :ensure_guest_user, only: [:new,:destroy,:edit]
before_action :ensure_correct_user, only: [:edit, :update]

    def show
      @album = Album.find(params[:id])
      @previous_album = Album.where('id < ?', @album.id).order(created_at: :desc).first
      @next_album = Album.where('id > ?', @album.id).order(:id).first
      unless ViewCount.find_by(user_id: current_user.id, album_id: @album.id)
       current_user.view_counts.create(album_id: @album.id)
      end
      @album_tags = @album.tags
      @comment = current_user.comments.new
      page_number = params[:page].present? ? params[:page] : 1
      @comments = @album.comments.page(page_number).order(created_at: :desc).per(5)
      @pet = @album.pet
      @favorites = Favorite.where(album_id: @pet.album_ids).count
      @top_favorites = @pet.album.joins(:favorites)
                    .group('albums.id')
                    .order('COUNT(favorites.id) DESC')
                    .limit(3)
    end 
     
  def index
    sort_column = params[:sort] || 'created_at'
    sort_direction = params[:direction] || 'asc'

    @albums = Album
      .left_outer_joins(:favorites)
      .select('albums.*, COUNT(favorites.id) AS favorites_count')
      .group('albums.id')

    if sort_column == 'favorites_count'
      @albums = @albums.order("favorites_count #{sort_direction}")
    else
      @albums = @albums.order("#{sort_column} #{sort_direction}")
    end

    @albums = @albums.page(params[:page])
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
      else
       @album = Album.new(album_params)
        flash[:notice] = "登録に失敗しました"
        redirect_back(fallback_location: root_path)
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
          old_relations = AlbumTag.where(album_id: @album.id)
          old_relations.each do |relation|
            relation.delete
          end
          @album.save_tag(tag_list)
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
    
  def load_more_albums
    pet = Pet.find(params[:id])
    albums = pet.albums.where.not(id: params[:exclude_ids]).offset(params[:offset]).limit(3) # 3件ずつ取得

    render json: {
      albums: albums.map { |album| { id: album.id, image_url: album.get_album_image } }
    }
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
    
    def ensure_correct_user
    @album = Album.find(params[:id])
    unless @album.user == current_user
      redirect_to user_path(current_user)
    end
  end
    
end
