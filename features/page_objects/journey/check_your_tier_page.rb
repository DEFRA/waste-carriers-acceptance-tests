class CheckYourTierPage < SitePrism::Page

  # What type of tier are you?
  element(:error_summary, ".error-summary")
  elements(:check_your_tier_options, "input[type='radio']", visible: false)

  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    if args.key?(:option)
      check_your_tier_options.find do |option|
        option.value == args[:option].to_s
      end.click
    end

    # Options are:
    # unknown (= I don't know)
    # lower
    # upper

    submit_button.click
  end
end
