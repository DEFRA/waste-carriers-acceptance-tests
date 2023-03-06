require_relative "sections/govuk_banner"

class FinancePaymentMethodPage < BasePage

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  # How was this payment made?
  element(:cash, "#payment_form_payment_type_cash", visible: false)
  element(:cheque, "#payment_form_payment_type_cheque", visible: false)
  element(:postal, "#payment_form_payment_type_postal_order", visible: false)
  element(:transfer, "#payment_form_payment_type_bank_transfer", visible: false)
  element(:missed_card, "#payment_form_payment_type_missed_card", visible: false)

  def submit(args = {})
    case args[:choice]
    when :cash
      cash.click
    when :cheque
      cheque.click
    when :postal
      postal.click
    when :transfer
      transfer.click
    when :missed_card
      missed_card.click
    end
    submit_button.click
  end

end
