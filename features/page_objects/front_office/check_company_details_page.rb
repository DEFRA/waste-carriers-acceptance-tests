class CheckCompanyDetailsPage < SitePrism::Page

  # Check company details
  element(:incorrect_address, "a[href$='wrong-company-details']")
  element(:main_address, "#radio-1", visible: false)
  element(:not_main_address, "#radio-2", visible: false)

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    case args[:choice]
    when :main_address
      main_address.select_option
    when :incorrect_address
      not_main_address.select_option
    end
    submit_button.click
  end

end
