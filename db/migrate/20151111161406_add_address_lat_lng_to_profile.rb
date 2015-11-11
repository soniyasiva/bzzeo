class AddAddressLatLngToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :address, :string
    add_column :profiles, :lat, :float
    add_column :profiles, :lng, :float
  end
end
