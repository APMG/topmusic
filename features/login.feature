Feature: Log in

  @real_omniauth
  Scenario: User is not logged in and visits poll
    Given a poll
    When I visit the login path
    # Then I am redirected to the OmniAuth auth path

  @real_omniauth
  Scenario: User is not logged in and visits OmniAuth login path
    When I visit the OmniAuth auth path
    Then I am redirected to the login site

  @real_omniauth
  Scenario: User is logged in
    Given a poll
    Given a logged in user
    When I visit a poll page
    # Then I am sent to a new ballot
