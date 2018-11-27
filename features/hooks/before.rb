require "quke/configuration"
Before do
  # This 'before' hook ensures that the page is
  # resized before every scenario when run headlessly.
  Capybara.page.current_window.resize_to(1280, 800) if Capybara.current_driver == :phantomjs
end

# clears emails from mailcatcher before running tests if running tests locally
Before("@email") do
  @email_app = EmailApp.new
  if (Quke::Quke.config.custom["urls"]["mail_client"]).include? "local"
    @email_app.mailcatcher_main_page.load
    @email_app.mailcatcher_main_page.clear_all_messages.click
    popup = page.driver.browser.switch_to.alert
    popup.accept
  end
end
