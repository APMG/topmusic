# frozen_string_literal: true

# Custom exception handler to forward some error messages to route.
class CustomPublicExceptions < ActionDispatch::PublicExceptions
  HANDLED_CODES = %w[401 404].freeze

  def call(env)
    status = env['PATH_INFO'][1..-1]

    if HANDLED_CODES.include? status
      Rails.application.routes.call(env)
    else
      super
    end
  end
end
