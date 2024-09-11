class Public::GroupChatsController < ApplicationController
before_action :authenticate_user!
before_action :ensure_guest_user, only: [:create,:destroy]

  def create
    @group = Group.find(params[:group_id])
    @group_chat = @group.group_chat.create(group_chat_params)
    redirect_to group_path(@group)
  end

  def destroy
    group_chat = GroupChat.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def ensure_guest_user
    # @user = User.find(params[:id])
    if current_user&.guest_user?
    redirect_back(fallback_location: root_path, notice: "ゲストユーザーはチャットできません。")
    end
  end 
  
end
