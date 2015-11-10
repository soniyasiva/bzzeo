class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :html
      t.string :slug

      t.timestamps null: false
    end
    add_index :pages, :slug, unique: true
  end
end
