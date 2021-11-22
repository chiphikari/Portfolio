class CreatePostSummaries < ActiveRecord::Migration[5.2]
  def change
    create_table :post_summaries do |t|
      t.references :user, type: :bigint, null: false, foreign_key: true
      # post_house_id, post_outside_idがnilになり、以下なくとも親であるpost_summaryが認識してくれているのでなくてもOK
      # t.references :post_house, null: false, foreign_key: true
      # t.references :post_outside, null: false, foreign_key: true
      t.string :title, null: false
      t.string :headline, null: false
      t.text :introduction, null: false
      t.integer :category, null: false

      t.timestamps
    end
  end
end
