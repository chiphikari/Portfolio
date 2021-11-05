class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.references :user, foreign_key: true
      t.references :post_summary, foreign_key: true
      t.datetime :created_at
      t.datetime :update_at

      t.timestamps
    end
  end
end
