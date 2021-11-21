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

  validates :title, length: { maximum: 50 }, presence: true
  validates :headline, length: { maximum: 50 }, presence: true
  validates :introduction, length: { maximum: 200 }, presence: true
  validates :category, presence: true

  enum category: {
    動画・映画: 0,
    本・書籍: 1,
    アクティビティ: 2,
    隠れおすすめスポット: 3,
    隠れ喫茶店: 4,
    おすすめ散歩: 5
  }

  def save_tag(tags)
    # 現在存在するタグの取得
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

   old_tags.each do |old|
    tag = Tag.find_by(tag_name: old)
    # 合致した中間テーブルの組み合わせごと削除
     PostTag.where(tag_id: tag.id, post_summary_id: self.id).destroy_all
      if PostTag.where(tag_id: tag.id).blank?
        # 中間テーブルに例：＃ccがなければ削除する
        tag.destroy
      end
    end

    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_post_tag
    end
  end

  def avg_score
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f
    else
      0.0
    end
  end

end
