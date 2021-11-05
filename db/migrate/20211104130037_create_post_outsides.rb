class CreatePostOutsides < ActiveRecord::Migration[5.2]
  def change
    create_table :post_outsides do |t|
      t.references :post_summary, foreign_key: true
      t.text :address
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
