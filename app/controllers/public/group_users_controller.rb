class Public::GroupUsersController < ApplicationController
before_action :authenticate_user!
before_action :ensure_guest_user, only: [:create,:destroy]

  def create
    # group_user = current_user.group_users.new(group_id: params[:group_id])
    # group_user.save
    @group = Group.find(params[:group_id])
    @group_user = GroupUser.new
    @group_user.user_id = current_user.id
    @group_user.group_id = @group.id
    @group_user.save
     redirect_to request.referer
  end

  def destroy
      group_user = current_user.group_users.find_by(group_id: params[:group_id])
      group_user.destroy
    redirect_to request.referer
  end
  
  private

  def ensure_guest_user
    if current_user&.guest_user?
      redirect_back(fallback_location: root_path, notice: "ゲストユーザーは参加ができません。")
    end
  end

end
