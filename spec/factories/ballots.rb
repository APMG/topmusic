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

FactoryGirl.define do
  factory :ballot do
    user_id SecureRandom.hex(10)
    # poll nil
    public_uid SecureRandom.hex(10)
  end
end
