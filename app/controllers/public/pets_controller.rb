class Public::PetsController < ApplicationController
before_action :authenticate_user! ,except: [:show]
before_action :ensure_correct_user, only: [:edit, :update]
before_action :ensure_guest_user, only: [:new,:create,:edit,:update,:destroy]

  def new
    @pet = Pet.new
  end
  
  def create
    @pet = Pet.new(pet_params)
    @pet.user_id = current_user.id
    if @pet.save
      flash[:notice] = "登録しました"
      redirect_to pet_path(@pet)
    else
      @pet = Pet.new
      flash[:notice] = "登録に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end
  
  def show
    @pet = Pet.find(params[:id])
    @favorites = Favorite.where(album_id: @pet.album_ids).count
  end
  
  def index
    @pets  = Pet.all
  end  
  

  
  def edit
    @pet = Pet.find(params[:id])
  end
  
  def update
    @pet = Pet.find(params[:id])
    if @pet.update(pet_params)
      flash[:notice] = "更新に成功しました"
      redirect_to pet_path(@pet.id)
    else
      flash[:notice] = "更新に失敗しました"
      @pet = Pet.find(params[:id])
      redirect_back(fallback_location: root_path)
    end
  end
  
  def destroy
    @pet = Pet.find(params[:id])
    @pet.destroy
    redirect_to my_pet_path
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
    
  def ensure_guest_user
    if current_user&.guest_user?
      redirect_back(fallback_location: root_path, notice: "ゲストユーザーはご利用いただけません。")
    end
  end  
end
