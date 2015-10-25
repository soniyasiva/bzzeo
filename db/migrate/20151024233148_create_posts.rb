class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :image_url
      t.string :video_url
      t.text :description
      t.references :profile, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
