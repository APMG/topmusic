# frozen_string_literal: true

require 'colorize'
require 'open-uri'

namespace :album_art do
  desc 'Fetch the album art from Cover Art Archive for songs with album_mbid'
  task fetch_album_art: :environment do
    Song.where.not(album_mbid: nil).where(has_art: nil).each do |song|
      puts song.album_mbid
      art_path = Rails.root.join('public', 'art', "#{song.album_mbid}.jpg")
      if art_path.exist?
        puts "Art for #{song.album.blue} by #{song.artist.blue} already exists"
        unless song.has_art
          song.has_art = true
          song.save
        end
        next
      end

      image_url = "http://coverartarchive.org/release-group/#{song.album_mbid}/front-500"
      begin
        File.open(art_path, 'w') do |f|
          IO.copy_stream(open(image_url), f)
        end
      rescue OpenURI::HTTPError => e
        if e.io.status.first.to_i < 500
          # OpenURI creates a zero byte file on 404
          art_path.delete if art_path.exist?
          song.has_art = false
          song.save
          puts "Cover Art Archive does not have art for #{song.album.blue} by #{song.artist.blue}"
          next
        else
          puts 'We are being rate limited'.red
          puts 'Aborting execution'.red
          break
        end
      end
      puts "Wrote art for #{song.album.blue} by #{song.artist.blue} to #{art_path.to_s.blue}"
      song.has_art = true
      song.save
      # There are currently no rate limiting rules in place
      # However, let's not be jerks
      sleep 1
    end
  end
end
