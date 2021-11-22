class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :user, type: :bigint, null: false, foreign_key: true
      t.references :post_summary, type: :bigint, null: false, foreign_key: true
      t.float :score, null: false
      t.string :content

      t.timestamps
    end
  end
end
