class WasteTypesPage < SitePrism::Page

  # Do you only deal with the following waste?
  element(:yes_only, "#waste_types_form_only_amf_yes", visible: false)
  element(:not_only, "#waste_types_form_only_amf_no", visible: false)
  element(:heading, :xpath, "//h1[contains(text(), 'Do you only deal')]")
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    case args[:choice]
    when :yes_only
      yes_only.click
    when :not_only
      not_only.click
    end
    submit_button.click
  end

end
