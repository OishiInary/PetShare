class Public::UsersController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]
  
  def unsubscribe
  end
  
  def index
    
  end

  def show
     @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "更新に成功しました"
      redirect_to mypage_path
    else
      flash[:notice] = "更新に失敗しました"
      @user = current_user
      redirect_back(fallback_location: root_path)
    end
  end
  
  def withdraw
    @user = user_customer
    #is_deletedカラムをtrueに変更する
    @user.update(is_active: false)
    #ログアウトさせる
    reset_session
    redirect_to root_path
  end  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :gender, :birthday, :post_code, :hope, :phone, :address, :email)
  end
end
