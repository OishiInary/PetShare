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
    elsif @model == "tag"
      @records = Album.tag_search_for(@content, @method)
      # @recordsが配列の場合のみpaginate_arrayを使用する
      if @records.is_a?(Array)
        @records = Kaminari.paginate_array(@records).page(page_number).per(10)
      else
        @records = @records.page(page_number).per(10)
      end
    else
      @records = []
    end
  end
end
