class Group < ApplicationRecord

  validates :name, presence: { message: "の入力は必須です" },uniqueness: true
  validates :introduction, presence: { message: "の入力は必須です" }
  validates :owner_, presence: { message: "の入力は必須です" }
  
  
    has_many :group_users, dependent: :destroy
    has_many :users, through: :group_users, dependent: :destroy
end
