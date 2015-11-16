class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.references :profile, index: true, foreign_key: true
      t.references :viewed, references: :profiles

      t.timestamps null: false
    end
  end
end
