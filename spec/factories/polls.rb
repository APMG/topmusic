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

FactoryGirl.define do
  factory :poll do
    slug 'mypoll-2016'
    name 'MyPoll 2016'
    selectable 'Song'
    open_date '2016-09-30 12:28:05'
    close_date '2016-10-30 12:28:05'
  end
end
