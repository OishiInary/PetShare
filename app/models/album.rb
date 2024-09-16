class Album < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :pet
  has_many :album_tags
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :week_favorites, -> {where(created_at: 1.week.ago.beginning_of_day..Time.current.end_of_day) }
  validates :title, presence: { message: "の入力は必須です" },length: { minimum: 2, maximum: 10 }
  validates :body, presence: { message: "の入力は必須です" },length: { minimum: 1, maximum: 200 }
  
  
  def self.search_for(content, method)
    if method == 'perfect'
      Album.where(name: content)
    elsif method == 'forward'
      Album.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Album.where('name LIKE ?', '%' + content)
    else
      Album.where('name LIKE ?', '%' + content + '%')
    end
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end 
  
  def get_album_image
    (image.attached?) ? image : '/no_image.jpg'
  end
  
  
  # def self.last_week #週間でいいねが高いランキングを作る
  #   Album.joins(:favorites).where(favorites: { created_at: 0.days.ago.prev_week..0.days.ago.prev_week(:sunday) }).group(:id).order(Arel.sql('COUNT(*) DESC'))
  # end
end
