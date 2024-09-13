class Admin::GroupUsersController < ApplicationController


  def destroy
    @user = User.find(params[:id])
    @group = Group.find(params[:group_id])
    @group_user = GroupUser.find_by(user_id: @user.id, group_id: @group.id)
    if @user.id == @group.owner.id
      redirect_back(fallback_location: root_path, notice: "グループ制作者は脱退させられません。")
    
    else
      @group_user.destroy
      # group_user = @user.group_user.find_by(group_id: params[:id])
      # group_user.destroy
    redirect_to request.referer
    end
  end
end
