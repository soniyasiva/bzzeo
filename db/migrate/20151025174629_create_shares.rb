class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.references :post, index: true, foreign_key: true
      t.references :profile, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
