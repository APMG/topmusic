class RemoveItunesFromSongs < ActiveRecord::Migration[5.0]
  def change
    remove_column :songs, :itunes_id, :string
    remove_column :songs, :itunes_preview, :string
    remove_column :songs, :itunes_art, :string
  end
end
