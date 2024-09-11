class Public::GroupUsersController < ApplicationController
before_action :authenticate_user!
before_action :ensure_guest_user, only: [:create,:destroy]

  def create
    group_user = current_user.group_users.new(group_id: params[:group_id])
    group_user.save
    redirect_to request.referer
  end

  def destroy
    # 参考に省略形を書いたがうまくいかない
      group_user = current_user.group_user.find_by(group_id: params[:group_id])
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
