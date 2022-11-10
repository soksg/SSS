class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.integer :post, foreign_key: true, null: false
      t.string :name, null: false
      t.integer :longitude, null: false
      t.integer :latitude, null: false
      t.string :url, null: false
      t.string :phone_number, null: false
      t.string :post_code, null: false
      t.string :location, null: false
      t.text :description
      t.timestamps
    end
  end
end
