class PostSummary < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  has_one :post_house, dependent: :destroy
  accepts_nested_attributes_for :post_house

  has_one :post_outside, dependent: :destroy
  accepts_nested_attributes_for :post_outside

  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image, append: true

  # 既にブックマークしていないか検証
  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

  # 既にいいねしていないか検証
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  validates :title, presence: true
  validates :headline, presence: true
  validates :introduction, presence: true
  validates :category, presence: true

  enum category: {
    動画・映画: 0,
    本・書籍: 1,
    その他: 2,
    隠れおすすめスポット: 3,
    隠れ喫茶店: 4,
    おすすめ散歩: 5
  }

  def save_post_summaries(tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    # 今postが持っているタグと今回保存されたものの差を既にあるタグとし、古いタグは消す
    old_tags = current_tags - tags
    # 今回保存されたものと現在の差を新しいタグとし、新しいタグは保存
    new_tags = tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name: old_name)
    end

    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(tag_name: new_name)
      # 配列に保存
      self.tags << post_tag
    end
  end
end
