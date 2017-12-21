# frozen_string_literal: true

class User
  def initialize(auth_hash)
    @auth_hash = auth_hash

    raise InvalidUid, 'Invalid User ID' if @auth_hash['uid'].blank?
  end

  def expiration
    Time.zone.at(@auth_hash['credentials']['expires_at'])
  end

  def expired?
    expiration < Time.zone.now
  end

  def name
    @auth_hash['info']['name']
  end

  def gravatar
    @auth_hash['extra']['raw_info']['user']['gravatar']
  end

  def uid
    @auth_hash['uid']
  end

  def logged_in?
    true
  end

  def to_json
    @auth_hash.to_json
  end

  class Anonymous
    def expiration
      Time.zone.now + 1.year
    end

    def expired?
      false
    end

    def name
      'Anonymous User'
    end

    def gravatar
      ''
    end

    def uid
      'anonymous'
    end

    def logged_in?
      false
    end

    def to_json
      # Used in session store.
      nil.to_json
    end
  end

  class InvalidUid < StandardError; end
end
