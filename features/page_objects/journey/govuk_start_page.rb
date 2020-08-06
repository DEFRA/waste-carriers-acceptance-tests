class GovukStartPage < SitePrism::Page

  # Main entry point into the service.
  # Not within our team's direct control, but included in regression tests to make sure links are up to date.

  element(:heading, ".gem-c-title__text")
  element(:start_now_button, ".gem-c-button--bottom-margin")

end
