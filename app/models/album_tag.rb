class AlbumTag < ApplicationRecord
  # この中間テーブルはアルバムとタグをつないでいる
  belongs_to :tag
  belongs_to :album
  
end
