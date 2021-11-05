class CreatePostSummaries < ActiveRecord::Migration[5.2]
  def change
    create_table :post_summaries do |t|
      t.references :user, foreign_key: true
      t.references :post_house, foreign_key: true
      t.references :post_outside, foreign_key: true
      t.string :headline
      t.text :introduction
      t.string :title
      t.string :image_id
      t.integer :category
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
