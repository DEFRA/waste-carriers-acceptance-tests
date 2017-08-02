class PreAppDiscussionPage < SitePrism::Page

  # Have you discussed your application with us?
  element(:pre_app_yes_with_ref, "#yesRefName", visible: false)
  element(:pre_app_ref, "#preAppDiscussionRefName", visible: false)

  element(:pre_app_yes_no_ref, "#yesNoRef", visible: false)

  element(:pre_app_no, "#noPreApp", visible: false)

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    case args[:choice]
    when :pre_app_with_ref
      pre_app_yes_with_ref.select_option
      pre_app_ref.set(args[:pre_app_ref]) if args.key?(:pre_app_ref)

    when :pre_app_no_ref
      pre_app_yes_no_ref.select_option

    when :no_pre_app
      pre_app_no.select_option
    end

    submit_button.click
  end

end
