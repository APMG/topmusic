# frozen_string_literal: true

require 'colorize'
require 'musicbrainz'

namespace :album_art do
  desc 'Try to find art for albums lacking it in the public/art directory'
  task find_existing_art: :environment do
    Song.where.not(album_mbid: nil).where.not(has_art: true).each do |song|
      puts song.to_s
      art_path = Rails.root.join('public', 'art', "#{song.album_mbid}.jpg")
      if art_path.exist?
        puts "Art for #{song.album.blue} by #{song.artist.blue} already exists"
        unless song.has_art
          song.has_art = true
          song.save
        end
        next
      end

      puts "We do not have art for #{song.album.blue} by #{song.artist.blue}"
    end
  end
end
