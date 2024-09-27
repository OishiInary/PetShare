class Admin::TagsController < ApplicationController
  before_action :set_tag, only: [:destroy]
  
  def index
    @tags = Tag.all
  end
  
  def destroy
    if @tag.destroy
      flash[:notice] = "タグを削除しました。"
    else
      flash[:alert] = "タグの削除に失敗しました。"
    end
    redirect_to admin_tags_path
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end
end
