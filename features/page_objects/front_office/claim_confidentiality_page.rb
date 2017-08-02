class ClaimConfidentialityPage < SitePrism::Page

  # Is part of your application commercially confidential?
  element(:no, "#notConfClaim", visible: false)
  element(:yes, "#yesConfClaim", visible: false)

  element(:reason, "#confidentialReasonsGroup")

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    case args[:choice]
    when :confidential
      yes.select_option
      reason.set(args[:reason]) if args.key?(:reason)
    when :not_confidential
      no.select_option
    end

    submit_button.click
  end

end
