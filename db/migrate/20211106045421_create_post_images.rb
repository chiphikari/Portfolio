class CreatePostImages < ActiveRecord::Migration[5.2]
  def change
    create_table :post_images do |t|
      t.string :image_id
      t.references :post_summary, foreign_key: true
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
