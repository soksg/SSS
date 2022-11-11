class CreateTagPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_posts do |t|
      t.integer :post, foreign_key: true, null: false
      t.integer :tag,  foreign_key: true, null: false
      t.timestamps
    end
  end
end