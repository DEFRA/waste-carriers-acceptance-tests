class DeregistrationConfirmationPage < BasePage

  element(:confirm, "#deregistration-confirmation-form-temp-confirm-deregistration-yes-field", visible: false)
  element(:reject, "#deregistration-confirmation-form-temp-confirm-deregistration-no-field", visible: false)

  def submit(args = {})
    case args[:choice]
    when :confirm
      confirm.click
    when :reject
      reject.click
    end
    submit_button.click
  end

end
