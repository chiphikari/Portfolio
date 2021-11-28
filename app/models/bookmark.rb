class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :post_summary

  validates :user_id, presence: true
  validates :post_summary_id, uniqueness: { scope: :user_id }, presence: true
end
