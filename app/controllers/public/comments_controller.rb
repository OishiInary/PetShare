class Public::CommentsController < ApplicationController
before_action :authenticate_user!
before_action :ensure_guest_user, only: [:create]

  def create
    @album = Album.find(params[:album_id])
    @comment = @album.comments.create(comment_params)
    redirect_to album_path(@album)
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :user_id, :album_id)
  end
    
  def ensure_guest_user
    @album = Album.find(params[:album_id])
    if current_user&.guest_user?
      redirect_back(fallback_location: root_path, notice: "ゲストユーザーはコメントできません。")
    end
  end 
end
