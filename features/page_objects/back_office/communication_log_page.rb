# frozen_string_literal: true

# require_relative "sections/admin_menu_section"

class CommunicationLogPage < BasePage

  # section(:admin_menu_section, AdminMenuSection, AdminMenuSection::SELECTOR)

  element(:template_title, ".govuk-summary-list__row:nth-child(1) .govuk-summary-list__value")
  element(:recipient, ".govuk-summary-list__row:nth-child(4) .govuk-summary-list__value")
  element(:content, ".govuk-summary-list__row:nth-child(8) .govuk-summary-list__value")

end
