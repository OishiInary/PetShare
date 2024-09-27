class Admin::UsersController < ApplicationController
before_action :authenticate_admin!
    
    def follow_list
      @followings = @user.followings
      @followerds = @user.followerd
    end
    
    def index
      @users = User.all
    end
    
    def show
    @user = User.find(params[:id])
    @pets = @user.pets
    today = Date.today
    @age = today.year - @user.birthday.year
    end  
    
    def edit
        @user = User.find(params[:id])
    end

  def update
    @user = User.find(params[:id])
  
    # パスワードが空の場合はパスワード関連のフィールドを削除
    if user_params[:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    
    if @user.update(user_params)
      flash[:notice] = user_params[:password].present? ? "パスワードが更新されました" : "更新に成功しました"
      redirect_to admin_user_path(@user)
    else
      flash[:alert] = "更新に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end


   


    private
    
    

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :introduction, :post_code, :address, :phone, :hope, :gender, :birthday, :is_active) # 必要な属性を追加
  end

end
