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

class Ballot < ApplicationRecord
  MAX_SELECTABLES = 10
  PUBLIC_UID_LENGTH = 9 # Provides a search space of roughly 104 trillion
  MAX_FREEFORM_SELECTIONS = 4

  belongs_to :poll
  has_many :selections, inverse_of: :ballot, dependent: :destroy
  has_many :songs, through: :selections

  accepts_nested_attributes_for :selections

  validates :user_id, uniqueness: { scope: [:poll_id] }
  validate :max_selectables

  def selectables
    public_send(poll.selectable.downcase.pluralize.to_s.to_sym)
  end

  def selectable_ids
    public_send("#{poll.selectable.downcase}_ids".to_sym)
  end

  def selectable_ids=(*args)
    public_send("#{poll.selectable.downcase}_ids=".to_sym, *args)
  end

  def generate_public_uid!
    # 36 is the base where once converted, you have lowercase alpha-num ascii.
    self.public_uid = SecureRandom.random_number(36**PUBLIC_UID_LENGTH).to_s(36)
  end

  def to_param
    public_uid
  end

  private

  def max_selectables
    return if selectables.size <= MAX_SELECTABLES
    errors.add(:base, "More than #{MAX_SELECTABLES} #{poll.selectable.downcase.pluralize} selected")
  end
end
