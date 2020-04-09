class RegistrationSearchResultsPage < SitePrism::Page

  element(:export_all, "#export_btn")

  element(:submit_button, "#approveButton")

  element(:back_link, :xpath, "//a[contains(.,'Back')]")

  sections :registrations, "table tbody tr" do
    element(:registration_number, "td:nth-child(1)")
    element(:company_name, "td:nth-child(2)")
    element(:status, "td:nth-child(37)")
  end

  def registration(registration_number)
    # TODO: Fix this. When the tests have run multiple times, the registration
    # we search for might not be in the first 100 results shown, and hence without
    # clearing the database features calling this step fail.
    registrations.each do |registration|
      return registration if registration.registration_number.text == registration_number
    end
    nil
  end

end
