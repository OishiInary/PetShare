class Public::PetsController < ApplicationController
before_action :authenticate_user!,except: [:index, :show]
  def new
    @pet = Pet.new
  end
  
  def create
    @pet = Pet.new(pet_params)
    @pet.user_id = current_user.id
    @pet.save
   redirect_to pet_path(@pet.id)
  
  def index
    @pets = Pet.all
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
  
  def pets_params
    params.require(:pets).permit(:name,:image,:age,:breed)
  end
end
