class AlbumTag < ApplicationRecord
  # この中間テーブルはアルバムとタグをつないでいる
  belongs_to :tag
  belongs_to :album
  
  
  validates :album_id, presence: true
  validates :tag_id, presence: true
end
