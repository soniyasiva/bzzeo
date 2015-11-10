class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.references :profile, index: true, foreign_key: true
      t.references :friend, references: :profiles
      t.boolean :mutual

      t.timestamps null: false
    end
  end
end
