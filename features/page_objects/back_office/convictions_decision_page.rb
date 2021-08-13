class ConvictionsDecisionPage < SitePrism::Page

  # Approve a renewal with possible convictions: CBDU2
  # Reject a renewal with possible convictions: CBDU2

  element(:heading, "h1")
  element(:conviction_reason, "textarea[id*='form_revoked_reason']")
  element(:submit_button, "input[name='commit']")

  def submit(args = {})
    conviction_reason.set(args[:conviction_reason]) if args.key?(:conviction_reason)
    submit_button.click
  end

end
