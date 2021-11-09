class PostImage < ApplicationRecord
  belongs_to :post_summary
  attachment :image

end
