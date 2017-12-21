# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NormalizeSortable do
  let(:str) { 'blah' }
  let(:normalizer) { NormalizeSortable.new str }

  describe '#sortable' do
    subject { normalizer.sortable }

    it('is passed through') { is_expected.to eq 'blah' }

    context 'with mixed case' do
      let(:str) { 'BlAh' }
      it('becomes lower case') { is_expected.to eq 'blah' }
    end

    context 'with stopwords' do
      let(:str) { 'The BlAh' }
      it('removes stopwords') { is_expected.to eq 'blah' }
    end

    context 'with symbols' do
      let(:str) { 'The "BlAh"' }
      it('removes symbols') { is_expected.to eq 'blah' }
    end
  end
end
