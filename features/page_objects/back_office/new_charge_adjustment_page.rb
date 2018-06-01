class NewChargeAdjustmentPage < SitePrism::Page

  # Write off difference

  element(:amount, "#order_totalAmount")

  element(:reference, "#order_order_item_reference")

  element(:description, "#order_description")

  element(:submit_button, "input[value='Enter charge adjustment']")

  def submit(args = {})
    amount.set(args[:amount]) if args.key?(:amount)
    reference.set(args[:reference]) if args.key?(:reference)
    description.set(args[:description]) if args.key?(:description)
    submit_button.click
  end

end
