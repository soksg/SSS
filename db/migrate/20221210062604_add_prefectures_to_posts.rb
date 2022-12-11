class AddPrefecturesToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :prefecture, :string, null: false
  end
end
