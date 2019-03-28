# frozen_string_literal: true

# Because of the way Cucumber is put together with everything loaded in the
# global namespace and no main() method to speak of, there doesn't seem to be
# any better way of persisting state between runs.
# rubocop:disable Style/GlobalVars
Before do
  $world_state ||= World.new
  @world = $world_state
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
