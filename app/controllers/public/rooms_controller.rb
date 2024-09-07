class Public::RoomsController < ApplicationController
before_action :authenticate_user!
before_action :ensure_guest_user, only: [:create,:show]

  def create
  end

  def show
  end
  
  private
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはこの画面へ遷移できません。"
    end
  end  
  
end
