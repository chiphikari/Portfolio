class CreatePostHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :post_houses do |t|
      t.references :post_summary, type: :bigint, null: false, foreign_key: true
      t.text :link, null: false

      t.timestamps
    end
  end
end
