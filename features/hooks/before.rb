# frozen_string_literal: true

# Because of the way Cucumber is put together with everything loaded in the
# global namespace and no main() method to speak of, there doesn't seem to be
# any better way of persisting state between runs.
# rubocop:disable Style/GlobalVars
Before do
  $world_state ||= World.new
  @world = $world_state
end

Before("@data") do
  # We use this before hook to generate some data so that scenarios that
  # rely on there being some existing data don't have to create them as part
  # of their tests. For example we have multiple scenarios that involve
  # searching for a registration. Without this hook to support running them
  # independently each one would have to create the registrations it needs. Now
  # we can create them once here saving time and effort in the tests themselves.
  $seeded_data ||= false

  unless $seeded_data
    seed_backend_users
    # Clears session otherwise any scenario which attempts to login first would
    # fail as we are already logged in.
    Capybara.reset_session!
  end

  $seeded_data = true
end

# clears emails from mailcatcher before running tests if running tests locally
Before("@email") do
  if @world.email.local?
    @world.email.mailcatcher_main_page.load
    @world.email.mailcatcher_main_page.clear_all_messages.click
    popup = page.driver.browser.switch_to.alert
    popup.accept
  end
end
