class Public::HomesController < ApplicationController
before_action :authenticate_user!, except: [:top, :about, :entrance, :save]
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
  end
  
  def f_albums
    @favorites = current_user.favorites.includes(:album).order(created_at: :desc)
  end
  
  def f_pets
    @favorites = current_user.pet_favorites.includes(:pet).order(created_at: :desc)
  end
  
  
  def save
    @can_users = User.where(hope: 2)
    @need_pets = Pet.where(need_help: true)
  end  
  
  private
  
  def ensure_guest_user
    if current_user&.guest_user?
      redirect_back(fallback_location: root_path, notice: "ゲストユーザーはこの機能をご利用いただけません。")
    end
  end  
  
  
end
