# frozen_string_literal: true

class BallotsController < ApplicationController
  before_action :redirect_new_account, only: %i[show new]
  before_action :validate_logged_in!, only: %i[edit update create]
  before_action :load_poll
  before_action :validate_poll_open, only: %i[edit update create new]
  before_action :load_ballot, only: %i[show edit update]

  def new # rubocop:disable Metrics/AbcSize
    existing_ballot = Ballot.find_by poll: @poll, user_id: current_user.uid
    if existing_ballot
      redirect_to edit_poll_ballot_path(@poll, existing_ballot.public_uid), success: 'You previously submitted a ballot'
      return
    end

    @ballot = Ballot.new poll: @poll, user_id: current_user.uid

    remaining_freeform_ballots = Ballot::MAX_FREEFORM_SELECTIONS - @ballot.selections.freeform.size
    remaining_freeform_ballots.times { |_i| @ballot.selections.new freeform: '' }
  end

  def create # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    @ballot = Ballot.new
    @ballot.poll = @poll
    @ballot.assign_attributes sanitized_params
    @ballot.user_id = current_user.uid
    @ballot.user_name = current_user.name
    @ballot.generate_public_uid!

    @ballot.selections.each do |sel|
      sel.mark_for_destruction if sel.completely_blank?
    end

    if @ballot.save
      redirect_to poll_ballot_path(@poll, @ballot.public_uid), success: 'Thanks for voting!'
    else
      remaining_freeform_ballots = Ballot::MAX_FREEFORM_SELECTIONS - @ballot.selections.freeform.size
      remaining_freeform_ballots.times { |_i| @ballot.selections.new freeform: '' }

      render 'new'
    end
  end

  def show; end

  def edit
    raise AccessDeniedError if current_user.uid != @ballot.user_id

    remaining_freeform_ballots = Ballot::MAX_FREEFORM_SELECTIONS - @ballot.selections.freeform.size
    remaining_freeform_ballots.times { |_i| @ballot.selections.new freeform: '' }
  end

  def update # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    raise AccessDeniedError if current_user.uid != @ballot.user_id

    @ballot.assign_attributes(sanitized_params)

    @ballot.selections.each do |sel|
      sel.mark_for_destruction if sel.completely_blank?
    end

    if @ballot.save
      redirect_to poll_ballot_path(@poll, @ballot.public_uid), success: 'Thanks for voting!'
    else
      remaining_freeform_ballots = Ballot::MAX_FREEFORM_SELECTIONS - @ballot.selections.freeform.size
      remaining_freeform_ballots.times { |_i| @ballot.selections.new freeform: '' }

      render 'edit'
    end
  end

  private

  def validate_poll_open
    render 'polls/closed' if @poll.closed?
  end

  def validate_logged_in!
    raise AccessDeniedError unless current_user.logged_in?
  end

  def load_poll
    @poll = Poll.find_by! slug: params[:poll_id]
  end

  def load_ballot
    @ballot = Ballot.find_by! poll: @poll, public_uid: params[:id]
  end

  def sanitized_params
    params.require(:ballot).permit(selectable_ids: [], selections_attributes: %i[freeform id])
  end

  def redirect_new_account
    return unless params['activity'] == 'after-account-create'
    redirect_to helpers.log_in_path
  end
end
