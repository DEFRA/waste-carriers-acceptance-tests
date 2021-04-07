require_relative "sections/govuk_banner"

class FinancePaymentInputPage < SitePrism::Page

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)
  element(:heading, ".heading-large")
  element(:content, "#content")

  # Add a payment. Inputs change ID based on payment method.
  element(:amount, "input[id*='_payment_form_amount']")
  element(:day, "input[id*='_payment_form_date_received_day']")
  element(:month, "input[id*='_payment_form_date_received_month']")
  element(:year, "input[id*='_payment_form_date_received_year']")
  element(:reference, "input[id*='_payment_form_registration_reference']")
  element(:comment, "textarea[id*='_payment_form_comment']")

  element(:submit_button, "input[name='commit']")

  def submit(args = {})
    amount.set(args[:amount])
    day.set(args[:day]) if args.key?(:day)
    month.set(args[:month]) if args.key?(:month)
    year.set(args[:year]) if args.key?(:year)
    reference.set(args[:reference]) if args.key?(:reference)
    comment.set(args[:comment]) if args.key?(:comment)

    submit_button.click
  end

end
