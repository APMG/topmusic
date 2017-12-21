# frozen_string_literal: true

require 'colorize'
require 'musicbrainz'

namespace :album_art do
  desc 'Fetch the best match from MusicBrainz based on song and artist name. Retry failed lookups by setting RETRY_FAILED to some value in your shell.'
  task alternate_mbid: :environment do
    MusicBrainz.configure do |c|
      c.app_name = ''
      c.app_version = '1.0'
      c.contact = ''

      # Querying config
      c.query_interval = 1.5 # seconds
      c.tries_limit = 2
    end

    song_query = Song.where(album_mb_lookup: false).where.not(album: nil)

    # Set RETRY_FAILED to a value in bash to retry failed lookups
    if ENV['RETRY_FAILED']
      song_query = Song.where(album_mbid: nil).where.not(album: nil)
      puts 'Retrying failed lookups ...'.yellow
    end

    song_query.each do |song|
      mb_recording = MusicBrainz::Recording.search(song.name, song.artist)
      if mb_recording.respond_to?(:first) && mb_recording.first
        puts "A match other than #{song.album.blue} was found: #{mb_recording.first[:releases].first.blue}".yellow
        mb_lookup = MusicBrainz::ReleaseGroup.search(
          mb_recording.first[:artist],
          mb_recording.first[:releases].first
        )
      end

      if mb_lookup.respond_to?(:first) && mb_lookup.first
        song.album_mbid = mb_lookup.first[:mbid]
        song.album_mb_title = mb_lookup.first[:title]
        song.album_mb_confidence = mb_lookup.first[:score]
        puts "MBID added to #{song.name.blue} with " +
             "#{song.album_mb_confidence}% confidence".green +
             ": #{song.album_mbid}"
      else
        puts 'MusicBrainz has no record of album for '.red +
             song.name.to_s
      end
      song.save
    end
  end
end
