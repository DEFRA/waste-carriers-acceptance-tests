# frozen_string_literal: true

class StandardPage < SitePrism::Page

  # This is a generic page object file used for simple, standard pages, including:
  #  - footer links (privacy, cookies, accessibility)

  element(:back_link, ".link-back")
  element(:heading, ".heading-large")
  element(:content, "#content")

end
