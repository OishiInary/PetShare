class Public::PetsController < ApplicationController
before_action :authenticate_user!,except: [:show]
  def new
    @pet = Pet.new
  end
  
  def create
    @pet = Pet.new(pet_params)
    @pet.user_id = current_user.id
    @pet.save
   redirect_to mypage_path
  end
  
  def index
    @pets  = Pet.where(user_id: current_user)

  end  
  
  def show
    @pet = Pet.find(params[:id])
    @user = @pet.user
  end
  
  def edit
    @pet = Pet.find(params[:id])
  end
  
  def update
  end
  
  def destroy
    @pet = Pet.find(params[:id])
    @pet.destroy
    render :index
  end
  
  
  
  
  private
  
  def pet_params
    params.require(:pet).permit(:name, :image, :gender, :age, :category_id, :user_id)
  end
  
end
