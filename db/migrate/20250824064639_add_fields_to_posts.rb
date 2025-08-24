class AddFieldsToPosts < ActiveRecord::Migration[7.2]
  def change
    add_reference :posts, :prefecture, null: false, foreign_key: true
    add_column :posts, :image, :string
    add_reference :posts, :category, null: false, foreign_key: true
  end
end
