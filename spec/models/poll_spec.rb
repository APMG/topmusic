# frozen_string_literal: true

# == Schema Information
#
# Table name: polls
#
#  id           :integer          not null, primary key
#  slug         :string(255)
#  name         :string(255)
#  selectable   :string(255)
#  open_date    :datetime
#  close_date   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  long_title   :string(255)
#  description  :text(65535)
#  twitter_text :text(65535)
#

require 'rails_helper'

RSpec.describe Poll, type: :model do
  let(:poll) { build :poll }

  describe '#selectable=' do
    before(:each) { poll.selectable = selectable }
    subject { poll }
    context 'with Song' do
      let(:selectable) { 'Song' }
      it { is_expected.to be_valid }
    end
    context 'with Blah' do
      let(:selectable) { 2321 }
      it { is_expected.to be_invalid }
      it 'is not a valid selectable' do
        subject.validate
        expect(subject.errors[:selectable]).to eq [' 2321s not a valid selectable']
      end
    end
  end

  describe '#selectables' do
    subject { poll.selectables }

    context 'with Song' do
      let(:poll) { super().tap { |p| p.selectable = 'Song' } }

      let!(:song) { create :song, poll: poll }

      it { is_expected.to eq [song] }
    end
  end
end
