class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :member_id,  foreign_key: true, null: false
      t.integer :post_id,  foreign_key: true, null: false
      t.integer :star, null: false
      t.text :comment
      t.timestamps
    end
  end
end
