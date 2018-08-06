class RegistrationExportPage < SitePrism::Page

  # Waste carrier registrations search

  element(:back_link, :xpath, "//a[contains(.,'Back')]")

  element(:report_from_date, "#report_from")
  element(:report_to_date, "#report_to")

  # Filters

  # Registration route
  element(:digital, "#routes_digital")
  element(:ad, "#routes_assisted_digital")

  # Registration tier
  element(:upper_tier, "#tiers_upper")
  element(:lower_tier, "#tiers_lower")

  # Registration status
  element(:status_active, "#statuses_active")

  # Business type
  element(:ltd_company, "#business_types_limitedcompany")

  # Copy cards
  element(:new_registration_copy_cards, "#copy_cards_scope_new")

  # Convictions
  element(:declared_convictions, "#report_has_declared_convictions")
  element(:convictions_match, "#report_conviction_check_match")

  element(:submit_button, "input[value='Search']")

  def submit(args = {})
    report_from_date.set(args[:report_from_date]) if args.key?(:report_from_date)
    report_to_date.set(args[:report_to_date,]) if args.key?(:report_to_date)
    convictions_match.click if args.key?(:convictions_match) && args[:convictions_match]

    submit_button.click
  end

end
