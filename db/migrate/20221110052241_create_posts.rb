class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :member, foreign_key: true, null: false
      t.integer :spot,  foreign_key: true, null: false

      t.timestamps
    end
  end
end
