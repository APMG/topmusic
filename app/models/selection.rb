# frozen_string_literal: true

# == Schema Information
#
# Table name: selections
#
#  id         :integer          not null, primary key
#  ballot_id  :integer
#  song_id    :integer
#  freeform   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Selection < ApplicationRecord
  belongs_to :ballot, inverse_of: :selections
  belongs_to :song, optional: true

  scope :freeform, -> { where.not(freeform: nil) }

  def completely_blank?
    song_id.nil? && (freeform.nil? || freeform == '')
  end
end
