class Pet < ApplicationRecord
  has_one_attached :image
  belongs_to :category
  belongs_to :user
  has_many :pet_favorites, dependent: :destroy

  enum gender: { male: 1, female: 2}

  validates :name, presence: { message: "の入力は必須です" }, length: {minimum: 1, maximum: 15}
  validates :gender, presence: { message: "の入力は必須です" }
  validates :age, presence: { message: "の入力は必須です" }

end
