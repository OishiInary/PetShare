class Admin::GroupChatsController < ApplicationController
  
  def destroy
    @group = Group.find(params[:group_id])
    @group_chat = GroupChat.find_by(id: params[:id], group_id: params[:group_id])
    @group_chat.destroy
    redirect_to admin_group_path(@group),notice: '削除しました。'
  end
  
end
