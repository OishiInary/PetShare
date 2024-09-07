class Public::GroupChatsController < ApplicationController
before_action :authenticate_user!
before_action :ensure_guest_user, only: [:create,:destroy]

  def create
  end

  def destroy
  end
  
  private
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
    redirect_to user_path(current_user) , notice: 'ゲストユーザーはチャットできません。'
    end
  end 
  
end
