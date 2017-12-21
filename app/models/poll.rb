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

class Poll < ApplicationRecord
  SELECTABLES = %w[Song].freeze

  validates :selectable, inclusion: { in: SELECTABLES, message: '%<value> is not a valid selectable' }

  def selectables
    klass = selectable.constantize
    klass.where poll: self
  end

  def to_param
    slug
  end

  def closed?
    return if close_date.nil?
    close_date <= Time.zone.now
  end
end
