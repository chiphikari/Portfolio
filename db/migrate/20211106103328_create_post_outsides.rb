class CreatePostOutsides < ActiveRecord::Migration[5.2]
  def change
    create_table :post_outsides do |t|
      t.references :post_summary, type: :bigint, null: false, foreign_key: true
      t.text :address, null: false
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
