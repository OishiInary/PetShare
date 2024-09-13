class Admin::GroupsController < ApplicationController
before_action :authenticate_admin!
    
  def index
      @group_lists = Group.all
  end
    
  def show
      @group = Group.find(params[:id])
      @group_users = GroupUser.where(group_id: @group.id)
      @group_chats = GroupChat.where(group_id: @group.id)
      @group_chat = GroupChat.new
  end 
    
  def edit
      @group = Group.find(params[:id])
  end
    
  def update
      @group = Group.find(params[:id])
      if @group.update(group_params)
          redirect_to admin_group_path(@group), notice: 'グループを更新しました。'
      else
          render :edit
      end
  end 
    
  def destroy
      delete_group = Group.find(params[:id])
      if delete_group.destroy
          redirect_to admin_groups_path, notice: 'グループを削除しました。'
      end
  end
    
    private
    
    
      def group_params
      params.require(:group).permit(:name,:owner_id,:introduction,:group_image)
  end
    
end
