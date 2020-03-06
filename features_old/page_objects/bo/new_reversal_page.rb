class NewReversalPage < SitePrism::Page

  # Enter reversal

  element(:payment_comment, "#payment_comment")
  element(:enter_reversal, "input[value='Enter reversal']")

  def submit(args = {})
    payment_comment.set(args[:payment_comment]) if args.key?(:payment_comment)
    enter_reversal.click
  end

end
