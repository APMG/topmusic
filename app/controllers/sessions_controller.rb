# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def log_in # rubocop:disable Metrics/AbcSize
    # Only set relative URLs to avoid leaving the site on auth.
    if params['from'] && params['from'] != '' && !params['from'].starts_with?('/')
      raise InvalidFromPathError, "Path #{params['from']} is not relative."
    end
    session[:post_auth_url] = params['from']
    redirect_to '/auth/apm_accounts'
  end

  def create
    session[:user_data] = User.new(auth_hash).to_json
    redirect_to(session[:post_auth_url] || '/')
  end

  def log_out
    reset_session
    poll = Poll.find_by(slug: params['poll'])
    if poll
      redirect_to poll
    else
      redirect_to 'http://www.thecurrent.org/'
    end
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  class InvalidFromPathError < StandardError; end
end
