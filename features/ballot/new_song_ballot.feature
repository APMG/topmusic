Feature: Select songs from ballot

  Scenario: I pick my 10 songs and write in 5 extra items
    Given a poll
      And a set of songs
    When I visit a poll
      # And I log in
      # And I select my desired 10 songs
      # And I write in my 5 extra songs
      # And I click submit
    # Then my ballot is stored in the database
      # And I am redirected to the sharable page

  Scenario: I pick too many songs
    Given a poll
      And a set of songs
    When I visit a poll
      # And I log in
      # And I select my desired 15 songs
      # And I click submit
    # Then I am still on the form page
      # And I see the too many songs error
      # And the songs I previously selected are still selected

  Scenario: I pick no songs

  Scenario: I visit the ballot when I've already voted
