class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.integer :member, foreign_key: true, null: false
      t.integer :post,  foreign_key: true, null: false
      t.timestamps
    end
  end
end
