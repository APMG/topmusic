# frozen_string_literal: true

class PollsController < ApplicationController
  before_action :load_poll, except: :closed

  def show
    redirect_to new_poll_ballot_path(poll_id: @poll.slug)
  end

  def closed; end

  private

  def load_poll
    @poll = Poll.find_by! slug: params['id']
  end
end
