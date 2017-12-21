class MakePollSlugUnique < ActiveRecord::Migration[5.0]
  def change
    add_index :polls, :slug, unique: true
  end
end
