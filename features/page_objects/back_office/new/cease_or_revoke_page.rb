class CeaseOrRevokePage < SitePrism::Page

  # Revoke or cease registration CBDU1

  # TODO: add new pages to site map

  element(:back_link, ".link-back")
  element(:error_summary, ".error-summary")
  element(:heading, ".heading-large")

  element(:revoke_radio, "#cease_or_revoke_form_metaData_status_revoked", visible: false)
  element(:cease_radio, "#cease_or_revoke_form_metaData_status_inactive", visible: false)
  element(:reason_box, "#cease_or_revoke_form_metaData_revoked_reason")
  element(:confirm_button, ".button")

  def submit(args = {})
    # Select revoke or cease (or nothing) and set reason:
    case args[:choice]
    when :revoke
      revoke_radio.click
    when :cease
      cease_radio.click
    end
    reason_box.set(args[:reason]) if args.key?(:reason)
    confirm_button.click
  end

end
