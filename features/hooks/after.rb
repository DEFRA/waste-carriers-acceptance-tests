# frozen_string_literal: true

# Because of the way Cucumber is put together with everything loaded in the
# global namespace and no main() method to speak of, there doesn't seem to be
# any better way of persisting state between runs.
# rubocop:disable Style/GlobalVars
After do
  $world_state = @world

  # A number of our tests start with logging in. Rather than peppering our steps
  # with calls to click the log out link, we can use this hook which is called
  # after every scenario to ensure the session is reset and you don't
  # automatically login during the next scenario.
  # We also think its better that the session is reset for each scenario to
  # ensure there are no dependencies that might lead to false results.
  Capybara.reset_session!
end
# rubocop:enable Style/GlobalVars
