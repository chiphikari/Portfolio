class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post_summary
  validates :score, presence: true
  validates :content, length: { maximum: 50 }

  validates :user_id, presence: true
  validates :post_summary_id, presence: true
end
