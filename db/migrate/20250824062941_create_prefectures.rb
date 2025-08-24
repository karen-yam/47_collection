class CreatePrefectures < ActiveRecord::Migration[7.2]
  def change
    create_table :prefectures do |t|
      t.string :name, null: false
      t.text :icon

      t.timestamps
    end
  end
end
