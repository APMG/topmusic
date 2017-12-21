class AddHasArtToSong < ActiveRecord::Migration[5.0]
  def change
    add_column :songs, :has_art, :boolean
  end
end
