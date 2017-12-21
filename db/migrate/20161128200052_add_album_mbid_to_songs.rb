class AddAlbumMbidToSongs < ActiveRecord::Migration[5.0]
  def change
    add_column :songs, :album_mbid, :string
    add_column :songs, :album_mb_title, :string
    add_column :songs, :album_mb_confidence, :integer
    add_column :songs, :album_mb_lookup, :boolean, default: false
  end
end
