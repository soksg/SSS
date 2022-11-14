class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :member, foreign_key: true, null: false
      t.string :name, null: false
      t.string :address, null: false
      t.float :longitude, null: false
      t.float :latitude, null: false
      t.string :url, null: false
      t.string :phone_number, null: false
      t.string :opening_hour, null: false
      t.text :description

      t.timestamps
    end
  end
end
