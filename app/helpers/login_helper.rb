# frozen_string_literal: true

module LoginHelper
  def log_in_path
    params = {
      from: request.path
    }
    "/log_in?#{params.to_query}"
  end

  def new_account_path
    params = {
      name: 'Topmusic',
      from: request.original_url
    }
    "#{Rails.configuration.oauth_provider}/users/sign_up?#{params.to_query}"
  end
end
