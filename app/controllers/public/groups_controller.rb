class Public::GroupsController < ApplicationController
before_action :authenticate_user!, except: [:index]
before_action :set_group, only: [:edit, :update]
before_action :ensure_guest_user, only: [:new,:edit, :destroy]
  def index
      @group_lists = Group.all
      @group_joining = GroupUser.where(user_id: current_user.id)
      @group_lists_none = "グループに参加していません。"
  end

  def new
      @group = Group.new
      @group.users << current_user
  end

  def create
      @group = Group.new(group_params)
      @group.owner_id = current_user.id
      if @group.save
          redirect_to groups_url, notice: 'グループを作成しました。'
      else
          render :new
      end
  end

  def show
      @group = Group.find(params[:id])
  end

  def edit
      @group = Group.find(params[:id])
  end

  def update
      @group = Group.find(params[:id])
      if @group.update(group_params)
          redirect_to groups_path, notice: 'グループを更新しました。'
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
      params.require(:group).permit(:name, user_ids:[])
  end
  
  def ensure_guest_user
    if current_user&.guest_user?
      redirect_back(fallback_location: root_path, notice: "ゲストユーザーはグループ作成・参加ができません。")
    end
  end
end
