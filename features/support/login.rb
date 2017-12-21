# frozen_string_literal: true

# Set to test mode, except for tagged tests.
OmniAuth.config.test_mode = true

Around('@real_omniauth') do |_scenario, block|
  OmniAuth.config.test_mode = false
  block.call
  OmniAuth.config.test_mode = true
end
