# frozen_string_literal: true

# == Schema Information
#
# Table name: songs
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  name_sort_by        :string(255)
#  artist              :string(255)
#  artist_sort_by      :string(255)
#  album               :string(255)
#  album_sort_by       :string(255)
#  poll_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  album_mbid          :string(255)
#  album_mb_title      :string(255)
#  album_mb_confidence :integer
#  album_mb_lookup     :boolean          default(FALSE)
#  has_art             :boolean
#

FactoryGirl.define do
  factory :song do
    sequence(:name) { |i| "The Song No. #{i}" }
    sequence(:name_sort_by) { |i| "Song No. #{i}, The" }
    sequence(:artist) { |i| "The Band No. #{i}" }
    sequence(:artist_sort_by) { |i| "Band No. #{i}, The" }
    sequence(:album) { |i| "The Album No. #{i}" }
    sequence(:album_sort_by) { |i| "Album No. #{i}, The" }

    # poll nil
    album_mbid 'MyString'
  end
end
