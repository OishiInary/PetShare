class Group < ApplicationRecord

  validates :name, presence: { message: "の入力は必須です" }
  validates :introduction, presence: { message: "の入力は必須です" }
  validates :owner_, presence: { message: "の入力は必須です" }
end
