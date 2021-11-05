class CreatePostTags < ActiveRecord::Migration[5.2]
  def change
    create_table :post_tags do |t|
      t.references :post_summary, foreign_key: true
      t.references :tag, foreign_key: true
      t.datetime :created_at
      t.datetime :update_at

      t.timestamps
    end
  end
end
