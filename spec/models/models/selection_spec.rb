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

require 'rails_helper'

RSpec.describe Selection, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
