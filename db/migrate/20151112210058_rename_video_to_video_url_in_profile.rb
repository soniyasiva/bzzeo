class RenameVideoToVideoUrlInProfile < ActiveRecord::Migration
  def change
    rename_column :profiles, :video, :video_url
  end
end
