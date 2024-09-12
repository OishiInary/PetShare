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
        if @user.update(user_params)
          flash[:notice] = "更新に成功しました"
          redirect_to admin_users_path
        else
          flash[:notice] = "更新に失敗しました"
          @user = current_user
            redirect_to admin_users_path
        end
    end 


    private
    
    
  def user_params
    params.require(:user).permit(:name, :introduction, :gender, :birthday, :post_code, :hope, :phone, :address, :email, :image, :is_active,:password)
  end


end
