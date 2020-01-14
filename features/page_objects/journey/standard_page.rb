# frozen_string_literal: true

class StandardPage < SitePrism::Page

  # This is a generic page object file used for simple, standard pages, to prevent adding lots of separate files

  element(:back_link, ".link-back")
  element(:error_summary, ".error-summary")
  element(:heading, ".heading-large")
  element(:content, "#content")
  element(:button, ".button")

end
