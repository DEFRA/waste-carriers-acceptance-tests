class SelectPermitPage < SitePrism::Page

  # Select a permit
  elements(:permits, "input[name='chosenPermitID']", visible: false)

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    if args.key?(:permits)
      permits.find { |btn| btn.value == args[:permits] }.click
    end

    submit_button.click
    # only valid for prototype
    # click_on "Next"
  end

end
