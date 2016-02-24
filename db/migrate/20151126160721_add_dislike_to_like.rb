class AddDislikeToLike < ActiveRecord::Migration
  def change
    add_column :likes, :dislike, :boolean
  end
end
