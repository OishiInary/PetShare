class Album < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :pet
  
  has_many :album_tags, dependent: :destroy
  has_many :tags, through: :album_tags
  has_many :view_counts, dependent: :destroy
  
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :week_favorites, -> {where(created_at: 1.week.ago.beginning_of_day..Time.current.end_of_day) }
  validates :title, presence: { message: "の入力は必須です" },length: { minimum: 1, maximum: 10 }
  validates :body, presence: { message: "の入力は必須です" },length: { minimum: 1, maximum: 200 }
  
  
    # album.コントローラで使うメソッドの定義
  def save_tag(sent_tags)
    # createしたalbumに紐づいているtagがある場合 tagのnameを配列として取得
    # current_tags = self.tags(:name) unless self.tags.nil?
    current_tags = self.tags unless self.tags.nil?
    # 取得したalbumに存在するtagから送信されてきたtagを除いたtagをold_tagsとして定義する
    old_tags = current_tags - sent_tags
      # 送信されてきたtagから、すでに存在するtagを除いたtagをnew_tagsとする
    new_tags = sent_tags - current_tags
    
    # old_tagsの中に入れてタグをそれぞれselfでdeleteする
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name :old)
    end
    # このtagsの中にnew扱いされたtagをいれる
    new_tags.each do |new|
      new_album_tag = Tag.find_or_create_by(name: new)
      self.tags << new_album_tag
    end
  end
  
  
  # 検索機能用
  def self.search_for(content, method)
    if method == 'perfect'
      Album.where(title: content)
    else
      Album.where('title LIKE ?', '%' + content + '%')
    end
  end
  
def self.tag_search_for(content, method)
  if method == 'perfect'
    tag = Tag.find_by(name: content)
    tag ? tag.albums : Album.none
  else
    tag = Tag.find_by('name LIKE ?', '%' + content + '%')
    tag ? tag.albums : Album.none
  end
end
  
  # お気に入りの重複確認
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end 
  # アルバム用の画像取得処理
  def get_album_image
    (image.attached?) ? image : '/no_image.jpg'
  end
end
