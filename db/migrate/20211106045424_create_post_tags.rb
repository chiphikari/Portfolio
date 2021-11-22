class CreatePostTags < ActiveRecord::Migration[5.2]
  def change
    create_table :post_tags do |t|
      t.references :post_summary, type: :bigint, null: false, foreign_key: true
      t.references :tag, type: :bigint, null: false, foreign_key: true

      t.timestamps
    end
  end
end
