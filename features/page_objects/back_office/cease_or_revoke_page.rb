class CeaseOrRevokePage < BasePage

  # Revoke or cease registration CBDU1

  element(:revoke_radio, "#cease_or_revoke_form_metaData_status_revoked", visible: false)
  element(:cease_radio, "#cease_or_revoke_form_metaData_status_inactive", visible: false)
  element(:reason_box, "#cease_or_revoke_form_metaData_revoked_reason")

  def submit(args = {})
    # Select revoke or cease (or nothing) and set reason:
    case args[:choice]
    when :revoke
      revoke_radio.click
    when :cease
      cease_radio.click
    end
    reason_box.set(args[:reason]) if args.key?(:reason)
    submit_button.click
  end

end
