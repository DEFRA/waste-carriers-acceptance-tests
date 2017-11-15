class RevokePage < SitePrism::Page

  # Revoke registration

  element(:revoked_reason, "#registration_metaData_revokedReason")

  element(:submit_button, "#revokeButton")

  def submit(args = {})
    revoked_reason.set(args[:revoked_reason]) if args.key?(:revoked_reason)

    submit_button.click
  end

end
