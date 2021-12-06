class PostTag < ApplicationRecord
  belongs_to :post_summary
  belongs_to :tag

  validates :post_summary_id, presence: true
  validates :tag_id, presence: true

end
