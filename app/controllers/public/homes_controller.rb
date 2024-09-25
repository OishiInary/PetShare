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
    @albums = Album.where(user_id: current_user).page(params[:page])
  end
  
  def entrance
    @recentry = Album.order(created_at: :desc).first
    # @new_comment_albums = Album.joins(:comments).order('comments.created_at DESC').limit(5)
    # @new_comments = Comment.order(created_at: :desc).limit(5)
    comments = Comment.order(album_id: :asc, created_at: :desc).to_a.uniq(&:album_id)
    @new_comments = Comment.where(id: comments.map(&:id))
    @album_all = Album.all
  end
  
  def f_albums
    @favorites = current_user.favorites.includes(:album).order(created_at: :desc)
  end
  
  def f_pets
    @favorites = current_user.pet_favorites.includes(:pet).order(created_at: :desc)
  end
  
  
  def save
    page_number = params[:page].present? ? params[:page] : 1
    @can_users = User.where(hope: 2).page(page_number).per(10).order(created_at: :desc)
    @need_pets = Pet.where(need_help: true).page(page_number).per(10).order(created_at: :desc)
  end  
  
  private
  
  def ensure_guest_user
    if current_user&.guest_user?
      redirect_back(fallback_location: root_path, notice: "ゲストユーザーはこの機能をご利用いただけません。")
    end
  end  
  
  
end
