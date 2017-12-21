# frozen_string_literal: true

require 'colorize'
require 'musicbrainz'

namespace :album_art do
  desc 'Fetch the MBID from MusicBrainz and store it in the database to use for album art lookup'
  task fetch_mbid: :environment do
    MusicBrainz.configure do |c|
      c.app_name = ''
      c.app_version = '1.0'
      c.contact = ''

      # Querying config
      c.query_interval = 1.5 # seconds
      c.tries_limit = 2
    end

    poll = Poll.find_by slug: ENV['POLL_NAME']

    album_query = Song.where(album_mb_lookup: false, poll: poll).where.not(album: nil)
    puts "There are #{album_query.count} songs for #{ENV['POLL_NAME']}".yellow

    # Set RETRY_FAILED to a value in bash to retry failed lookups
    if ENV['RETRY_FAILED']
      album_query = Song.where(album_mbid: nil).where.not(album: nil)
      puts 'Retrying failed lookups ...'.yellow
    end

    album_query = album_query.select(%i[album artist]).distinct
    album_query.each do |song|
      puts "#{song.album.blue} by #{song.artist.blue}"

      begin
        mb_lookup = MusicBrainz::ReleaseGroup.search(
          song.artist, song.album.chomp('(Single)')
        )
      rescue StandardError
        puts "MusicBrainz lookup failed for album with name #{song.album}".red
        next
      end

      Song.where(album: song.album).where(artist: song.artist).each do |album_song|
        # Mark this song as one we've already looked up via MusicBrainz
        album_song.album_mb_lookup = true

        if mb_lookup.respond_to?(:first) && mb_lookup.first
          album_song.album_mbid = mb_lookup.first[:mbid]
          album_song.album_mb_title = mb_lookup.first[:title]
          album_song.album_mb_confidence = mb_lookup.first[:score]
          puts "MBID added to #{album_song.name.blue} with " +
               "#{album_song.album_mb_confidence}% confidence".green +
               ": #{album_song.album_mbid}"

        else
          puts 'MusicBrainz has no record of album for '.red +
               album_song.name.to_s
        end

        album_song.save
      end
    end
  end
end
