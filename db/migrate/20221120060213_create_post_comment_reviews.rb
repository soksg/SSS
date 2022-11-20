class CreatePostCommentReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comment_reviews do |t|
      t.integer :post_comment_id,  foreign_key: true, null: false
      t.timestamps
    end
  end
end
