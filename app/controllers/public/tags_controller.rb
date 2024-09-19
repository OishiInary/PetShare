class Public::TagsController < ApplicationController

    def show
    @tag_list = Tag.all               # こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:id])  # クリックしたタグを取得
    @albums = @tag.albums.all           # クリックしたタグに紐付けられた投稿を全て表示
    end

end
