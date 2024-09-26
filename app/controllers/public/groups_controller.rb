class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:new, :edit, :destroy]

  def index
    @user = current_user
    @group_joining = @user.group_users.includes(:group)
    @group_lists_none = "グループに参加していません。"

    sort_column = params[:sort] || 'created_at'
    sort_direction = params[:direction] || 'asc'
    
    @group_lists = Group.left_joins(:group_users)
                        .select('groups.id, groups.name, COUNT(group_users.id) AS user_count')
                        .group('groups.id, groups.name')



    # 検索機能の追加
    if params[:search].present?
      @group_lists = @group_lists.where("groups.name LIKE ?", "%#{params[:search]}%")
    end

    case sort_column
    when 'created_at'
      @group_lists = @group_lists.order("groups.created_at #{sort_direction}")
    when 'user_count'
      @group_lists = @group_lists.order("user_count #{sort_direction}")
    else
      @group_lists = @group_lists.order("groups.created_at #{sort_direction}")
    end
  end
  
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner = current_user # owner_idではなくownerオブジェクトを設定
    if @group.save
      current_user.group_users.create(group: @group) # グループユーザーの作成
      redirect_to group_path(@group), notice: 'グループが作成されました。'
    else
      render :new
    end
  end
  
  def show
    @group = Group.find(params[:id])
    @group_users = @group.group_users.includes(:user) # ユーザー情報もロード
    page_number = params[:page].present? ? params[:page] : 1
    @group_chats = @group.group_chats.page(page_number).order(created_at: :desc).per(5)
    @group_chat = GroupChat.new
  end

  def edit; end

  def update
    if @group.update(group_params)
      redirect_to group_path(@group), notice: 'グループを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    if Group.find(params[:id]).destroy
      redirect_to groups_path, notice: 'グループを削除しました。'
    end
  end

  private
  
  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image) # owner_idは不要
  end
  
  def ensure_guest_user
    if current_user&.guest_user?
      redirect_back(fallback_location: root_path, notice: "ゲストユーザーはグループ作成・参加ができません。")
    end
  end
end
