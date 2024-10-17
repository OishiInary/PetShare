class Tag < ApplicationRecord
  
  # アルバムタグを中間とした多対多のアソシエーション
  has_many :album_tags, dependent: :destroy
  has_many :albums, through: :album_tags
  
  # 文字数制限
  validates :name, presence: true ,length: { minimum: 1, maximum: 10 },uniqueness: true
end
