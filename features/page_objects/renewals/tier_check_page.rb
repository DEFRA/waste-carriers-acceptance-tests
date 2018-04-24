class TierCheckPage < SitePrism::Page

  # Do you ever deal with waste from other businesses or households?
  element(:check_tier, "#tier_check_form_temp_tier_check_true", visible: false)
  element(:skip_check, "#tier_check_form_temp_tier_check_false", visible: false)
  element(:heading, :xpath, "//h1[contains(text(), 'DYou are renewing an upper tier registration')]")
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    wait_for_check_tier
    find("label", text: (args[:answer])).click if args.key?(:answer)
    submit_button.click
  end

end
