class Public::CommentsController < ApplicationController
before_action :authenticate_user!

  def create
    @album = Album.find(params[:album_id])
    @comment = @album.comments.create(comment_params)
    redirect_to album_path(@album)
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :user_id, :album_id)
    end
end
