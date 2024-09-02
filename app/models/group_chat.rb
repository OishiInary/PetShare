class GroupChat < ApplicationRecord

  belongs_to :user
  belongs_to :group

  validates :chat, presence: { message: "の入力は必須です" }

end
