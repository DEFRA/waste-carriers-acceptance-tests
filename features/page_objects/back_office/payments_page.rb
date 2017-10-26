class PaymentsPage < SitePrism::Page

  # Enter payment

  element(:amount_due, "#amountDue")
  element(:payment_amount, "#payment_amount")
  element(:payment_day, "#payment_dateReceived_day")
  element(:payment_month, "#payment_dateReceived_month")
  element(:payment_year, "#payment_dateReceived_year")
  element(:payment_ref, "#payment_registrationReference")
  element(:payment_type, "select#payment_paymentType")
  element(:payment_comment, "#payment_comment")

  element(:enter_payment, "#enter_payment_btn")

  

    def submit(args = {})
    amount_due.set(args[:amount_due]) if args.key?(:amount_due)
    payment_amount.set(args[:payment_amount]) if args.key?(:payment_amount)
    payment_day.set(args[:payment_day]) if args.key?(:payment_day)
    payment_month.set(args[:payment_month]) if args.key?(:payment_month)
    payment_year.set(args[:payment_year]) if args.key?(:payment_year)
    payment_ref.set(args[:payment_ref]) if args.key?(:payment_ref)
    payment_type.select(args[:payment_type]) if args.key?(:payment_type)
    payment_comment.set(args[:payment_comment]) if args.key?(:payment_comment)

    enter_payment.click
  end


end
