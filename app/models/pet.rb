class Pet < ApplicationRecord
  has_one_attached :image
  belongs_to :category
  belongs_to :user
  has_many :pet_favorites, dependent: :destroy
  has_many :album, dependent: :destroy
  enum gender: { male: 1, female: 2}

  validates :name, presence: { message: "の入力は必須です" }, length: {minimum: 1, maximum: 15}
  validates :gender, presence: { message: "の入力は必須です" }
  validates :age, presence: { message: "の入力は必須です" }


  def self.search_for(content,method)
    if method == 'perfect'
      Pet.where(title: content)
    elsif method == 'forward'
      Pet.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Pet.where('name LIKE ?', '%' + content)
    else
      PEt.where('name LIKE ?', '%' + content + '%')
    end
  end  


end
