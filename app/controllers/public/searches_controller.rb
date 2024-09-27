class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    page_number = params[:page].present? ? params[:page] : 1
    # 選択したモデルに応じて検索を実行
    if @model == "user"
      @records = User.search_for(@content, @method).page(page_number).per(10).order(created_at: :desc)
    elsif @model == "album"
      @records = Album.search_for(@content, @method).page(page_number).per(10).order(created_at: :desc)
    elsif @model == "pet"
      @records = Pet.search_for(@content, @method).page(page_number).per(10).order(created_at: :desc)
    else
      @records = Album.tag_search_for(@content, @method)
      # 配列であれば、sort_byでソートし、paginate_arrayでページネーションを適用
      @records = Kaminari.paginate_array(@records.sort_by { |record| record.created_at }.reverse).page(page_number).per(10) if @records.is_a?(Array)
    end
  end
end
