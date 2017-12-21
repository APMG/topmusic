# frozen_string_literal: true

Given(/^a poll$/) do
  @poll = create :poll
end

Given(/^a logged in user$/) do
  stub_request(:post, 'https://oauthprovider.example.com/oauth/token')
    .with(body: { 'client_id' => 'DUMMY_KEY', 'client_secret' => 'DUMMY_SECRET', 'code' => 'DUMMY_CODE', 'grant_type' => 'authorization_code', 'redirect_uri' => 'http://example.org/auth/apm_accounts/callback' },
          headers: { 'Content-Type' => 'application/x-www-form-urlencoded' })
    .to_return(status: 200, body: {
      'access_token' => '2YotnFZFEjr1zCsicMWpAA',
      'token_type' => 'bearer',
      'expires_in' => 3600,
      'refresh_token' => 'tGzv3JOkF0XG5Qx2TlKWIA',
      'code' => 'DUMMY_CODE'
    }.to_json, headers: { 'Content-Type' => 'application/json' })
  stub_request(:get, 'https://oauthprovider.example.com/api/v1/me.json')
    .with(headers: { 'Authorization' => 'Bearer 2YotnFZFEjr1zCsicMWpAA' })
    .to_return(status: 200, body: {
      'user' => {
        'uid' => 'ajskhdgfkjhagfsdh',
        'profile' => {
          'first_name' => 'Test',
          'last_name' => 'User'
        }
      }
    }.to_json, headers: { 'Content-Type' => 'application/json' })

  get '/auth/apm_accounts'
  # Get CSRF token.
  state = CGI.parse(URI(last_response['Location']).query)['state'].first
  get "/auth/apm_accounts/callback?code=DUMMY_CODE&state=#{state}"
end

When(/^I visit the login path$/) do
  get '/log_in?from=/blah'
end

When(/^I visit a poll page$/) do
  get poll_path(@poll.slug)
end

When(/^I visit the OmniAuth auth path$/) do
  get '/auth/apm_accounts'
end

Then(/^I am redirected to the login site$/) do
  expect(last_response.status).to eq 302
  expect(last_response['Location']).to start_with 'https://oauthprovider.example.com/oauth/authorize'
  expect(last_response['Location']).to include 'DUMMY_KEY'
end

Then(/^I am redirected to the OmniAuth auth path$/) do
  expect(last_response.status).to eq 302
  expect(last_response['Location']).to eq 'http://example.org/auth/apm_accounts'
end

Then(/^I am sent to a new ballot$/) do
  expect(last_response.status).to eq 302
  expect(last_response['Location']).to eq "http://example.org#{new_poll_ballot_path(@poll.slug)}"
end
