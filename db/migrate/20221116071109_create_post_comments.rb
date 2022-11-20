class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.text :comment
      t.integer :post_comment_review_id,  foreign_key: true, null: false
      t.integer :member_id,  foreign_key: true, null: false
      t.integer :post_id,  foreign_key: true, null: false
      t.integer :star

      t.timestamps
    end
  end
end
