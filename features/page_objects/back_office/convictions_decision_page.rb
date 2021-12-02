class ConvictionsDecisionPage < BasePage

  # Approve a renewal with possible convictions: CBDU2
  # Reject a renewal with possible convictions: CBDU2
  element(:conviction_reason, "textarea[id*='form_revoked_reason']")

  def submit(args = {})
    conviction_reason.set(args[:conviction_reason]) if args.key?(:conviction_reason)
    submit_button.click
  end

end
