class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :name_sort_by
      t.string :artist
      t.string :artist_sort_by
      t.string :album
      t.string :album_sort_by
      t.references :poll, foreign_key: true
      t.string :itunes_id
      t.string :itunes_preview
      t.string :itunes_art

      t.timestamps
    end
  end
end
