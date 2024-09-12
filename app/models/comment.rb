class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :album
  
  validates :body, presence: { message: "の入力は必須です" },length: { minimum: 2, maximum: 100 }
end
