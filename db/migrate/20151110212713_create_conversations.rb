class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :sender, references: :profiles
      t.references :receiver, references: :profiles
      t.text :message
      t.boolean :read

      t.timestamps null: false
    end
  end
end
