class PostSummary < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :favorites, dependent: :destroy

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

  # validates :title, presence: true
  # validates :headline, presence: true
  # validates :introduction, presence: true
  # validates :category, presence: true

  enum category: {
    動画・映画: 0,
    本・書籍: 1,
    その他: 2,
    隠れおすすめスポット: 3,
    隠れ喫茶店: 4,
    おすすめ散歩: 5
  }

end
