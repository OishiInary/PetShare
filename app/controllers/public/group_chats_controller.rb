class Public::GroupChatsController < ApplicationController
before_action :authenticate_user!
before_action :ensure_guest_user, only: [:create,:destroy]
before_action :group_user?, only: [:create]
  def create
    @group = Group.find(params[:group_id])
    @group_chat = GroupChat.new(group_chat_params)
    @group_chat.user_id = current_user.id
    @group_chat.group_id = @group.id
    @group_chat.save
    redirect_to group_path(@group),notice: '送信しました。'
  end

  def destroy
    @group = Group.find(params[:group_id])
    @group_chat = GroupChat.find_by(id: params[:id], group_id: params[:group_id])
    @group_chat.destroy
    redirect_to group_path(@group),notice: '削除しました。'
  end
  
  private
  
  def group_user?
    @group = Group.find(params[:group_id])
    @group_users = GroupUser.where(group_id: @group.id)
  if @group_users.exists?(user_id: current_user.id)
    # グループにユーザーが含まれている場合の処理
  else
    redirect_back(fallback_location: root_path, notice: "参加すればチャットできます。")
  end
end
  
  def group_chat_params
    params.require(:group_chat).permit(:message,:user_id,:group_id)
  end
  
  def ensure_guest_user
    # @user = User.find(params[:id])
    if current_user&.guest_user?
    redirect_back(fallback_location: root_path, notice: "ゲストユーザーはチャットできません。")
    end
  end 
  
end
