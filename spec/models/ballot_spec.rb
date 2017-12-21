# frozen_string_literal: true

# == Schema Information
#
# Table name: ballots
#
#  id         :integer          not null, primary key
#  user_id    :string(255)      not null
#  poll_id    :integer          not null
#  public_uid :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_name  :string(255)
#

require 'rails_helper'

RSpec.describe Ballot, type: :model do
  let(:selectable) { 'Song' }
  let(:poll) { create :poll, selectable: selectable }

  describe '#max_selectables' do
    it 'is valid when not too many selectables' do
      ballot = create :ballot, poll: poll
      song1 = create :song, poll: poll
      song2 = create :song, poll: poll
      ballot.selections.create song: song1
      ballot.selections.create song: song2

      expect(ballot).to be_valid
    end

    it 'is not valid when too many selectables' do
      ballot = create :ballot, poll: poll
      songs = create_list :song, Ballot::MAX_SELECTABLES + 1, poll: poll
      songs.each { |song| ballot.selections.create song: song }

      expect(ballot).to_not be_valid
      expect(ballot.errors[:base]).to eq ['More than 10 songs selected']
    end
  end

  describe '#selectables' do
    context 'with Song as the selectable' do
      let(:selectable) { 'Song' }
      it 'returns a list of songs' do
        ballot = create :ballot, poll: poll
        song1 = create :song, poll: poll
        song2 = create :song, poll: poll
        ballot.selections.create song: song1
        ballot.selections.create song: song2

        expect(ballot.selectables).to eq [song1, song2]
      end
    end
  end

  describe '#selectable_ids' do
    context 'with Song as the selectable' do
      let(:selectable) { 'Song' }
      it 'returns a list of song ids' do
        ballot = create :ballot, poll: poll
        song1 = create :song, poll: poll
        song2 = create :song, poll: poll
        ballot.selections.create song: song1
        ballot.selections.create song: song2

        expect(ballot.selectable_ids).to eq [song1, song2].map(&:id)
      end
    end
  end

  describe '#selectable_ids=' do
    context 'with Song as the selectable' do
      let(:selectable) { 'Song' }
      it 'returns a list of song ids' do
        ballot = create :ballot, poll: poll
        song1 = create :song, poll: poll
        song2 = create :song, poll: poll
        songs = [song1, song2]

        ballot.selectable_ids = songs.map(&:id)

        expect(ballot.songs).to eq songs
      end
    end
  end
end
