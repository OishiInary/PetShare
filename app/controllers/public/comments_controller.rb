class Public::CommentsController < ApplicationController
before_action :authenticate_user!
before_action :ensure_guest_user, only: [:create]

  def create
    @album = Album.find(params[:album_id])
    @comment = @album.comments.create(comment_params)
    @comment.score = Language.get_data(comment_params[:body])
    if @comment.save
      page_number = params[:page].present? ? params[:page] : 1
      @comments = @album.comments.page(page_number).order(created_at: :desc).per(5)
    else
      flash[:alert] = "コメント投稿に失敗しました。空文字投稿は出来ません。"
     redirect_to album_path(@album)
    end
    # redirect_to album_path(@album)
  end

  def destroy
     @comment = Comment.find_by(id: params[:id], album_id: params[:album_id])
     @comment.destroy
     @album = Album.find(params[:album_id])
     page_number = params[:page].present? ? params[:page] : 1
     @comments = @album.comments.page(page_number).order(created_at: :desc).per(5)
  end
  
  
  private
  def comment_params
    params.require(:comment).permit(:body, :user_id, :album_id, :score)
  end
    
  def ensure_guest_user
    @album = Album.find(params[:album_id])
    if current_user&.guest_user?
      redirect_back(fallback_location: root_path, notice: "ゲストユーザーはコメントできません。")
    end
  end 
end