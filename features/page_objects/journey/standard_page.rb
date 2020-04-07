# frozen_string_literal: true

class StandardPage < SitePrism::Page

  # This is a generic page object file used for simple, standard pages, to prevent adding lots of separate files

  element(:back_link, ".link-back")
  element(:error_summary, ".error-summary")
  element(:heading, ".heading-large")
  element(:content, "#content")
  element(:button, ".button")
  element(:submit_button, "input[type='submit']")

  def submit(_args = {})
    submit_button.click
  end
end
