class RemoveStatusFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :status, :string
  end
end
