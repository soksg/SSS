class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.text :comment
      t.integer :member_id,  foreign_key: true, null: false
      t.integer :post_id,  foreign_key: true, null: false
      t.integer :star, :integer, default: 0, null: false

      t.timestamps
    end
  end
end
