class WasteTypesPage < SitePrism::Page

  # Do you only deal with the following waste?
  element(:yes_only, "#waste_types_form_only_amf_true", visible: false)
  element(:not_only, "#waste_types_form_only_amf_false", visible: false)
  element(:heading, :xpath, "//h1[contains(text(), 'Do you only deal')]")
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    wait_for_yes_only
    find("label", text: (args[:answer])).click if args.key?(:answer)
    submit_button.click
  end

end
