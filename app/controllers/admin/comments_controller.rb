class Admin::CommentsController < ApplicationController

  def destroy
     @comment = Comment.find_by(id: params[:id], album_id: params[:album_id])
     @comment.destroy
     @album = Album.find(params[:album_id])
  end
  
end
