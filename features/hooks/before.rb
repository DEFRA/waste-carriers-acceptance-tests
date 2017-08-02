Before("@backoffice") do
  # Dynamics appears to have a minimum size it will support. Going below it
  # meant things like the signout menu and button were no longer visible and
  # hence tests started failing. This 'before' hook ensures that the page is
  # resized before every back office scenario. The size selected is based on the
  # smallest available on UTC's within the EA.
  Capybara.page.current_window.resize_to(1280, 768)
end
