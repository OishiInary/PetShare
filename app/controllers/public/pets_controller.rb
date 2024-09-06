class Public::PetsController < ApplicationController
before_action :authenticate_user!,except: [:show]
before_action :ensure_correct_user, only: [:edit, :update]
  def new
    @pet = Pet.new
  end
  
  def create
    @pet = Pet.new(pet_params)
    @pet.user_id = current_user.id
    if @pet.save
      redirect_to pets_path
    else
      @pet = Pet.new
      redirect_back(fallback_location: root_path)
    end
  end
  
  def index
    @pets  = Pet.where(user_id: current_user)
  end  
  
  def show
    @pet = Pet.find(params[:id])
  end
  
  def edit
    @pet = Pet.find(params[:id])
  end
  
  def update
    @pet = Pet.find(params[:id])
    if @pet.update(pet_params)
      flash[:notice] = "更新に成功しました"
      redirect_to pets_path(@pet.id)
    else
      flash[:notice] = "更新に失敗しました"
      @pet = Pet.find(params[:id])
      redirect_back(fallback_location: root_path)
    end
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
  
  
    def ensure_correct_user
      @pet = Pet.find(params[:id])
      @user = User.find(@pet.user.id)
      unless @user == current_user
        redirect_to mypage_path
      end
    end
end
