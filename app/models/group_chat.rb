class GroupChat < ApplicationRecord
  belongs_to :user
  belongs_to :group
  
  validates :message, presence: { message: "の入力は必須です" },length: { minimum: 2, maximum: 100 }, format: { without: /\A\s*\z/, message: "空白だけのコメントは許可されていません" }
end
