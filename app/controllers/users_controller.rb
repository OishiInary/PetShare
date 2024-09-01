class UsersController < ApplicationController
  def index
    
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    
  end
  
  def update
    
  end
  
  
  private
  
  def user_params
    params.require(:user).parmit(:name, :introduction, :gender, :birthday, :postcode, :phone, :password, :address, :email)
  end
end
