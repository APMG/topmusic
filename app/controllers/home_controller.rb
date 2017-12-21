# frozen_string_literal: true

class HomeController < ApplicationController
  def show
    @polls = Poll.all.sort_by(&:updated_at).reverse
  end
end
