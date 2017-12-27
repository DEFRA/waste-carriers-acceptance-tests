require "quke/configuration"
Before do
  # This 'before' hook ensures that the page is
  # resized before every scenario when run headlessly.
  Capybara.page.current_window.resize_to(1280, 800) if Capybara.current_driver == :phantomjs
end
