require "quke/configuration"
Before do
  # This 'before' hook ensures that the page is
  # resized before every scenario.
  Capybara.page.current_window.resize_to(1280, 800)
end
