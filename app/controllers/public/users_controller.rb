class Public::UsersController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]
before_action :ensure_correct_user, only: [:edit, :update]
before_action :set_user, only: [:show,:followings, :followers]
before_action :ensure_guest_user, only: [:follow_list,:unsubscribe,:edit]
before_action :current_my_page, only: [:show]

  def unsubscribe
  end

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
    @user = current_user
    #is_deletedカラムをtrueに変更する

    @user.update(is_active: false)
    #ログアウトさせる
    reset_session
    redirect_to new_user_registration_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :gender, :birthday, :post_code, :hope, :phone, :address, :email, :image, :is_active, :password)
  end

  def current_my_page
    @user = User.find(params[:id])
    if @user == current_user
      redirect_to mypage_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def ensure_guest_user
    if current_user&.guest_user?
      redirect_back(fallback_location: root_path, notice: "ゲストユーザーはご利用いただけません。")
    end
  end

end