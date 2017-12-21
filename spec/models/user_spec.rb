# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:expires_at) { (Time.zone.now + 1.day).to_i }
  let(:name) { 'Test User' }
  let(:gravatar) { 'blahblahblah' }
  let(:uid) { 'skjdhglfkahdlksjhalkfjhs' }
  let(:auth_hash) do
    {
      'uid' => uid,
      'credentials' => {
        'expires_at' => expires_at
      },
      'info' => {
        'name' => name
      },
      'extra' => {
        'raw_info' => {
          'user' => {
            'gravatar' => gravatar
          }
        }
      }
    }
  end
  let(:user) { User.new auth_hash }

  describe '#expiration' do
    subject { user.expiration }
    it { is_expected.to eq(Time.zone.at(expires_at)) }
  end

  describe '#expired?' do
    subject { user.expired? }

    it { is_expected.to eq false }

    context 'with time in the past' do
      let(:expires_at) { (Time.zone.now - 1.day).to_i }

      it { is_expected.to eq true }
    end
  end

  describe '#name' do
    subject { user.name }

    it { is_expected.to eq 'Test User' }
  end

  describe '#gravatar' do
    subject { user.gravatar }

    it { is_expected.to eq 'blahblahblah' }
  end

  describe '#uid' do
    subject { user.uid }

    it { is_expected.to eq 'skjdhglfkahdlksjhalkfjhs' }
  end

  describe '#to_json' do
    subject { user.to_json }

    it do
      Timecop.freeze(Time.zone.parse('2016-01-01T00:00:00Z')) do
        is_expected.to eq '{"uid":"skjdhglfkahdlksjhalkfjhs","credentials":{"expires_at":1451692800},"info":{"name":"Test User"},"extra":{"raw_info":{"user":{"gravatar":"blahblahblah"}}}}'
      end
    end
  end
end
