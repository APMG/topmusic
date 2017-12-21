# frozen_string_literal: true

Given(/^a set of songs$/) do
  create_list :song, 30, poll: @poll
end

When(/^I visit a poll$/) do
  visit poll_path(@poll.slug)
end

When(/^I log in$/) do
  within '.toolbar' do
    click_link 'Log In'
  end
end

When(/^I select my desired (\d+) songs$/) do |n|
  @n_selected = n.to_i
  within '#new_ballot' do
    all(:css, "input[name='ballot[selectable_ids][]']")[0...@n_selected].each do |elem|
      elem.set(true)
    end
  end
end

When(/^I write in my (\d+) extra songs$/) do |_arg1|
  within '#new_ballot' do
    # find(:css, "#cityID[value='62']").set(true)
  end
end

When(/^I click submit$/) do
  within '#new_ballot' do
    click_button 'Submit your ballot'
  end
end

Then(/^my ballot is stored in the database$/) do
  expect(Ballot.count).to eq 1
  ballot = Ballot.first
  expect(ballot.selections.count).to eq 10
end

Then(/^I am redirected to the sharable page$/) do
  # TODO: figure this out when it is time.
end

Then(/^I am still on the form page$/) do
  expect(current_path).to eq poll_ballots_path(@poll)
end

Then(/^I see the too many songs error$/) do
  expect(page).to have_content 'More than 10 songs selected'
end

Then(/^the songs I previously selected are still selected$/) do
  within '#new_ballot' do
    checkboxes = all(:css, "input[name='ballot[selectable_ids][]']")
    checked_checkboxes = checkboxes[0...@n_selected]
    unchecked_checkboxes = checkboxes[@n_selected..-1]
    expect(checked_checkboxes.map(&:checked?).uniq).to eq [true]
    expect(unchecked_checkboxes.map(&:checked?).uniq).to eq [false]

    # TODO: This should work, but doesn't. Figure out what is going on...
    # expect(checked_checkboxes).to all be_checked
    # expect(unchecked_checkboxes).to all be_checked
  end
end
