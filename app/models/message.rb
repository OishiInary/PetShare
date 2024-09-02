class Message < ApplicationRecord

  belongs_to :user
  belongs_to :room
  validates :message, presence: { message: "の入力は必須です" }, length: { maximum: 140 }

end
