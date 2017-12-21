# frozen_string_literal: true

# == Schema Information
#
# Table name: songs
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  name_sort_by   :string(255)
#  artist         :string(255)
#  artist_sort_by :string(255)
#  album          :string(255)
#  album_sort_by  :string(255)
#  poll_id        :integer
#  album_mbid     :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Song, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
