class TierFarmOnlyPage < SitePrism::Page

  # Do you ever deal with: Farm or agricultural waste ...?
  element(:heading, ".heading-large")
  element(:only_these_types, "#waste_types_form_only_amf_yes", visible: false)
  element(:other_types, "#waste_types_form_only_amf_no", visible: false)
  element(:submit_button, ".button")

  def submit(args = {})
    case args[:choice]
    when :yes
      only_these_types.click
    when :no
      other_types.click
    end
    submit_button.click
  end

end
