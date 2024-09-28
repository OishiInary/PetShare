class Public::PetsController < ApplicationController
before_action :authenticate_user! 
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
    @pet = Pet.find_by(id: params[:id])
    if @pet.nil?
      redirect_to pets_path, notice: "ペットが見つかりませんでした。"
      return
    end
  
    @pet = Pet.find(params[:id])
    @pet_albums = Album.where(pet_id: @pet.id)
    @favorites = @pet.pet_favorites.count
    @total_pets = Pet.count
    # お気に入りの数が多い順に並べて、現在のペットのランキングを計算
    @rank = Pet.joins(:pet_favorites)
               .group('pets.id')
               .order('COUNT(pet_favorites.id) DESC')
               .pluck('pets.id')
  
    if @rank.include?(@pet.id)
      @rank_position = @rank.index(@pet.id) + 1
    else
      @rank_position = @rank.size + 1 # 他のペットが全てお気に入りがある場合、最下位扱い
    end
  end

  def index
    @pets = Pet.all

    # 並び替えの処理
    case params[:sort]
    when 'newest'
      @pets = @pets.order(created_at: :desc)
    when 'oldest'
      @pets = @pets.order(created_at: :asc)
    when 'favorites'
      @pets = @pets.left_joins(:pet_favorites).group(:id).order('COUNT(pet_favorites.id) DESC')
    end

    @pets = @pets.page(params[:page])
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
    params.require(:pet).permit(:name, :image, :gender, :age, :category_id, :user_id,:need_help)
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
