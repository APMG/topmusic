# frozen_string_literal: true

# Handle display of error pages.
class ErrorsController < ApplicationController
  def error401
    render formats: :html, status: :unauthorized
  end

  def error404
    render formats: :html, status: :not_found
  end
end
