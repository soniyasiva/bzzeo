class AddMentionToPost < ActiveRecord::Migration
  def change
    add_reference :posts, :mention, references: :profiles
  end
end
