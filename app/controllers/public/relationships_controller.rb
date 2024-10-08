class Public::RelationshipsController < ApplicationController
before_action :authenticate_user!
before_action :ensure_guest_user, only: [:create,:destroy,:followings,:followers] 


  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to request.referer
  end
  
  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to request.referer
  end
  
  def followings
    user = User.find(params[:user_id])
    @followings = user.followings
  end
  
  def followers
    user = User.find(params[:user_id])
    @followers = user.followers
  end
  
  private
  
  def ensure_guest_user
    if current_user&.guest_user?
      redirect_back(fallback_location: root_path, notice: "ゲストユーザーにはフォロー権限がありません。")
    end
  end 
  
end
