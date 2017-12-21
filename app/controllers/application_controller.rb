# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # http://api.rubyonrails.org/classes/ActionController/ConditionalGet.html#method-i-expires_now
  before_action :expires_now

  def current_user
    @current_user ||= begin
      if session[:user_data]
        session[:post_auth_url] = nil
        User.new(JSON.parse(session[:user_data]))
      else
        User::Anonymous.new
      end
    end
  end
  helper_method :current_user

  def not_found
    raise PageNotFoundError, 'No root page'
  end

  # Used for application global views.
  def view_poll
    @poll || NilPoll.new
  end
  helper_method :view_poll

  class AccessDeniedError < StandardError; end
  class PageNotFoundError < StandardError; end

  # NullObject Poll for the views.
  class NilPoll
    def title
      'Top Music'
    end

    def description
      'Making lists Top Music.'
    end

    def long_title
      'Top Music'
    end

    def slug
      'generic'
    end
  end
end
