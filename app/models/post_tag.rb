class PostTag < ApplicationRecord
  belongs_to :post_summary
  belongs_to :tag
end
