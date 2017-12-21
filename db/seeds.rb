# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

poll = Poll.create(slug: 'top89-2016', name: 'Top89 2016', selectable: 'Song')
20.times do |i|
  Song.create do |s|
    s.name = "The Song No. #{i}"
    s.name_sort_by = "Song No. #{i}, The"
    s.artist = "The Band No. #{i}"
    s.artist_sort_by = "Band No. #{i}, The"
    s.album = "The Album No. #{i}"
    s.album_sort_by = "Album No. #{i}, The"
    s.poll = poll
  end
end
