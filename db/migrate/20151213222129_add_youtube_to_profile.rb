class AddYoutubeToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :youtube, :string
  end
end
