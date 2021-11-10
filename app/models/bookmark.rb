class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :post_summary

  # 重複の投稿を防ぐ
  validates :user_id, uniqueness: {scope: :post_summary_id}
end
