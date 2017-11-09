class ApprovePage < SitePrism::Page

  # Approve registration

  element(:conviction_match_info, :xpath, ".//*[@id='revoke']/fieldset/div[1]/div[5]")
  element(:approval_reason, "#registration_metaData_approveReason")

  element(:submit_button, "#approveButton")

  def submit(args = {})
    approval_reason.set(args[:approval_reason]) if args.key?(:approval_reason)

    submit_button.click
  end

end
