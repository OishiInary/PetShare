class Public::HomesController < ApplicationController
before_action :authenticate_user!, except: [:top, :about, :entrance]
 before_action :ensure_guest_user, only: [:follow_list,:my_album,:my_pet,:f_albums,:f_pets]
  def top
  end  
  
  def about
  end  
  
  def mypage
    today = Date.today
    @age = today.year - current_user.birthday.year
  end  
  
  def my_pet
    @pets = Pet.where(user_id: current_user)
  end
  
  def follow_list
    @followings = User.find(current_user.followings.ids)
    @followers = User.find(current_user.followers.ids)
  end

  def my_album
    case params[:sort]
    when 'latest'
      @albums = Album.where(user_id: current_user.id).order(created_at: :desc).page(params[:page])
    when 'oldest'
      @albums = Album.where(user_id: current_user.id).order(created_at: :asc).page(params[:page])
    when 'favorites'
      @albums = Album.where(user_id: current_user.id)
                     .joins(:favorites)
                     .group('albums.id')
                     .order('COUNT(favorites.id) DESC')
                     .page(params[:page])
    else
      @albums = Album.where(user_id: current_user.id).order(created_at: :desc).page(params[:page])
    end
  end
  
  def entrance
    @recent_entry = Album.order(created_at: :desc).first
    comments = Comment.order(album_id: :asc, created_at: :desc).to_a.uniq(&:album_id)
    @new_comments = Comment.where(id: comments.map(&:id))
    @album_all = Album.all
    @display_mode = params[:display_mode] || 'recent' # デフォルトは最新
     @most_favorites = Album.joins(:favorites)
                            .group('albums.id')
                            .order('COUNT(favorites.id) DESC')
                            .first
  end
  
  def f_albums
    @favorites = current_user.favorites.includes(:album)
  
    # 並べ替え処理
    case params[:sort]
    when 'newest'
      @favorites = @favorites.order(created_at: :desc)
    when 'oldest'
      @favorites = @favorites.order(created_at: :asc)
    else
      @favorites = @favorites.order(created_at: :desc) # デフォルトは新しい順
    end
  
    # ページネーション
    @favorites = @favorites.page(params[:page])
  end
  
  def f_pets
    @favorites = current_user.pet_favorites.includes(:pet)
  
    # 並べ替え処理
    case params[:sort]
    when 'newest'
      @favorites = @favorites.order(created_at: :desc)
    when 'oldest'
      @favorites = @favorites.order(created_at: :asc)
    else
      @favorites = @favorites.order(created_at: :desc) # デフォルトは新しい順
    end
  
    # ページネーション（必要な場合）
    @favorites = @favorites.page(params[:page]) if defined?(Kaminari)
  end
  
  
  def save
    page_number = params[:page].present? ? params[:page] : 1
    @can_users = User.where(hope: 2).page(page_number).per(10).order(created_at: :desc)
    @need_pets = Pet.where(need_help: true).page(page_number).per(10).order(created_at: :desc)
  end  
  
  def guide
    
  end
  
  private
  
  def ensure_guest_user
    if current_user&.guest_user?
      redirect_back(fallback_location: root_path, notice: "ゲストユーザーはこの機能をご利用いただけません。")
    end
  end  
  
  
end
