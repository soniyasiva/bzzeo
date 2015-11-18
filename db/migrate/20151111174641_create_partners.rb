class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.references :profile, index: true, foreign_key: true
      t.references :partner, references: :profiles

      t.timestamps null: false
    end
  end
end
