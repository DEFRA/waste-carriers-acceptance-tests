class ApproveConvictionsPage < SitePrism::Page

  element(:approval_reason, "#conviction_approval_form_revoked_reason")
  element(:submit_button, "input[name='commit']")

  def submit(args = {})
    approval_reason.set(args[:approval_reason]) if args.key?(:approval_reason)
    submit_button.click
  end

end
