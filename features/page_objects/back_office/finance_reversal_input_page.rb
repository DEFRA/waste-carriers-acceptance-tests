require_relative "sections/govuk_banner"

class FinanceReversalInputPage < SitePrism::Page

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)
  element(:heading, ".heading-large")

  element(:reason_form, "#reversal_form_reason")
  element(:submit_button, ".button")

  def submit(args = {})
    reason_form.set(args[:reason]) if args.key?(:reason)
    submit_button.click
  end

end
