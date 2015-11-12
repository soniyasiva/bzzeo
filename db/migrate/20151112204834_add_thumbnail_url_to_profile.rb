class AddThumbnailUrlToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :thumbnail_url, :string
  end
end
