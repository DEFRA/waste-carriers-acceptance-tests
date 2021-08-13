require_relative "sections/govuk_banner"

class FinanceReversalInputPage < SitePrism::Page

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)
  element(:heading, "h1")

  element(:reason_form, "#reversal-form-reason-field")
  element(:submit_button, "[type='submit']")

  def submit(args = {})
    reason_form.set(args[:reason]) if args.key?(:reason)
    submit_button.click
  end

end
