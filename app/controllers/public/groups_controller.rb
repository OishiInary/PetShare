class Public::GroupsController < ApplicationController
before_action :authenticate_user!
before_action :set_group, only: [:edit, :update]
before_action :ensure_guest_user, only: [:new,:edit, :destroy]

  def index
      @group_lists = Group.all
      # @group_joining = GroupUser.where(user_id: current_user.id)
      @user = current_user
      @group_joining = current_user.group_user.includes(:group)
      @group_lists_none = "グループに参加していません。"
  end
  
  def new
      @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      group_user = current_user.group_user.new(group_id: @group.id)
      group_user.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end
  
  def show
      @group = Group.find(params[:id])
      @group_users = GroupUser.where(group_id: @group.id)
      @group_chats = GroupChat.where(group_id: @group.id).order(created_at: :desc).page(params[:page])
      @group_chat = GroupChat.new
  end

  def edit
      @group = Group.find(params[:id])
  end

  def update
      @group = Group.find(params[:id])
      if @group.update(group_params)
          redirect_to group_path(@group), notice: 'グループを更新しました。'
      else
          render :edit
      end
  end

  def destroy
      delete_group = Group.find(params[:id])
      if delete_group.destroy
          redirect_to groups_path, notice: 'グループを削除しました。'
      end
  end


  private
  
  def set_group
      @group = Group.find(params[:id])
  end

  def group_params
      params.require(:group).permit(:name,:owner_id,:introduction,:group_image)
  end
  
  def ensure_guest_user
    if current_user&.guest_user?
      redirect_back(fallback_location: root_path, notice: "ゲストユーザーはグループ作成・参加ができません。")
    end
  end
end
