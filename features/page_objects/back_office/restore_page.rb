class RestorePage < BasePage

  # Restore registration CBDU74

  element(:reason_box, "#registration-restore-form-restored-reason-field")

  def submit(args = {})
    reason_box.set(args[:reason]) if args.key?(:reason)
    submit_button.click
  end

end
