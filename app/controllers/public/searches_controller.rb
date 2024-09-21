class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    
    # 選択したモデルに応じて検索を実行
    if @model  == "user"
      @records = User.search_for(@content, @method)
    elsif @model  == "album"
      @records = Album.search_for(@content, @method)
    elsif @model == "pet"
      @records = Pet.search_for(@content, @method)
    else 
      @records = Album.tag_search_for(@content, @method)
    end
  end
end