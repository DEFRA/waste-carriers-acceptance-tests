require_relative "sections/govuk_banner.rb"

class CashPaymentPage < SitePrism::Page

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  # Add a cash payment
  element(:amount, "#cash_payment_form_amount")
  element(:day, "#cash_payment_form_date_received_day")
  element(:month, "#cash_payment_form_date_received_month")
  element(:year, "#cash_payment_form_date_received_year")
  element(:reference, "#cash_payment_form_registration_reference")
  element(:comment, "#cash_payment_form_comment")

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
