# frozen_string_literal: true

class NormalizeSortable
  STOPWORDS = %w[
    the
    a
    an
  ].freeze

  def initialize(str)
    @str = str
  end

  def sortable
    @str.downcase
        .tr('^a-z0-9 ', '')
        .split(' ')
        .reject { |token| STOPWORDS.include? token }
        .join(' ')
  end
end
