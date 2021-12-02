require_relative "sections/govuk_banner"

class FinanceChargeAdjustInputPage < BasePage

  # Positive/Negative charge adjustment (debit) for CBDU1

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:back_link, ".govuk-back-link")

  element(:amount_form, "input[id*='charge_adjust_form_amount']")
  element(:reference_form, "input[id*='charge_adjust_form_reference']")
  element(:reason_form, "#with-hint")

  def submit(args = {})
    amount_form.set(args[:amount]) if args.key?(:amount)
    reference_form.set(args[:reference]) if args.key?(:reference)
    reason_form.set(args[:reason]) if args.key?(:reason)

    submit_button.click
  end

end
