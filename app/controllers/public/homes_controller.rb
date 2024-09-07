class Public::HomesController < ApplicationController
before_action :authenticate_user!, except: [:top, :about, :entrance, :save]
 before_action :ensure_guest_user, only: [:mypage,:follow_list,:my_album,]
  def top
  end  
  
  def about
  end  
  
  def mypage
    today = Date.today
    @age = today.year - current_user.birthday.year
  end  
  
  def follow_list
    @followings = User.find(current_user.followings.ids)
    @followers = User.find(current_user.followers.ids)
  end

  def my_album
    @albums = Album.where(user_id: current_user)
  end
  
  def entrance
    @recentry = Album.order(created_at: :desc).first
  end
  
  def save
    # @req_users = User.find(user.hope == 1)
    # @can_users = User.find(user.hope == 2)
  end  
  
  private
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  
  
  
end
