class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :album
  
  validates :body, presence: { message: "の入力は必須です" },length: { minimum: 2, maximum: 100 }, format: { without: /\A\s*\z/, message: "空白だけのコメントは許可されていません" }
  
  ##以下はタブーの設定です。
  validate :body_cannot_contain_blacklist_words

  def body_cannot_contain_blacklist_words
    blacklist = ['fuck', 'pussy','おまんこ','死','殺','ちんこ']
    if body.present? && blacklist.any?{ |word| body.include?(word) }
      errors.add(:contain_blacklist_words, ": 禁止単語が含まれています。")
    end
  end
  
  
end
