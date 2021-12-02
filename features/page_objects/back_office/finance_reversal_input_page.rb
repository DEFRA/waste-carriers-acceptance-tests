require_relative "sections/govuk_banner"

class FinanceReversalInputPage < BasePage

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:reason_form, "#reversal-form-reason-field")

  def submit(args = {})
    reason_form.set(args[:reason]) if args.key?(:reason)
    submit_button.click
  end

end
