# rubocop:disable Style/FrozenStringLiteralComment

require 'csv'

class CsvVotableSong
  ROW_ORDER = {
    # year: 0,
    # local: 1,
    artist: 0,
    title: 1,
    album: 2,
    # spins: 5,
  }.freeze

  def initialize(row)
    @row = row
  end

  ROW_ORDER.each do |method, idx|
    define_method method do
      @row[idx] || ''
    end
  end

  def to_song
    Song.new do |song|
      song.name = title
      song.artist = artist
      song.album = album
      song.name_sort_by = NormalizeSortable.new(title).sortable
      song.artist_sort_by = NormalizeSortable.new(artist).sortable
      song.album_sort_by = NormalizeSortable.new(album).sortable
    end
  end
end

namespace :import do
  desc 'Pull in CSV'
  task csv: :environment do
    poll = Poll.find_by! slug: ENV['POLL_NAME']
    poll.selectables.destroy_all

    CSV.foreach(ENV['CSV_FILENAME']) do |row|
      # Skip headers
      # Include BOM
      next if row[0] == "Artist"
      next unless row.reject { |field| field.nil? || field == '' }.any?

      csv_song = CsvVotableSong.new row
      song = csv_song.to_song
      song.poll = poll
      song.save!
      #  itunes_id      :string(255)
      #  itunes_preview :string(255)
      #  itunes_art     :string(255)
    end
  end
end
