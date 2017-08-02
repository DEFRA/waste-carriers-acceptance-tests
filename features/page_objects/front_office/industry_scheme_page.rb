class IndustrySchemePage < SitePrism::Page

  element(:cwm, "#radio-1", visible: false)
  element(:esa, "#radio-2", visible: false)
  element(:getting_qualification, "#radio-3", visible: false)

  element(:industry_scheme_info, "#industrySchemeDetails")

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    case args[:choice]
    when :chartered_institute_of_wastes_management
      cwm.select_option
    when :environmental_services_association
      esa.select_option
    when :getting_qualification
      getting_qualification.select_option
      industry_scheme_info.set(args[:industry_scheme_info]) if args.key?(:industry_scheme_info)
    end

    submit_button.click
  end

end
