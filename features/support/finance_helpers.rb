# Functions that can be reused to help with finance

def pay_by_cash(amount_in_pounds)
  @bo.finance_payments_page.submit(choice: :cash)
  @bo.cash_payment_page.submit(
    amount: amount_in_pounds.to_s,
    day: "01",
    month: "01",
    year: "1980",
    reference: "0101010",
    comment: "cash money"
  )
end
