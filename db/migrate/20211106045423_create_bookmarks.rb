class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post_summary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
